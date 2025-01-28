#####################
#
# Joshua Driscoll 
# 1/27/2025
# Vector Data Handling
# 
# Desc: For loops and functions
# 
# Notes: 
# 
#####################

# Initialization
## Package Load/Install
### Packages schmackages

#####################

# For-loops
## For loop that loops 10 times, prints an additive variable, and a message
for (i in 1:10) {
  print(paste0("The value of the randomly-generated number is: ", i))
  }

## Modify loop so that it runs as many times as an assigned variable
### Assign number of loops desired to a variable
n <- 13
### Re-run loop
for (i in 1:n) {
  print(i)
}

## Modify loop so that it iterates n times and prints a message that includes the iteration number and value
### Set number of loops
n <- 17
### Create vector
vec_1 = sample(1:10, n, replace = TRUE)
### For loop and print value and number of loop
for (i in 1:n) {
  print(paste0("The element of vec_1 for iteration ", i, " is ", vec_1[i]))
}

#####################

# Functions
## Create a function to wrap for loop within
create_and_print_vec = function(n, min = 1, max = 10)
{
  vec_1 = sample(1:10, n, replace = TRUE)
  for (i in 1:n){
    print(paste0("The element of vec_1 for iteration ", i, " is ", vec_1[i]))
    }
}

create_and_print_vec(5)

#####################
