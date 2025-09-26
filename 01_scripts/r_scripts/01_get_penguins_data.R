#Create reproducible data directories  
dir.create("00_rawdata", showWarnings = FALSE, recursive = TRUE)
dir.create("02_outdata", showWarnings = FALSE, recursive = TRUE)

#Acquisition of palmer penguins data set and writing to CSV

#Installation of palmer penguins package from CRAN (Compregensive R Archve Network)
install.packages("palmerpenguins")

#loading palmer penguins package for use
library("palmerpenguins")

#View datasets in palmerpenguins package
data(package = 'palmerpenguins')

#View 'penguins' data (1/2 from palmerpenguins)
head(penguins)
#Size measurements for adult foraging penguins near PalmerStation, Antarctica

#View 'penguins_raw' data (2/2 from palmerpenguins)
head(penguins_raw)
#Penguin size, clutch, and blood isotope data for foraging adults near Palmer Station, Antarctica

#Write data to csv file
#installing here package to avoid path errors
install.packages("here")
library(here)

#write penguins data into a csv in raw data folder
write.csv(penguins, here("00_rawdata", "penguins.csv"), row.names = FALSE)
