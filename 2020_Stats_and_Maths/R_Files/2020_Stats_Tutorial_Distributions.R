# Statistics Tutorial - Day 4 - Different Distributions
# Created By: Prabesh Dhakal on 2020-04-29
# Last Edited: 2020-04-29


#### Goals: ####
#     i. Learn about different properties of different distributions

# ----------------------------------- * ----------------------------------- #


set.seed(8848)

N = 5e3

#### Uniform Distribution ####
# change N to see how smaller samples are false friends
hist(runif(N),
     main=paste0("Uniform Distribution (N=", N, ")"),
     xlab="Observations",
     col="gray")


#### Poisson Distribution ####
# change lambda parameter to see that for a large lambda,
# poisson distribution approximates the normal distribution
lambda = 1
df = rpois(n=N, lambda=lambda)
hist(df,
     main=paste0("Poisson Distribution (N=", N, 
                 ", lambda=", lambda, ")"),
     xlab="Observations",
     col="gray", 
     breaks=6)


#### Exponential Distribution ####
rate = 1
df = rexp(n=N, rate=rate)
hist(df,
     main=paste0("Exponential Distribution (N=", N, 
                 ", rate=", rate, ")"),
     col="gray")



#### Normal Distribution ####
# change mean to see how the histogram changes
# change sd to see how the data points spread apart or come together 
#       for different levels
N = 5e3
mean = 10
sd = 1

df <- rnorm(n=N, mean=mean, sd=sd)
hist(df,
     main=paste0("Normal Distribution\n", 
                 "(N=", N, ", mean=", mean, ", sd=", sd, ")"),
     col="gray",
     xlim=c(-5, 25))




library(ggplot2)


set.seed(1)
df_1 <- rnorm(n=N, mean=mean, sd=sd)
df_2 <- rnorm(n=N, mean=mean+5, sd=sd)

# Different mean
dat <- data.frame(dens = c(df_1, df_2), 
                  lines = rep(c("mean=10", "mean=15"), 
                              each = N))

ggplot(dat, aes(x = dens, fill = lines)) + 
    geom_density(alpha = 0.2) + 
    xlab("")

# Different variance
df_2 <- rnorm(n=N, mean=mean, sd=sd+1)
dat <- data.frame(dens = c(df_1, df_2), 
                  lines = rep(c("var=1", "var=4"), 
                              each = N))

ggplot(dat, aes(x = dens, fill = lines)) + 
    geom_density(alpha = 0.2) + 
    xlab("")



h <- hist(df, 
          breaks=10, 
          col="gray", 
          xlab="Observation",
          main="Histogram with Normal Curve", 
          ylim=c(0, 1100))

x <- seq(min(df), max(df), length=40)
y <- dnorm(x, mean=mean(df), sd=sd(df))
y <- y*diff(h$mids[1:2])*length(df)
lines(x, y, col="blue", lwd=2)



library(ggpubr)
ggdensity(df,
          main=paste0("Density Plot for a Normally Distributed Data\n",
                      "(N=", N, ", mean=", mean, ", sd=", sd, ")"),
          fill="gray",
          add="mean")
