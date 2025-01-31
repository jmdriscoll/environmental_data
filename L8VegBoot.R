#####################
#
# Joshua Driscoll 
# 1/30/2025
# Vegetation bootstrap
# 
# Desc: Read in veg data. Subset data for analysis. Run two tailed t test on pine~treatment
#       Create bootstrapped replicates of average and calculate confidence interval. Observe that observed data is within confidence interval set by bootstrap replicates.
# 
# Notes: 
#
#####################

# Initialization
## Package Load/Install
#install.packages("simpleboot")
library(simpleboot)

#####################

# Data for analysis
##Read in veg data
veg_data = read.csv("C:/Coding/Github/environmental_data/data/vegdata.csv")
## Separate control and clipped treatments
veg = droplevels(subset(veg_data, treatment %in% c("control", "clipped")))

#####################

# Conduct two-tailed Wilcoxon ranked sum test on difference in mean number of pine seedlings between control and cipped treatments
## Run two tailed Wilcoxon ranked sum test
t.test(pine ~ treatment, data = veg)
## Interpretation
### p-value is .05582

# Create bootstrapped dataset of differences in mean pine tree count between clipped and control treatments
## Create variable of control
pine_control = na.omit(subset(veg, treatment =="control", select = c(treatment, pine)))
## Create variable of clipped
pine_clipped = na.omit(subset(veg, treatment =="clipped", select = c(treatment, pine)))
## Run boot on control v clipped
tree_boot = two.boot(pine_control$pine, pine_clipped$pine, FUN = mean, R = 10000)
## Use quantile to find 95% Confidence interval.
quantile(tree_boot$t, c(0.025, .975))
## Interpretation
### Bootstrap CI limits are -29.625 and -4.250.

## Display observed difference in mean tree counts
tree_boot$t0
## Interpretation
### Observed difference is -16 and does fall within the 95% bootstrap confidence interval.

#####################