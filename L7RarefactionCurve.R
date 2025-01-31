#####################
#
# Joshua Driscoll 
# 1/29/2025
# Rarefaction Curve
# 
# Desc: Creates confidence intervals and rarefaction curve for moth abundance data
# 
# Notes: - Transposing df's
#        - Rarefaction curve is expected species richness as function of sampling intensity
#        - Species-area relationship but area is replaced by sampling effort
#####################

# Initialization
## Package Load/Install
#install.packages("boot")
library(boot)

# Functions for use
## Rarefaction sampler
rarefaction_sampler = function(input_dat, n_iterations)
{
  # Number of rows or sample observations
  n_input_rows = nrow(input_dat)
  
  results_out = matrix(
    nrow = n_iterations,
    ncol = n_input_rows)
  # Outer loop, runs once for each bootstrap iteration
  for(i in 1:n_iterations)
  {
    # Inner loop, simulates increasing sampling intensity
    # Sampling intensity ranges from 1:n sites
    # Index variable is j
    for(j in 1:n_input_rows)
    {
      # Sample input data row indices with replacement
      rows_j = sample(n_input_rows, size = j, replace=TRUE)
      # Creates a new data matrix
      t1 = input_dat[rows_j, ]
      # Calculates column sums
      t2 = apply(t1, 2, sum)
      # Counts number of columns in which any moths were observed
      results_out[i, j] = sum(t2 > 0)
    }
  }
  return(results_out)
}

#####################

# Rarefaction curve 
## Ran on moth data minus first, arbitraty column
## Used 10000 replicate simulations
## Result is a 10000 row, 24 column df where rows represent bootstrap iteration, columns represent sampling intensity
rarefact = rarefaction_sampler(moths[,-1], 10000)

## Calculate mean and quantiles of moth data
### Mean
rare_mean = apply(rarefact, 2, mean)
### Print
rare_mean
### Quantiles
rare_quant = apply(rarefact, 2, quantile, probs=c(0.025, 0.975))
### Print
rare_quant
### Combine two variables and transpose
rare = t(rbind(rare_mean, rare_quant))
### Print
rare

## Plot rarefaction curve and 95% CI's
par(mfrow = c(1, 1))
print(matplot(
  rare,
  type='l',
  lwd = 2,
  col = "red",
  xlab='Number of sampling plots',
  ylab='Species richness',
  main='Moth Rarefaction Curve'))
## Add legend
legend(
  'bottomright',
  legend=c('Average Species Seen','Upper Confidence Envelope (2.5%)','Lower Confidence Envelope (97.5%)'),
  lty=c(1,2,3),col=c(1,2,3), inset=c(.1,.1))

## Interpretation
### To see 9.5 species I have to go to at least 10 sites.

#####################