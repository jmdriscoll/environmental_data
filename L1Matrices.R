#####################
#
# Joshua Driscoll 
# 1/27/2025
# R fundamentals
# 
# Desc: Reads in vector data files and reprojects them all using sf. Use the union function to join two vector files. Removed intersect functions.
# 
# Notes: R fills in matrices by column
# 
#####################

# Initialization
## Package Load/Install
### Where we're going we don't need packages

#####################

# String and character vector
## String created with combine function
x <- c(1, 2, 3)
## Character vector
x <- "c(1, 2, 3)"

#####################

# Matrices
## Create variable to be turned into matrix
my_vec = c(1, 2, 3)
## Turn vector into matrix using matrix function
### Fills in by column, matrix is 3 rows by 1 column
mat_1 = matrix(my_vec)
## View matrix
mat_1
## Access item in rowcolumn 3,  1 and assign to variable
voi <- mat_1[3,1]

## Matrix 2x3 with values from my_vec
### Fills in by column
mat_2 <- matrix(my_vec, nrow = 2, ncol = 3)
mat_2

## Matrix 3x2 with values from my_vec
mat_3 <- matrix(my_vec, nrow = 3, ncol = 2)
mat_3

## When value is not a multiple of 3, this returns an error, as below
mat_4 <- matrix(my_vec, nrow = 4, ncol = 2)

#####################