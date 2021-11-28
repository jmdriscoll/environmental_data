i <- 1:n
i <- vec_1[i]

n <- 17
> vec_1 = sample(10, n, replace = TRUE)
for (i in 1:n)
{print(paste0("The element of vec_1 at index ", i, " is ", vec_1[i]))}


## Notes for image margins too large

png(filename = here("images", "demo_image.png"), width = 1600, height = 1400)

pairs.panels(penguins)

dev.off()

echo = false, fig.height, fig.width in the top of R markdown

## Notes for Lab 4 
norm_17 <- rnorm(17, mean = 10.4, sd = 2.4)
norm_30 <- rnorm(30 mean = 10.4, sd = 2.4)
norm_300 <- rnorm(300,  mean = 10.4, sd = 2.4)
norm_3000 <- rnorm(3000, mean = 10.4, sd = 2.4)
