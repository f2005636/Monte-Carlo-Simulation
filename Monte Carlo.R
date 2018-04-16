library(dplyr)
library(ggplot2)
library(reshape2)

#user can change the stock price 
Drift_annual = 0.10
Volatility_annual = 0.40
Initial_Stock = 100.00

#initiation
Drift_daily = Drift_annual / 252
Volatility_daily = 	Volatility_annual / sqrt(252)
Drift_mean = 	Drift_daily - 0.5 * Volatility_daily * Volatility_daily

i = 1
j = 1
m = matrix(data = NA, nrow = 100, ncol = 30)

set.seed(101)
z = matrix(rnorm(3000),100,30)
log_ret = Drift_mean + Volatility_daily * z

#iterations
for (j in c(1:100)) {
  s = Initial_Stock
  for (i in c(1:30)) {
    m[j,i] = s * exp(log_ret[j,i])
    s = m[j,i]
  }
}

#results
d = data.frame(m)
df = as.data.frame(t(d))

#export to csv
write.csv(df,"E:/Acads/R/CSInterview/All_Combinations.csv")
