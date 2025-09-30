# Raw Data - Palmer Penguins

## Purpose

This folder contains the raw dataset used in the mini-project *Sexual Dimorphism in Penguin Bill Length Across Species*.\
The dataset provides morphometric data from the **Palmer Archipelago, Antarctica (2007–2009)** and is the basis for all analyses described in the preregistration.

## Contents

-   `penguins_raw.csv`: The original dataset used for this project.\
-   `DATA-DICTIONARY.md`: Describes each variable, its type, and coding scheme.

## Data Source

The raw data come from the **palmerpenguins R package** (Horst, Hill, & Gorman, 2020), which provides cleaned, teaching-friendly versions of the original field data (Gorman, Williams, & Fraser, 2014).\
- Package website: <https://allisonhorst.github.io/palmerpenguins/>\
- Data were originally collected by field biologists in the Palmer Archipelago.

## Variables (see also `DATA-DICTIONARY.md`)

-   **species**: Adelie, Chinstrap, Gentoo\
-   **island**: Biscoe, Dream, Torgersen\
-   **sex**: female, male\
-   **year**: Year of sampling (2007–2009)\
-   **bill_length_mm**: Culmen length in millimeters

## Notes on Usage

-   The raw dataset is unmodified.\
-   Missing values occur where sex or bill length could not be recorded.\
-   Cleaning (in `01_scripts/02_clean_data.R`) standardizes column names, selects relevant variables, and filters out rows with missing `species`, `sex`, or `bill_length_mm`.\
-   The cleaned dataset is saved to `02_outdata/penguins_clean.csv`, and a corresponding data dictionary is generated (`penguins_data_dictionary.csv`).

## References

-   Horst, A. M., Hill, A. P., & Gorman, K. B. (2020). *palmerpenguins: Palmer Archipelago (Antarctica) penguin data*. R package version 0.1.0. <https://allisonhorst.github.io/palmerpenguins/>\
-   Gorman, K. B., Williams, T. D., & Fraser, W. R. (2014). Ecological sexual dimorphism and environmental variability within a community of Antarctic penguins (genus *Pygoscelis*). *PLoS ONE, 9*(3), e90081. <https://doi.org/10.1371/journal.pone.0090081>
