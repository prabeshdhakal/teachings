# Statistics Tutorial - Day 8 - Correlation and Regression
# Created By: Prabesh Dhakal on 2020-06-10
# Last Edited: 2020-06-10


#### Goals: ####
#     i. Revisit simple linear regression
#    ii. Perform multiple linear regression
#   iii. Perform ANOVA

# ----------------------------------- * ----------------------------------- #
install.packages("corrplot")
library("corrplot")

#### 1. Regression revisited ####

# we assume that stopping distance `dist` depends on
# how cast the car is moving `speed`
# hence dist is the response and speed the predictor variable
# in the linear model below
model_cars <- lm(dist ~ speed, data = cars)

model_cars

summary(model_cars)

# 1.1 Assumptions/Requirements of Linear Regression ----

par(mfrow=c(2,2)) # divide the plot into 4 sections

# 1. Check the linear relationship between two variables
plot(cars$dist, cars$speed, 
     pch = 16, col = 'seagreen', 
     main = 'Check Linear Relationship between Variables')

# 2. Check the homogeneity of model residuals

plot(model_cars$residuals, 
     pch = 20, col = 'firebrick', 
     main = 'Check for Homoskedasticity of Model Residuals')

# 3. check if the model residuals follow a normal distribution
hist(model_cars$residuals, 
     col = 'gray85', 
     main = 'Histogram of Model Residuals for Normality Check')
qqnorm(model_cars$residuals, 
       pch = 15, cex = 0.85, col = 'cornflowerblue', 
       main = 'QQ-Plot of Model Residuals for Normality Check')
qqline(model_cars$residuals, 
       col = 'firebrick', cex = 1.5)

## 4. Significance of coefficients:
# Looks like both coefficients are significant.

# Coefficient of determination from Adjusted R-squared
summary(model_cars) # 0.6438 -> what does this figure mean?

# 1.2 Make predictions ----

# make predictions using our linear model
cars$speed

# 8 new observations for speeds of cars
new_car_speeds <- c(100, 70, 10, 9, 7, 4, 3, 0) 

# create a data frame with same column header
new_speeds <- data.frame(speed = new_car_speeds)

# perform a prediction using the model and new data
pred_dist <- predict(model_cars, new_speeds)

View(data.frame(new_car_speeds, pred_dist)) # view the result
# there is a slight problem with the predictions that you saw earlier,
# some of the predicted values are -ve
# this is not possible for distance (which is a ratio data with true 0)
# it is up to the scientist to identify issues like this
# and take them into account when making interpretations

#### 2. Multiple Linear Regression ####

# work with `mtcars` built-in dataset
str(mtcars)
summary(mtcars)

plot(mtcars)

model_1 <- lm(mpg ~ ., data=mtcars) # model with ALL independent variables
summary(model_1)

correlations <- cor(mtcars[, c(1, 3, 4, 5, 6, 7)])
corrplot(correlations, type="upper")

# some of the variables are categorical (eg. vs, am, cyl, ...)
# let's take that into account when performing linear regression
cat_cols <- c("cyl", "vs", "am", "gear", "carb")
mt_df <- mtcars
mt_df[cat_cols] <- lapply(mt_df[, cat_cols], factor)

str(mt_df)
summary(mt_df)

# models with categorical variables
model_2 <- lm(mpg ~ ., data=mt_df)
model_3 <- lm(mpg ~ hp + wt + disp, data=mt_df) # model with specific variables

# compare model_1 vs model_2 model_3
summary(model_1)
summary(model_2)
summary(model_3)


#### 3. ANOVA ####

# 3.1 Using anova() function ----

# One-way ANOVA
anova(lm(mpg ~ cyl, data=mt_df))

# Two-way ANOVA
anova(lm(mpg ~ cyl + am, data=mt_df))

# Two-way ANOVA (with interaction effects)
anova(lm(mpg ~ cyl * am, data=mt_df))


# 3.2 Using aov() function ----

# aov() is not that different from anova()
# but, you need to use summary() to see the
# details of the results of aov() 
# (anova does this automatically)

# One-way ANOVA
anova_1 <- aov(mpg ~ cyl, data=mt_df)
summary(anova_1)

# Two-way ANOVA
anova_2 <- aov(mpg ~ cyl + am, data=mt_df)
summary(anova_2)

# Two-way ANOVA (with interaction effects)
anova_3 <- aov(mpg ~ cyl * am, data=mt_df)
summary(anova_3)
# cyl:am is not significant as p-value > 0.05
# this means that the effect of interaction is not signifant
# (If the effect of interaction is signifant, it means that the combination
# of independent variables significantly influences the dependent variable.)


#### 4. Multiple Pairwise Comparison with TukeyHSD() ####

# Tukey Honest Signifant Differences is used to perform multiple
# pairwise-comarison between the means of groups AFTER the results of
# ANOVA has been identified as statistically significant (if H0 is rejected).
# This type of test is called Post-Hoc Tests.

# TukeyHSD():
#    - is performed with factors that are identified as "significant"
#       by ANOVA test
#    - is usually performed on factors with > 2 levels

TukeyHSD(anova_2)

# Looking at the p-values:
# There are significant differences in the mpg mean values 
#       between the different cylinder (cyl) types
# There are no significant differences in the mpg mean values
#       between the different am types

# Notes:
# On Post-hoc Tests: https://www.youtube.com/watch?v=F2R63oTqXRg
# TukeyHSD: https://rpubs.com/aaronsc32/post-hoc-analysis-tukey
