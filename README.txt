# Analysis of Environmental Data

Repository contains code developed during labs of ECO602 taught by Michael France Nelson at the University of Massachusetts Amherst in the Fall of 2021. Labs were broken down into near one off tools for personal use. When doing this, modified some code away from rgdal and rgeos to sf/raster. Below is a short description of each file and what is contained within.

L1Matrices: Generating and accessing matrices.

L2BooleanSubset: Investigation of booleans and subsetting.

L2LoopAndFunc: Basic for loops and functions.

L3PointCountExp: Reads in multi-species bird count and habitat. Merges two files based on column and plot. Sum pres/abs of a species. Randomly sample counts. Plot pres/abs of species v habitat variable. Manually estimate logistic curves with draw functions provided by Mike.

L4DatDistributions: Generating random datasets from different distributions. Adding columns to dfs. Histogram and scatterplots. Saving images. Generating and plotting residuals.

L5DistributionResiduals: Manually fitting linear, exponential, and ricker functions to salamander dispersal data. Adding curves to graphs. Residual generation and comparison between functions.

L6MonteCarlo: Monte Carlo resampling. Standard error of the mean. For-loops. Histograms.

L6ResampleTools: Displays use of Monte-Carlo and Bootstrap resampling. 

L7Bootstrap: Apply function instead of loops. Sample size. Sample standard deviation. Sample standard error. Confidence intervals.

L7RarefactionCurve: Creates confidence intervals and rarefaction curve for moth abundance data.

L8PenguinBoot: Bootstrap replicates of average flipper length in two species of penguins. Generate distribution function from replicates. Find probability of observing means given that distribution.

L8ResamplingDistributions: Read in bird and habitat data. Z standardize data. Find observed slope coefficient. Generate null and alternative distribution of means using resampling. Plot both on same graph.

L8VegBoot: Read in veg data. Subset data for analysis. Run two tailed t test on pine~treatment. Create bootstrapped replicates of average and calculate confidence interval. Observe that observed data is within confidence interval set by bootstrap replicates.

L9: Need to complete.

L10: Need to complete.