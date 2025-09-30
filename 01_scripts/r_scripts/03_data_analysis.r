#load tidyverse and broom package
library(tidyverse)
library(broom)
library(here)
  
#set output directory for analysis script 
cleandata_csv <- here("02_outdata", "penguins_clean.csv")
outdir        <- here("02_outdata")
anova_txt     <- here("02_outdata", "anova_sex_by_species.txt")
means_csv     <- here("02_outdata", "group_means_ci.csv")
assump_txt    <- here("02_outdata", "assumption_checks.txt")

#ensure output directory exists - create of not
dir.create(outdir, showWarnings = FALSE, recursive = TRUE)

#output directory for supplementary files created during data analysis
anova_txt <- file.path(outdir, "anova_sex_by_species.txt")
means_csv <- file.path(outdir, "group_means_ci.csv")
assump_txt<- file.path(outdir, "assumption_checks.txt")

#Data analysis
cleandata <- read.csv(cleandata_csv) %>%
  mutate(
    species = factor(species),
    sex     = factor(sex, levels = c("female","male"))
  )

#two-way ANOVA (linear model)
fit <- lm(bill_length_mm ~ sex * species, data = cleandata)

# ANOVA table 
aov_tab <- anova(fit)

# Save ANOVA + model summary
sink(anova_txt)
cat("Two-way ANOVA: bill_length_mm ~ sex * species\n\n")
print(aov_tab)
cat("\n\nModel summary:\n")
print(summary(fit))
sink()

#Estimated means & 95% CI by Sex within Species 
means <- cleandata %>%
  group_by(species, sex) %>%
  summarise(
    n = dplyr::n(),
    mean = mean(bill_length_mm),
    sd   = sd(bill_length_mm),
    se   = sd/sqrt(n),
    ci95_low  = mean + qt(0.025, df = n - 1) * se,
    ci95_high = mean + qt(0.975, df = n - 1) * se,
    .groups = "drop"
  )
write.csv(means, means_csv, row.names = FALSE)

#Model assupmtions
res <- resid(fit); fitvals <- fitted(fit)
sink(assump_txt)
cat("Shapiro-Wilk test of residual normality:\n")
print(shapiro.test(res))
cat("\nLevene-like check via SD by group (rule-of-thumb):\n")
print(cleandata %>% group_by(species, sex) %>% summarise(sd = sd(bill_length_mm), n=dplyr::n()))
cat("\nIf assumptions look violated, report and add a robustness note (e.g., Welch ANOVA within species).\n")
sink()

