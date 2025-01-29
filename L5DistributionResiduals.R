#####################
#
# Joshua Driscoll 
# 1/28/2025
# Salamander distributions and residuals
# 
# Desc: Manually fitting linear, exponential, and ricker functions to salamander dispersal data. Adding curves to graphs.
#       Residual generation and comparison between functions
# 
# Notes: 'locator(1)' allows you to find the exact coordinates on a plot. After use, click location on plot for coordinates.
# 
#####################

# Initialization
## Package Load/Install
### Where we're going we don't need packages

# Functions for use
## Ricker function
ricker_fun = function(x, a, b) 
{
  return(a * x * exp(-b * x))
}

## Exponential function
exp_fun = function(x, a, b)
{
  return(a*exp(-b * x))
  }

## Calculates the value of y for a linear function, given the coordinates of a known point (x1, y1) and the slope of the line.
line_point_slope = function(x, x1, y1, slope)
{
  get_y_intercept = 
    function(x1, y1, slope) 
      return(-(x1 * slope) + y1)
  
  linear = 
    function(x, yint, slope) 
      return(yint + x * slope)
  
  return(linear(x, get_y_intercept(x1, y1, slope), slope))
}

#####################

# Read in data
## Salamander dispersal data
### Marked salys, dispersal from natal ponds for first time breeders, standardized for disp propensity from natal ponds and distance between ponds
dispersal <- read.csv("/Users/joshuadriscoll/Documents/GitHub/environmental_data/data/dispersal.csv")

#####################

# Explore curve command with EXPONENTIAL function and salamander data
## Plot four negative EXPONENTIAL curves on one graph (add = TRUE) with different plotting characteristics
curve(exp_fun(x, 1.9, .1), add = FALSE, from = 0, to = 50,
      ann = FALSE, axes = TRUE, ylab = "f(x)"); box()
curve(exp_fun(x, 1.9, .3), lty = "dotted", add = TRUE)
curve(exp_fun(x, 1.2, .2), col = "red", add = TRUE)
curve(exp_fun(x, 1.2, .4), col = "red", lty = "dotted", add = TRUE)
title(main = "Exponential Curves", ylab = "f(x)")
## Interpretation
### a parameter alters the y intercept and b parameter changes the slope of the line.

#####################

# Explore curve command with RICKER function and salamander data
## Plot four negative RICKER curves on one graph (add = TRUE) with different plotting characteristics
curve(
  ricker_fun(x, 25, .1), add = FALSE, from = 0, to = 75, 
  main = "Ricker functions",
  ylab = "f(x)", xlab = "x")
curve( ricker_fun(x, 20, .2), lty = "dotted", add = TRUE)
curve(ricker_fun(x, 10, .2), lty = "dotted", add = TRUE)
curve(ricker_fun(x, 75, .3), col = "red", add = TRUE)
curve(ricker_fun(x, 50, .3), col = "red", lty = "dotted", add = TRUE)
curve(ricker_fun(x, 40, .3), col = "red", lty = "dotted", add = TRUE)
## Interpretation
### a parameter changes the initial slope of the graph, b parameter changes the height of the graph.

#####################

# Explore data distributions with salamander data
## Linear Model
### Plot data for inspection and use of locator(1)
plot(x = dispersal$dist.class, y = dispersal$disp.rate.ftb, main = "Salamander Dispersal", xlab = "Dispersal Class", ylab = "1st Breeding Season Dispersal Rate")
locator(1)
### Define parameters
#### Parameters were identified using 'locator(1)' to find coordinates of a centralized point. Then used trial and error for slope. 
slope1 = -.0004
a = 503
b = .4
### Plot curve on graph using line_point_slope
curve(line_point_slope(x, a, b, slope1), add = TRUE)

## Exponential Model
### Plot data for inspection and use of locator
plot(x = dispersal$dist.class, y = dispersal$disp.rate.ftb, main = "Salamander Dispersal", xlab = "Dispersal Class", ylab = "1st Breeding Season Dispersal Rate")
locator(1)
### Define parameters
#### a was chosen as close to x axis as this is where line is to begin. We then chose a shallow slope to fit the data.
a = 1.2
b = .003
### Add curve with specified parameters to graph using exponential function
curve(exp_fun(x, 1.2, .003), add = TRUE)

## Ricker model
### Plot data for inspection and use of locator
plot(x = dispersal$dist.class, y = dispersal$disp.rate.ftb, main = "Salamander Dispersal", xlab = "Dispersal Class", ylab = "1st Breeding Season Dispersal Rate")
locator(1)
### Define parameters
#### Started w/ values for exp decay function and used trial and error to find real values
#### a and b defined above. a=initial slope, b=height
a = .009
b = .004
### Add curve with specified parameters to graph.
curve(ricker_fun(x, .009, .004), add = TRUE)

#####################

# Residual inspection
## Linear distribution function
### Store predicted values of linear distribution function
linear_pred <- line_point_slope(dispersal$dist.class, 503, .4, -.0004)
### Generate residuals and store
resids_linear <- (dispersal$disp.rate.ftb) - linear_pred

##Exponential function
### Store predicted values of exponential function
exp_pred <- exp_fun(dispersal$dist.class, 1.2, .003)
### Generate residuals and store
resids_exp <- (dispersal$disp.rate.ftb) - exp_pred

## Ricker function
### Store predicted values of ricker function
rick_pred <- ricker_fun(dispersal$dist.class, .009, .004)
### Generate residuals and store
resids_ricker <- (dispersal$disp.rate.ftb) - rick_pred

## Create a dataframe of eresiduals of each distribution function
data.frame(resids_linear, resids_exp, resids_ricker)

## Create histograms of each set of residuals
### Set viewing window
par(mfrow = c(3, 1))
### Create histograms of each set of residuals
hist(resids_linear, main = "Linear Residuals", xlab = "Residuals")
hist(resids_exp, main = "Exponential Residuals", xlab = "Residuals")
hist(resids_ricker, main = "Ricker Residuals", xlab = "Residuals")

#####################
