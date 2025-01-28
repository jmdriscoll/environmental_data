#####################
#
# Joshua Driscoll 
# 1/27/2025
# Data Distributions
# 
# Desc: Generating random datasets from different distributions. Adding columns to dfs. Histogram and scatterplots. Saving images. Generating and plotting residuals.
# 
# Notes: -set.seed sets your starting place in a near infinite string of pseudorandom values in r
#        -Each common dist has a list of 4 functions: xnorm, xpois, xetc...
#           dnorm(): the probability density
#           pnorm(): the cumulative probability density
#           qnorm(): the quantile function
#           rnorm(): function to generate random, normally-distributed numbers.
#####################

# Initialization
## Package Load/Install
### Where we're going we don't need packages

# Functions for use
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

# Create 4 sets of randomly generated numbers within a normal distribution
## Set mean and sd because we are running same numbers multiple times
mean = 10.4
sd = 2.4 
## Generate 4 sets of different sizes
norm_17 <- rnorm(17, mean, sd)
norm_30 <- rnorm(30, mean, sd)
norm_300 <- rnorm(300,  mean, sd)
norm_3000 <- rnorm(3000, mean, sd)
## Create histogram of 4 distributions of data
### Name file
png(filename = "C:/Coding/Github/environmental_data/data/lab_04_hist_01.png", width = 1500, height = 1600, res = 180)
### Set image window
par(mfrow = c(2, 2))
### Plot histograms of each distribution of data
hist(norm_17, main = "Histogram with 17 Data Points", xlab = "Data")
hist(norm_30, main = "Histogram with 30 Data Points", xlab = "Data")
hist(norm_300, main = "Histogram with 300 Data Points", xlab = "Data")
hist(norm_3000, main = "Histogram with 3000 Data Points", xlab = "Data")
## Shut off graphics device
dev.off()
## Interpretation
### As sample size increases, data approaches normal distributions
### Mean and standard deviation parameters of the STANDARD Normal distribution are mean = 0 and SD = 1.

# Plot a density curve for a normal distribution with m=10.4, sd=2.4
## Create image file
svg(filename = "C:/Coding/Github/environmental_data/data/norm_1.svg")
## Set viewing window
par(mfrow = c(1, 1))
## Generate vector of x values
x = seq(-100, 100, length.out = 1000)
## Set y
y = dnorm(x, mean = 10.4, sd = 2.4)
## Plot density function
plot(x, y, main = "PDF with m = 10.4 and SD = 2.4", type = "l", xlim = c(0, 24))
## Set straight line to plot at h=0
abline(h = 0)
## Shut off graphics device
dev.off()

#####################

# Experimenting with random data
## 4 sets of random data with different values for each variable
### Uniform Data 1
n_pts = 100
x_min = -10
x_max = 10
set.seed(4)
unif_dat_1 = runif(n = n_pts, min = x_min, max = x_max)
dat = data.frame(x = x, y_observed = rnorm(n_pts))

### Uniform Data 2
n_pts = 25
x_min = -10
x_max = 10
set.seed(8)
unif_dat_2 = runif(n = n_pts, min = x_min, max = x_max)
dat = data.frame(x = x, y_observed = rnorm(n_pts))

### Pois Data 1
n_pts = 300
set.seed(8)
pois_dat_1 = rpois(n = n_pts, lambda = 100)
dat = data.frame(x = x, y_observed = n_pts)

### Normal Data 1
n_pts = 100
set.seed(4)
norm_dat_1 = rnorm(n = n_pts, mean = 1, sd = 1)
dat = data.frame(x = x, y_observed = rnorm(n_pts))

### Create figure
svg(filename = "C:/Coding/Github/environmental_data/data/Color_plot.svg")
#### Set viewing window
par(mfrow = c(2,2))
#### Insert histograms
hist(unif_dat_1, col = "red", main = "Uniform 1", xlab = "Data")
hist(unif_dat_2, col = "green", main = "Uniform 2", xlab = "Data")
hist(pois_dat_1, col = "blue", main = "Poisson 1", xlab = "Data")
hist(norm_dat_1, col = "yellow", main = "Normal 1", xlab = "Data")
#### Turn off graphics device
dev.off()

### Visually fit linear deterministic function to data
#### Reset viewing window
par(mfrow = c(1,1))
#### Set parameter of distribution (norm1 above)
n_pts = 100
set.seed(4)
norm_dat_1 = rnorm(n = n_pts, mean = 1, sd = 1)
dat = data.frame(x = rnorm(n = n_pts), y_observed = rnorm(n_pts))

#### Set guess variables for linear deterministic function
guess_x = 5
guess_y = 4
guess_slope = 0.8

#### Create image file
svg(filename = "C:/Coding/Github/environmental_data/data/line_fit.svg")
#### Plot generated data
plot(y_observed ~ x, data = dat, pch = 8, ylab = "Observed Y Values")
#### Add line with guess parameters to graph
curve(line_point_slope(x, guess_x, guess_y, guess_slope), add = T)
#### Turn off graphics device
dev.off()

#### Calculate residuals of generated data to guess det function
##### Calculate predicted y values
line_point_slope(dat$x, guess_x, guess_y, guess_slope)
##### Create an object and assign y values
y_predicted <- c(line_point_slope(dat$x, guess_x, guess_y, guess_slope))
##### Add to dataset
dat$new_col <- y_predicted
##### Check data
View(dat)
##### Name columns
names(dat)[3]<-paste("y_predicted")
##### Calculate absolute residuals
resids <- abs(dat$y_observed) - abs(dat$y_predicted)
##### Add residuals to data
dat$new_col <- resids
##### Name column
names(dat)[4]<-paste("Residuals")

#### Plot residuals
##### Create image file
svg(filename = here("C:/Coding/Github/environmental_data/data/PredVal_Resid_Plot.svg"))
##### Scatterplot of predicted vs residual
plot(dat$y_predicted, dat$Residuals, main = "Plot of Predicted Values and Residuals", xlab = "Predicted Y Values", ylab = "Residuals")
##### Turn off graphics window
dev.off()

##### Create image file
svg(filename = "C:/Coding/Github/environmental_data/data/Resid_Hist.svg")
##### Histogram of residuals
hist(dat$Residuals, main = "Histogram of Residuals", xlab = "Residuals")
##### Shut off graphics window
dev.off()

