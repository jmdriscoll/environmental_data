#####################
#
# Joshua Driscoll 
# 1/30/2025
# 
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

#####################

# Read in data
## Bird data
birds = read.csv("C:/Coding/Github/environmental_data/data/bird.sta.csv")
## Habitat data
hab = read.csv("C:/Coding/Github/environmental_data/data/hab.sta.csv")
## Merge
birdhab = merge(birds, hab, by = c("basin", "sub", "sta"))

#####################

# Chi-squared test
# The null hypothesis of the chi-squared test is that no relationship exists between the categorical variables in the population. 
# In other words, our categorical variables are independent.

## Create table for analysis
table(birdhab$s.edge, birdhab$BRCR>0)
## Subset table for
br_creeper_table = table(birdhab$s.edge, birdhab$BRCR > 0)[, 2:1]
## Run chi-squared test
chisq.test(br_creeper_table)

## Interpretation
### Given that we have a very low p value (p = .000001386), we have sufficient evidence to reject the null hypothesis that there is no relationship between the variables. 
### Therefore we can say that there is strong evidence to support the claim that Brown Creeper show habitat preference.

* Q 3
fit_species = lm(formula = body_mass_g ~ species, data = penguins)

* Q 4
fit_sex = lm(formula = body_mass_g ~ sex, data = penguins)

* Q 5
fit_both = lm(formula = body_mass_g ~ species*sex, data = penguins)

* Q 6
boxplot(body_mass_g ~ species, data = penguins, main = "Body Mass ~ Species", ylab = "Body Mass (g)")

* Q 7
boxplot(body_mass_g ~ sex, data = penguins, main = "Body Mass ~ Sex", ylab = "Body Mass (g)")

* Q 8
par(las = 2)
boxplot(body_mass_g ~ species*sex, data = penguins, main = "Body Mass ~ Sex and Species", xlab = " ", ylab = "Body Mass (g)", names = c("Female\nAdelie", "Male\nAdelie", "Female\nChinstrap", "Male\nChinstrap", "Female\nGentoo", "Male\nGentoo"))

* Q 9
# Given that to me the Male Chinstrap box looks the widest, I would say that model may have a problem fitting the homogeneity assumption. 

* Q 10
# The null hypothesis of the bartlett test is that the variance is equal for all samples.

* Q 11
bartlett.test(body_mass_g ~ species, data = penguins)

# The p value for body mass explained by species is 0.05005. 

* Q 12
bartlett.test(body_mass_g ~ sex, data = penguins)

# The p values for body mass explained by sex is 0.03194.

* Q 13
dat_groups = aggregate(
  body_mass_g ~ species*sex,
  data = penguins,
  FUN = c)
str(dat_groups)

bartlett.test(dat_groups$body_mass_g)

# The p value for body mass explained by both species and sex is 0.1741.

* Q 14
# Given that the p value in the model for body mass explained by species is .05005 and the p value in the model for body mass explained by both sex and species is .1741, we do not have sufficient evidence in either of these cases to reject the null. While a p value of .05005 is close to a significant value of .05, it is marginally over and in this case is defined as insignificant. Not rejecting the null means that these two models have equal variance. Given that the p value for body mass explained by sex has a p value of .03194, in this case we have sufficient evidence to reject the null and in this case we may have an issue with heterogeneity.