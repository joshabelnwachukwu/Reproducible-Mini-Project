---
editor_options: 
  markdown: 
    wrap: 72
---

# Reproducible Mini-Project - Penguin Bill Dimorphism 

## Purpose

Quantify sexual dimorphism in bill length across penguin species
(Adelie, Chinstrap, Gentoo) using the palmerpenguinsdataset. This
project was designed as part of a reproducible research workflow
exercise as part of the LDP2025W Productivity and Reproducibilty in
Ecology and Evolution course

## Project Structure

-   `00_rawdata/` — original data (`penguins_raw.csv`)
    + `DATA-DICTIONARY.md`

-   `01_scripts/` — numbered scripts to reproduce analysis

    -   `01_get_data.R` — Script used to acquire and save raw data

    -   `02_clean_data.R` — Script used for cleaning and filtering data

    -   `03_analysis.R` — Script used for analyzing data

    -   `04_figures.R` — Script used to generate figures

-   `02_outdata/` — cleaned datasets, summary tables, and analysis
    outputs

-   `03_figs/` — exported figures (`.png`)

-   `04_manuscript/` — manuscript source file (`manuscript.Rmd`)

-   `renv/` — project environment (for reproducibility)

-   `README.md` — overview and instructions

## How to Reproduce

1.  Open `Reproducible-Mini-Project.Rproj` in RStudio.

2.  Install the following packages and initialize the environment:

    ```         
    install.packages(c("palmerpenguins","tidyverse","janitor","broom","knitr"))
    # optional but recommended:
    # renv::init()
    # renv::snapshot()
    ```

3.  Run scripts in order:

    -   `01_scripts/01_get_data.R`

    -   `01_scripts/02_clean_data.R`

    -   `01_scripts/03_analysis.R`

    -   `01_scripts/04_figures.R`

4.  Knit the manuscript:

    -   Open `04_manuscript/manuscript.Rmd`

    -   Click **Knit to PDF** (or HTML)
