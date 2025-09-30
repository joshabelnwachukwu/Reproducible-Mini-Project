library(tidyverse)
library(here)

#acess analysis scripts and set figure output directory
clean_csv <- here("02_outdata", "penguins_clean.csv")
means_csv <- here("02_outdata", "group_means_ci.csv")
figdir    <- here("03_figs")

#Output files for both plots
p1_file <- file.path(figdir, "bill_length_by_sex_faceted_species.png")
p2_file <- file.path(figdir, "interaction_means_ci.png")

#set data for figures
cleandata  <- read.csv(clean_csv) %>% mutate(species = factor(species), sex = factor(sex, levels = c("female","male")))
means <- read.csv(means_csv) %>% mutate(species = factor(species), sex = factor(sex, levels = c("female","male")))

#Figure 1: Distribution by sex within species
p1 <- ggplot(cleandata, aes(x = sex, y = bill_length_mm)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.15, alpha = 0.5, size = 1) +
  facet_wrap(~ species, nrow = 1) +
  labs(x = "Sex", y = "Bill length (mm)", title = "Bill length by sex across species") +
  theme_minimal(base_size = 12)
print(p1)
ggsave(p1_file, p1, width = 9, height = 3.2, dpi = 300)

#Figure 2: Interaction plot (means with 95% CI)
p2 <- ggplot(means, aes(x = species, y = mean, group = sex)) +
  geom_line(aes(linetype = sex)) +
  geom_point(aes(shape = sex), size = 2) +
  geom_errorbar(aes(ymin = ci95_low, ymax = ci95_high), width = 0.1) +
  labs(x = "Species", y = "Mean bill length (mm)", title = "Sex × species interaction (means ± 95% CI)", linetype = "Sex", shape = "Sex") +
  theme_minimal(base_size = 12)
print(p2)
ggsave(p2_file, p2, width = 7.5, height = 4, dpi = 300)


