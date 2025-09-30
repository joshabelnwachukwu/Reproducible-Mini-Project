#Snapshot of in-use packages 
#Snapshot of in-use packages 
install.packages("palmerpenguins")
install.packages("here")
install.packages("tidyverse")
install.packages("janitor")
install.packages("broom")
library(palmerpenguins)
library(here)
library(tidyverse)
library(janitor)
library(broom)

renv::snapshot()
renv::snapshot(packages = c("palmerpenguins", "here", "tidyverse", "janitor", "broom"))
