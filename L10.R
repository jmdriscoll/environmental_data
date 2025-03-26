#####################
#
# Joshua Driscoll 
# 1/29/2025
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
* Q 1
rope <- read.csv(here("data", "rope.csv"))
rope$rope.type = factor(rope$rope.type)

#nrow(rope)                        
n_obs = 121
n_groups = 6

#model <- lm(p.cut ~ rope.type, data = rope)
#(sum(resid(model)^2))
ss_tot = 4.874684
df_tot = 120

agg_sq_resids = aggregate(x = rope$p.cut, by = list(rope$rope.type), FUN = function(x) sum((mean(x) - (x))^2))

#sum(agg_sq_resids$x)
ss_within = 4.874684
df_within = 115

ss_among = ss_tot - ss_within
df_among = 5

ms_within = ss_among / (n_groups - 1)
ms_among  = ss_within / (n_obs - n_groups)

f_ratio = 5/115
f_pval = 0.05582

Given the self check I know there are errors here but after going throuhg the walkthrough multiple times I still do not understand quite where or how they are wrong. In some places I included code and in others where I could do the math in my head (for example, most of the df questions) I have just the numeric output.

* Q 2 
Based on the figure I do not think that there is equal variances among the groups. This is because the "whiskers" in the plot vary vastly. 

* Q 3
bartlett.test(p.cut ~ rope.type, data=rope)

p = .00143

Given the low p-value we canreject the null that the variance is the same across all groups. Given that ANOVA assumes normality of variances, we might say that this is not an appropriate test for this set of data.

* Q 5 
Blaze is the base case.

* Q 6
The mean percent cut for the base case is .36714 * 100 = 36.714%

* Q 7
The mean percent cut for XTC is .36714 - .10164 = .2655 * 100 = 26.55%

