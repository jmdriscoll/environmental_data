#####################
#
# Joshua Driscoll 
# 1/27/2025
# Vector Data Handling
# 
# Desc: Investigation of booleans and subsetting
# 
# Notes: 
# 
#####################

# Initialization
## Package Load/Install
### Packages schmackages

#####################

# Exploring data types with word problems
## What kind of variable is 4?
class(4)
## What kind of variable is 4.0?
class(4.0)
## Is 1.0 equivalent to TRUE?
1.0 == TRUE
## Is 3.0000000000000001 the same as 3.0?
3.0000000000000001 == 3.0
## Does arithmetic addition have a truth value?
(0 + 1) == TRUE
## Does arithmetic subtraction have a truth value?
(0 - 1) == TRUE
## Can I multiply/divide by T/F?
### * T = * 1
3.0 * TRUE
### / F = / 0
4 / FALSE
### 0 / 0 
FALSE / FALSE
### 3 * 1 + 0
3.0 * (TRUE + FALSE)
### 3 * 1 - 0
3.0 * (TRUE - FALSE)
### 3 * 0 - 0 
3.0 * (FALSE - FALSE)

#####################

# Subsetting
## Set size variable
s = 12345
## Create a vector of length s of values between 1-12
vec_1 = sample(12, s, replace = TRUE)
## Examine the first 5 values of variable
head(vec_1)
## Create a second vector that retreives all of the values in vec_1 that are equal to the third value in the vector 
vec_2 = vec_1[vec_1==3]
## Create a third vector that retreives all of the values in vec_1 that are equal to 3
vec_3 = vec_1==3
vec_1[vec_3]
## Count how many times the value 3 appears in vec_1
### If you re-run vec_1 creation script then this number will change due to randomly generated iterations
sum(vec_1 == 3)

#####################



