#Install tidyverse and janitor packages
install.packages("tidyverse")
install.packages("janitor")

#load tidyverse and janitor packages
library(tidyverse)
library(janitor)
  
#access penguins raw csv files
infile  <- file.path("00_rawdata", "penguins.csv")
#change directory so that output writes to the correct directory 
outdir  <- "02_outdata"
#create cleaned penguins csv file in outdata directory
outfile <- file.path(outdir, "penguins_clean.csv")
#create data dictionary in outdata directory after cleaning
dictcsv <- file.path(outdir, "penguins_data_dictionary.csv")

#Create outdata directory
dir.create(outdir, showWarnings = FALSE, recursive = TRUE)

#Start Cleaning Data
rawdata <- read.csv(infile, check.names = FALSE, na.strings = c("", "NA"))
clean <- rawdata %>%
  clean_names() %>% #standardizing column names
  select(species, island, sex, year, bill_length_mm) %>% #select relevent columns
  mutate(
    species = fct_drop(as.factor(species)),
    sex     = case_when(
      is.na(sex) ~ NA_character_,
      tolower(sex) %in% c("female","f") ~ "female",
      tolower(sex) %in% c("male","m")   ~ "male",
      TRUE ~ NA_character_
    ),
    sex = factor(sex, levels = c("female","male"))
  ) %>%
  filter(!is.na(bill_length_mm), !is.na(sex), !is.na(species)) #filter data to only remove rows where bill length sex or species is missing

#save cleaned data
write.csv(clean, outfile, row.names = FALSE)

# ---- Minimal data dictionary ----
dict <- tibble::tribble(
  ~column,          ~type,     ~description,
  "species",        "factor",  "Adelie, Chinstrap, Gentoo",
  "island",         "factor",  "Island in Palmer Archipelago",
  "sex",            "factor",  "female, male",
  "year",           "integer", "Year of sampling",
  "bill_length_mm", "numeric", "Culmen length (mm)"
)
write.csv(dict, dictcsv, row.names = FALSE)


