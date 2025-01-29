#####################
#
# Joshua Driscoll 
# 1/28/2025
# Palmer penguins
# 
# Desc: 
# 
# Notes: 
# 
#####################

# Initialization
## Package Load/Install
#install.packages("palmerpenguins")
library(palmerpenguins)

# Functions for use
## Function for sse mean provided by Mike
sse_mean = function(x)
{
  y = na.omit(x)
  return((sd(y))/sqrt(length(y)))
}

## Function for Monte Carlo resampling
two_group_resample = function(x, n_1, n_2)
{
  x = dat_pen$flipper_length_mm
  n_1 = 68
  n_2 = 152
  
  dat_1 = sample(x, n_1, replace = TRUE)
  dat_2 = sample(x, n_2, replace = TRUE)
  
  difference_in_means = 
    mean(dat_1, na.rm = TRUE) - mean(dat_2, na.rm = TRUE)
  
  return(difference_in_means)
}

#####################

# Find sse mean of penguin and car data to check function
## Penguins
sse_mean(penguins$body_mass_g)
## Cars
sse_mean(mtcars$mpg)

#####################

# Define data for analysis
dat_pen = droplevels(subset(penguins, species != "Gentoo"))

# Answering questions
n = 2000
mean_differences = c()
for (i in 1:n)
{
  mean_differences = c(
    mean_differences,
    two_group_resample(dat_pen$flipper_length_mm, 68, 152)
  )
}
hist(mean_differences)

# More questions
sum(abs(mean_differences) >= 5.8)
# 0 means were more than 5.8.
## Interpretation: According to the p values, we would expect to see a result as extreme or more extreme if the null hypothesis were true less than once in 10 million samples. Therefore we would have to run at LEAST 10 million samples to see a difference in flipper length equal to or greater than 5.8 mm.

* Q 7
boxplot(bill_depth_mm ~ species, data = dat_pen)

* Q 8
agg_means = aggregate(
  bill_depth_mm ~ species, 
  data = dat_pen, 
  FUN = "mean", 
  na.rm = TRUE)
diff_crit = diff(agg_means[, 2])

agg_means
diff_crit

* Q 9
t_test = t.test(dat_pen$bill_depth_mm ~ dat_pen$species)
# Interpretation: The p value = 6623 and the difference between the means is equal to .07. What this means in plain english is that if the null hypothesis is true, we would expect to see a difference in the average bill depth of the two penguin species greater than or equal to .07 in approximately 7 out of 10 samples (or 6623 out of 10,000 samples).

* Q 10
n = 1000
mean_differences = c()
for (i in 1:n)
{
  mean_differences = c(
    mean_differences,
    two_group_resample(dat_pen$bill_depth_mm, 68, 152)
  )
}

sum(abs(mean_differences) >= diff_crit)
## Interpretation: There are 939 instances with a difference in means greater than or equal to the diff_crit. 

* Q 11
hist(mean_differences, main = "Mean Differences", xlab = "Difference Value")
