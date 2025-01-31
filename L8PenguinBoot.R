#####################
#
# Joshua Driscoll 
# 1/30/2025
# Penguin boot
# 
# Desc: Bootstrap replicates of average flipper length in two species of penguins. Generate distribution function from replicates. Find probability of observing means given that distribution.
# 
# Notes: - Need confirmation on ecdf's line 46-58. Reversed lesser/larger than from original as it seemed incorrect.
# 
#####################

# Initialization
## Package Load/Install
#install.packages("palmerpenguins")
library(palmerpenguins)
#install.packages("simpleboot")
library(simpleboot)

#####################

# Calculate 10000 bootstrap replicates of difference in mean flipper length
## Create variable of ADPE data
ade_flip = na.omit(subset(penguins, species == "Adelie", select = c(species, flipper_length_mm)))
## Create variable of CHPE data
chin_flip = na.omit(subset(penguins, species == "Chinstrap", na.rm = TRUE, select = c(species, flipper_length_mm)))  
## Run bootsrap replicates using two.boot
pen_boot = two.boot(ade_flip$flipper_length_mm, chin_flip$flipper_length_mm, FUN = mean, R = 10000)
## Calculate Standard Deviation of differences in mean flipper length
sd(pen_boot$t)
## Create histogram of Bootsrapped differences of means
hist(pen_boot$t, main = "Penguin Bootstrap Sampling Distribution", xlab = "Penguin Bootstrap Means")
## Calculate 95% bootstrap CI
quantile(pen_boot$t, c(.025, .975))
## Calculate mean of difference of means
mean(pen_boot$t)
## Calculate median of difference of means
median(pen_boot$t)
## Interpertation
### Mean and median are close, indicating this would likely not be a skewed distribution. 
### In histogram there is a relatively normal bell curve for the distribution, not one that is skewed.

## Create Empirical Cumulative Distribution Function from bootstrapped replicates
### ECDF returns a new function that works a lot like pnorm(); calculates area under the curve to the left of x
pen_ecdf = ecdf(pen_boot$t)
### Calculate empirical probability of observing a mean difference of -4.5 or lesser
pen_ecdf(-4.5)
#### Interpretation
##### Probability of observing a mean difference of -4.5 or lesser is .9128.
## Calculate empirical probability of observing a mean difference of 0 (null hypothesis) or lesser
pen_ecdf(0)
## Calculate empirical probability of observing a mean difference of -8 or larger
pen_ecdf(0) - pen_ecdf(-8)
## Interpretation
### Probability of observing a mean difference of -8 or larger is .9857.

#####################