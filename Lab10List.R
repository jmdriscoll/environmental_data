Lab 10 list

rm(list = ls())

library(here)
rope = read.csv(here("data", "rope.csv"))
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