#Load package
library(tidyverse)
library(broom)

#Set filepaths and data directories
outdir     <- "02_outdata"
clean_csv  <- file.path(outdir, "penguins_clean.csv")
anova_txt  <- file.path(outdir, "anova_sex_by_species.txt")
means_csv  <- file.path(outdir, "group_means_ci.csv")
assump_txt <- file.path(outdir, "assumption_checks.txt")

# Ensure output directory exists
dir.create(outdir, showWarnings = FALSE, recursive = TRUE)

#read clean data
cleandata <- read.csv(clean_csv) %>%
  mutate(
    species = factor(species),
    sex     = factor(sex, levels = c("female","male"))
  )

# ---- Two-way ANOVA (linear model) ----
fit <- lm(bill_length_mm ~ sex * species, data = cleandata)
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

#Model assumptions
res <- resid(fit); fitvals <- fitted(fit)
sink(assump_txt)
cat("Shapiro-Wilk test of residual normality:\n")
print(shapiro.test(res))
cat("\nLevene-like check via SD by group (rule-of-thumb):\n")
print(
  cleandata %>%
    group_by(species, sex) %>%
    summarise(sd = sd(bill_length_mm), n = dplyr::n(), .groups = "drop")
)
cat("\nIf assumptions look violated, report and add a robustness note (e.g., Welch ANOVA within species).\n")
sink()


