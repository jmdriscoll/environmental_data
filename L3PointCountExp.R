#####################
#
# Joshua Driscoll 
# 1/27/2025
# Logistic Curve: Bird Data
# 
# Desc: Reads in multi-species bird count and habitat. Merges two files based on column and plot.
#       Sum pres/abs of a species. Randomly sample counts. Plot pres/abs of species v habitat variable
#       Manually estimate logistic curves with draw functions provided by Mike.
# 
# Notes: 
# 
#####################

# Initialization
## Package Load/Install
install.packages("psych")
library(psych)

## Functions for logistic investigation
### Function to calculate the logistic parameter a given the slope and midpoint
get_logistic_param_a = function(slope, midpoint)
{
  b = slope / 4
  return (-midpoint * (slope / 4))
}

### Function to calculate the logistic parameter b given the slope
get_logistic_param_b = function(slope)
{
  return (slope / 4)
}

### Calculate the value of the logistic function at x, given the parameters a and b.
logistic = function(x, a, b)
{
  val = exp(a + b * x)
  return(val / (1 + val))
}

### Calculate the value of the logistic function at x, given a slope and midpoint.
logistic_midpoint_slope = function(x, midpoint, slope)
{
  b = get_logistic_param_b(slope)
  a = get_logistic_param_a(slope, midpoint)
  return(logistic(x, a, b))
}
#####################

# Logistic Investigation
## Read in and merge bird/habitat data
### Bird Data
dat_bird <- read.csv("C:/Coding/Github/environmental_data/data/bird.sta.csv")
### Habitat Data
dat_habitat <- read.csv("C:/Coding/Github/environmental_data/data/hab.sta.csv")
### Merge data
dat_all <- merge(dat_bird, dat_habitat)
### Visualize all data~total basal area to confirm combination
plot(ba.tot ~ elev, data = dat_all)

## Basic counts of #p/a
### How many GRJA seen in all sampling sites
sum(dat_all$GRJA)
### Total number of sites with GRJA
#### Run as numeric on boolean of GRJA and sum
as.numeric(dat_all$GRJA >= 1)
sum(boo_grayjay)

## Wood duck Presence/Absence
### Randomly sample site counts for visualization
sample(dat_all$CEWA, 100)
### Create boolean variable from column of counts and view
wodu_present_absent <- dat_bird$WODU >= 1
head(wodu_present_absent)
### Coerce boolean variable into more 0/1
as.numeric(wodu_present_absent)
### Plot to check for 0's & 1's
plot(x = dat_habitat$ba.tot, y = wodu_present_absent, main = "Wood Duck Presence/Absence", xlab = "Total Basal Area", ylab = "Presence/Absence")
### Draw a logistic curve over data
curve(logistic_midpoint_slope(x, midpoint = 10, slope = -10), add = TRUE)
### Interpretation
#### WODU p(1)/a(~1046) is not correlated with basal area in this data set.
#### To display this, curve was given slope of -10 so that it jumps down to the x axis to make a ~decent~ fit.

## Wrentit Pres/Abs
### Randomly sample site counts for visualization
sample(dat_all$WREN, 100)
### Create boolean variable from column of counts and view 
wrentit_present_absent <- dat_bird$WREN >= 1
head(wrentit_present_absent)
### Coerce boolean variable into more 0/1
as.numeric(wrentit_present_absent)
### Plot to check for 0's & 1's
plot(x = dat_habitat$ba.tot, y = wrentit_present_absent, main = "Wrentit Pres/Abs", xlab = "Total Basal Area", ylab = "Presence/Absence")
### Draw a logistic curve over data
curve(logistic_midpoint_slope(x, midpoint = 40, slope = -1), add = TRUE)
### Interpretation
#### Wrentits seem to prefer areas that have <50 m2/hectare with 1 observation outside this limit. 
#### The logistic curve has a midpooint of 40 and a relatively steep slope of -1. 

#####################