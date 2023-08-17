#-----------------
# OSC Test Script!
# Author: Lizbeth G Amador
#-----------------

#libraries
library(tidyverse)

## Simple Linear regression output
set.seed(2)

#Generating n normal observations from a population
n = 100
x = rnorm(n, 50, 9)
#Generating n error observations from population
err = rnorm(n, 0, 10)
# Generating depdent variable
y = 150 + 5*x + err

#Fitting the model
fit = lm(y~x)
summary(fit)

#Checking assumptions -- to see if plots will appear in the output file
par(mfrow=c(2,2))
plot(fit)


## Generating an export - uncomment
# ggplot() + geom_point(aes(x=x, y=y), pch=16, col="blue")
# ggsave("Regression_Test.png", plot = last_plot(), path = "")


## Generating an error - uncomment 
#summary(fit1)





