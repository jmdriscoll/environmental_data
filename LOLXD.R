Walkthrough/notes

## SSE Mean Function

sse_mean = function(x)
{
  y = na.omit(x)
  return((sd(y))/sqrt(length(y)))
}
 

## Two group re-sample function

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

## Rarefaction sampler function

rm(list = ls())

moths = read.csv(here("data", "moths.csv"))

rarefaction_sampler = function(input_dat, n_iterations)
{
  n_input_rows = nrow(input_dat)
  
  results_out = matrix(
    nrow = n_iterations,
    ncol = n_input_rows)
  
  # The outer loop: runs once for each bootstrap iteration.  index variable is i
  for(i in 1:n_iterations)
  {
    # The inner loop: simulates increasing sampling intensity
    # Sampling intensity ranges from 1 site to the complete count of
    # sites in the input data (n)
    for(j in 1:n_input_rows)
    {
      # sample the input data row indices, with replacement
      rows_j = sample(n_input_rows, size = j, replace=TRUE)
      
      # Creates a new data matrix
      t1 = input_dat[rows_j, ]
      
      # Calculates the column sums
      t2 = apply(t1, 2, sum)
      
      # Counts the number of columns in which any moths were observed
      results_out[i, j] = sum(t2 > 0)
    }
  }
  return(results_out)
}

rarefact = rarefaction_sampler(moths[,-1], 100)
head(rarefact)

subset(airquality, Temp > 80, select = c(Ozone, Temp))
subset(airquality, Day == 1, select = -Temp)

## Lab 8 Walkthrough notes

!is.na(subset)

subset(airquality, select = Ozone:Wind)