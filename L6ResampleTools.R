#####################
#
# Joshua Driscoll 
# 1/29/2025
# Lab6: Resample tools
# 
# Desc: Displays use of Monte-Carlo and Bootstrap resampling
# 
# Notes: Large viewing window filled in by for loop below.
# 
#####################

# Initialization
## Package Load/Install
#install.packages("palmerpenguins")
library(palmerpenguins)

#####################

# Monte-Carlo
## Set seed for reproducibility
set.seed(123)
## Create shuffled flipper variable
flipper_shuffled = sample(
  penguins$flipper_length_mm, replace = TRUE)
## Create boxplots
{
  par(mfrow = c(1, 2))
  boxplot(
    flipper_length_mm ~ species, data = penguins,
    ylab = "Flipper length (mm)",
    main = "Original Data")
  boxplot(
    flipper_shuffled ~ penguins$species,
    ylab = "Flipper length (mm)",
    main = "MonteCarlo Resampled Data",
    xlab = "species")
}

## Repeated MC Resampling
### Set viewing window
par(mfrow = c(4, 4), mar = c(1, 1, 1, 1))
### Graph MC Resamples
for (i in 1:16)
{
  
  flipper_shuffled = sample(
    penguins$flipper_length_mm, replace = TRUE)
  
  boxplot(
    flipper_shuffled ~ penguins$species,
    ann = F, axes = F)
  box()
  
}

#####################

# Bootstrap
## Create bootstrapped variable
penguins2 = penguins[sample(1:nrow(penguins), replace = T), ]
## Create boxplots
{
  par(mfrow = c(1, 2))
  boxplot(
    flipper_length_mm ~ species, data = penguins,
    ylab = "Flipper length (mm)",
    main = "Original Data")
  boxplot(
    flipper_length_mm ~ species, data = penguins2,
    ylab = "Flipper length (mm)",
    main = "Bootstrap Data")
}