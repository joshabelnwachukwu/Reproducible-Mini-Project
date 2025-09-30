#Create reproducible data directories  
dir.create("00_rawdata", showWarnings = FALSE, recursive = TRUE)
dir.create("02_outdata", showWarnings = FALSE, recursive = TRUE)

# Load palmerpenguins package
library(palmerpenguins)

# View datasets in palmerpenguins package
data(package = "palmerpenguins")

# View 'penguins' data (1/2 from palmerpenguins)
head(penguins)
# Size measurements for adult foraging penguins near Palmer Station, Antarctica

# View 'penguins_raw' data (2/2 from palmerpenguins)
head(penguins_raw)
# Penguin size, clutch, and blood isotope data for foraging adults near Palmer Station, Antarctica

# Ensure raw data folder exists
dir.create("00_rawdata", showWarnings = FALSE, recursive = TRUE)

# Write penguins data into a CSV in the raw data folder
outfile <- file.path("00_rawdata", "penguins_raw.csv")
write.csv(penguins, outfile, row.names = FALSE)
