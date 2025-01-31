#####################
#
# Joshua Driscoll 
# 1/29/2025
# Bootstrapping
# 
# Desc: Apply function instead of loops. Sample size. Sample standard deviation. Sample standard error. Confidence intervals.
# 
# Notes: - Transposing df's
#        - Function for bootstrapped mean below to help deal with na's
#        - T distribution is a standard normal distribution that has been scaled for sample size
#        - For sample sizes >30, difference between t and SN distribution are negligible 
#        - Standard process for generating CI
#           - Choose your significance level (usually 95%).
#             - Value of alpha is just 1 - significance level.
#           - Calculate the sample standard error (need SD and Sample Size)
#           - Calculate critical t-values using chosen alpha
#           - Multiply the sample standard error by the critical t-value. This is the radius of the CI.
#           - Express the CI as mean±radius
#
#####################

# Initialization
## Package Load/Install
#install.packages("palmerpenguins")
library(palmerpenguins)
#install.packages("boot")
library(boot)

# Functions for use
## Function for sse mean provided by Mike
sse_mean = function(x)
{
  y = na.omit(x)
  return((sd(y))/sqrt(length(y)))
}

## Function for boot mean to help deal with na's
boot_mean = function(x, i)
{
  return(mean(x[i], na.rm = TRUE))
}

#####################

# Read in data
## Moths csv
### 10 rare moth species acros 24 pine barrens in SE MA
moths = read.csv("C:/Coding/Github/environmental_data/data/moths.csv")

#####################

# Apply example
# Create simulated data
dat = matrix(1:49, nrow = 7, ncol = 7)
print(dat)
# Min/max in each ROW (margin=1)
apply(dat, MARGIN = 1, FUN = min)
# Mean values in each column (margin=2)
apply(dat, MARGIN = 2, FUN = mean)

#####################

# Calculating parametric CI
## 1: Choose significance level
alpha = 0.05
## 2: Calculate sample standard error:
n = sum(!is.na(moths$anst))
sse = sd(moths$anst, na.rm = TRUE) / sqrt(n)
## 3: Calculate critical t-values:
t_crit = abs(qt(alpha / 2, df = n - 1))
## 4: Calculate the CI radius:
ci_radius = sse * t_crit
## The CI is the sample mean +/- the radius:
anst_ci = c(
  lower = mean(moths$anst) - ci_radius,
  upper = mean(moths$anst) + ci_radius)
## Print
print(round(anst_ci, 4))

#####################

# Parametric Confidence Intervals
## Find sample size of n
### Define data for analysis
gentoo <- subset(penguins, species == "Gentoo", select = c(species, bill_length_mm))
### Remove na's
g = na.omit(gentoo$bill_length_mm)
### Find length (sample size)
length(g)

## Find sample standard deviation
sd(g, na.rm = TRUE)

## Find critical T values
qt(.95, df = 122, lower.tail = TRUE)

## Find sample standard error
sse_mean(g)

## Construct CI
### Multiplying SSE by critical T value for CI radius
a = qt(.95, df = 122, lower.tail = TRUE)
b = sse_mean(g)
a * b

### Finding mean of dataset
mean(g)

### Calculate CI
#### CI radius is .4605721. Mean of dataset is 47.40488. 
#### CI is mean +/- CI radius, the CI is 47.40488 +/- .4605721.

#####################

# Bootstrap CI
## Define myboot with boot_mean funciton above
myboot = boot(data = g, statistic = boot_mean, R = 10000)
## Print
print(myboot)

# Calculate upper and lower 2.5% quantiles
quantile(
  myboot$t,
  c(0.025, 0.975))

#####################
