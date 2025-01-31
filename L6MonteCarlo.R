#####################
#
# Joshua Driscoll 
# 1/29/2025
# Monte Carlo
# 
# Desc: Monte Carlo resampling. Standard error of the mean. For-loops. Histograms.
# 
# Notes: -droplevels() removes unused factor levels from df
#        -Monte Carlo resampling breaks the structure in the data. Here, the flipper lengths for each penguin species are drawn from the same population of all flipper lengths (simulates null distribution/hypothesis)
#        -Bootstrapping does not destroy structure of data, shuffles rows (w replacement) but not between columns (simulates alternative hypothesis)
#        -shuffle() resamples with replacement by default
#####################

# Initialization
## Package Load/Install
install.packages("palmerpenguins")
library(palmerpenguins)

# Functions for use
## Function for sse mean
### SSE of the mean is sample SD divided by sqrt of sample size
sse_mean = function(x)
{
  y = na.omit(x)
  return((sd(y))/sqrt(length(y)))
}

## Function for Monte Carlo resampling (null hypothesis)
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

# Define data for analysis
## From penguins package
dat_pen = droplevels(subset(penguins, species != "Gentoo"))

#####################

# Data/function checks
## Check out data
### Table of species counts
table(dat_pen$species)

## Check sse function
### Penguins
sse_mean(penguins$body_mass_g)
### Cars
sse_mean(mtcars$mpg)
### Provided correct answers
#### [1] 43.36473
#### [1] 1.065424

#####################

# Monte-Carlo Resampling
## Use two group Monte-Carlo resampling function and for loop to generate 2000 resampled differences of means for flipper length between two species
### Set number of iterations
n = 2000
### Create empty variable for data storage
mean_differences = c()
### For loop
for (i in 1:n)
{
  mean_differences = c(
    mean_differences,
    two_group_resample(dat_pen$flipper_length_mm, 68, 152)
  )
}
### Visualize results of for loop in 
hist(mean_differences)
### Print number of mean differences greater than 5.8 (observed difference in mean)
sum(abs(mean_differences) >= 5.8)
## Interpretation
### According to the p values, we would expect to see a result as extreme or more extreme if the null hypothesis were true less than once in 10 million samples. Therefore we would have to run at LEAST 10 million samples to see a difference in flipper length equal to or greater than 5.8 mm.

#####################

# Group means of bill depth
## Boxplot of bill depth of each species for visual inspection
boxplot(bill_depth_mm ~ species, data = dat_pen, ylab = "Bill Depth (mm)")

## Calculate group means and assign to variable
agg_means = aggregate(
  bill_depth_mm ~ species, 
  data = dat_pen, 
  FUN = "mean", 
  na.rm = TRUE)
### Print
agg_means

## Calculate difference in group means and assign to variable
diff_crit = diff(agg_means[, 2])
### Print
diff_crit

## Conduct t test on group means and assign to variable
t_test = t.test(dat_pen$bill_depth_mm ~ dat_pen$species)
### Print
t_test
#### Interpretation: 
##### Given a high p-value, we fail to reject the null hypothesis that there is no difference between groups

## Use two group MC resamp func and for loop to generate 1000 resamp differences of means for bill depth between species 
### Number of iterations
n = 1000
### Create empty variable for data storage
mean_differences = c()
### For loop
for (i in 1:n)
{
  mean_differences = c(
    mean_differences,
    two_group_resample(dat_pen$bill_depth_mm, 68, 152)
  )
}
### Print number of mean differences greater than observed difference in means
sum(abs(mean_differences) >= diff_crit)
### Interpretation: 
#### There are >900 instances with a difference in means greater than or equal to the diff_crit. 
#### This makes sense given high p-value
### Histogram of simulation results
hist(mean_differences, main = "Mean Differences", xlab = "Difference Value")
