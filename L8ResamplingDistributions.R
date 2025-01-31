#####################
#
# Joshua Driscoll 
# 1/30/2025
# Null and alternative distribution of bird diversity indices
# 
# Desc: Read in bird and habitat data. Z standardize data. Find observed slope coefficient. Generate null and alternative distribution of means using resampling. Plot both on same graph. 
# 
# Notes: - Need to check bootstrap for loop, does not look quite correct in graph
#        - Simpson's Diversity Index
##          - Definition: Simpsons Diversity index takes into account the number of species present as well as the relative abundance of each species.
##            As species richness and evenness increases, so does the diversity.
#####################

# Initialization
#install.packages("simpleboot")
library(simpleboot)

#####################

# Read in bird and habitat data for analysis
## Bird data
dat_bird = read.csv("C:/Coding/Github/environmental_data/data/bird.sub.csv")
## Habitat data
dat_habitat = read.csv("C:/Coding/Github/environmental_data/data/hab.sub.csv")
## Merge data
dat_all = merge(dat_bird, dat_habitat, by = c("basin", "sub"))

#####################

# Comparing Null and Alternative Distributions
## z-standardize diversity indexes
### Calculate mean and sd of basin data
b_sidi_mean = mean(dat_all$b.sidi, na.rm = TRUE)
b_sidi_sd = sd(dat_all$b.sidi, na.rm = TRUE)
### Calculate mean and sd of sub-basin data
s_sidi_mean = mean(dat_all$s.sidi, na.rm = TRUE)
s_sidi_sd = sd(dat_all$s.sidi, na.rm = TRUE)
### Create standarized columns
#### Basin
dat_all$b.sidi.standardized = (dat_all$b.sidi - b_sidi_mean)/b_sidi_sd
#### Sub-basin
dat_all$s.sidi.standardized = (dat_all$s.sidi - s_sidi_mean)/s_sidi_sd

## Null Distribution: Monte-Carlo Resampling
### Create loop to resample slope parameter of simple linear regression on Simpson Div Ind
#### Subset data for loop
dat_1 = subset(dat_all, select = c(b.sidi, s.sidi))
#### Set number of resamples
m = 10000 
#### Create empty vector for data storage with numeric()
result = numeric(m)
#### Monte-Carlo Simulation loop
##### Needs to: resample data, fit simple linear regression, and extract slope
for(i in 1:m)
{
  # Build two index variables
  index_1 = sample(nrow(dat_1), replace = TRUE)
  index_2 = sample(nrow(dat_1), replace = TRUE)
  # Resample data
  dat_resampled_i = data.frame(b.sidi = dat_1$b.sidi[index_1], s.sidi = dat_1$s.sidi[index_2])
  # Fit linear regression
  fit_resampled_i = lm(b.sidi ~ s.sidi, data = dat_resampled_i)
  # Store result
  result[i] = coef(fit_resampled_i)[2]
}
### Histogram of Monte-Carlo Resampled Slopes
#### Generate fit for observed data
fit_1 = lm(b.sidi ~ s.sidi, data = dat_all)
#### Find coefficient of slope for observed data
coef(fit_1)
#### Select second value (the slope) and store in a variable
slope_observed = coef(fit_1)[2]
#### Calculate 5th percentile of null distribution of slopes
quantile(result, c(.05))
#### Draw histogram
hist(result, main = "Null Distribution of Regression Slope", xlab = "Slope Parameter")
#### Add slope of observed data
abline(v = slope_observed, lty = 1, col = "blue", lwd = 2)
#### Add critical value of simulated data
abline(v = quantile(result, c(.05)), lty = 3, col = "red", lwd = 2)
#### Interpretation:
##### Critical value is -.0129173 which is larger than the observed slope. 
##### Loop created a set of slope parameters that were calculated on randomized and resampled data.
##### Because the observed slope is less than the critical value, we can state that there is strong evidence of a negative relationship between vegetation cover diversity and bird diversity.

## Alternative Distribution: Bootstrap Resampling
### Set seed for reproducability
set.seed(345)
### Create index for resampling
index_1 = sample(nrow(dat_1), replace = TRUE)
### Assign boot to a variable
dat_boot = dat_1[index_1, ]
### Inspect bootstrap
head(dat_boot)
### Fit linear model to bootstrapped data
fit_bs1 = lm(b.sidi ~ s.sidi, data = dat_boot)
### Show slope of regression fit
boot_observed = coef(fit_bs1)[2]
#### Set number of resamples
m = 10000 
#### Create empty vector for data storage with numeric()
result_boot = numeric(m)
#### For loop to bootstrap data
for(i in 1:m)
{
  # Build one index variables
  index_1 = sample(nrow(dat_1), replace = TRUE)
  # Resample data
  boot_resampled_i = data.frame(dat_boot = dat_1[index_1, ])
  # Fit linear regression
  fit_resampled_i = lm(dat_boot.b.sidi ~ dat_boot.s.sidi, data = boot_resampled_i)
  # Store result
  result_boot[i] = coef(fit_resampled_i)[2]
}
#### Draw histogram of alternative samples
hist(
  result_boot,
  main = "Alternative Distribution of Regression Slope",
  xlab = "Slope Parameter")
abline(v = boot_observed, lty = 2, col = "red", lwd = 2)
abline(v = 0, lty = 2, col = 1, lwd = 2)

#### Draw density plot of both distributions
plot(density(result),
  main = "MC and Boot Density Plots",
  xlab = "Slope Coefficient",
  xlim = c(-.04, .04),
  ylim = c(0,60))
lines(density(result_boot))

#####################