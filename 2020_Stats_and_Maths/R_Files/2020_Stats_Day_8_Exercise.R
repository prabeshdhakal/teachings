# Statistics Tutorial - Day 8 - Correlation and Regression
# Created By: Prabesh Dhakal on 2020-06-03
# Last Edited: 2020-06-03


#### Goals: ####
#     i. Calculate correlation
#    ii. Perform regression

# ----------------------------------- * ----------------------------------- #

#### 0. Load + Process + Inspect the Data ####

# a custom pair of data
student_attitude <- c(94,73,59,80,93,85,66,79,77,91) # a vector
correct_answers <- c(17,13,12,15,16,14,16,16,18,19) # a vector
student_df <- data.frame(student_attitude, correct_answers) # a dataframe



#### 1. Correlation ####
plot(density(student_attitude))
plot(density(correct_answers))

plot(student_attitude, correct_answers)
plot(student_attitude, correct_answers, xlim = c(0,100), ylim = c(0,20))
# can you perceive any linear pattern?

# Method 1: Using the formula with covariance
cov_attitude_answer <- cov(student_attitude, correct_answers) # calculate covariance
sd_attitude <- sd(student_attitude) # calculate sd
sd_answers <- sd(correct_answers) # calculate sd

cov_attitude_answer/(sd_answers*sd_attitude) # = 0.5960948

# Method 2: Use the "cor()" function
cor(student_attitude, correct_answers) # also = 0.5960948




# Sidenote: ----

# If you have to plot the regression line over the scatter plot,
# Don't use scatter.smooth(): smoothing is diff. from fitting a linear regression
scatter.smooth(student_attitude, correct_answers) # danger

# Do this:
plot(student_attitude, correct_answers)
abline(lm(correct_answers~student_attitude, data=student_df))


#### 2. Regression ####

#### 2.1 Data from students ####

# independent variable = student_attitude
# dependent variable = correct_answers
model_students <- lm(correct_answers ~ student_attitude, data = student_df)

model_students # this is the linear regression model that you created

summary(model_students)

# p-value (for each coefficient): 
# H0 = Coefficients of variables is equal to zero
# H1 = Coefficients are not equal to zero 
#        = there exists a reln. between independent var. in question & dependent var.
# p-value low => the independent var. has strong reln. with the dependent var. 

# Adjusted R-squared is a better value to take as
# the coefficient of determination because it adjusts for large number of 
# independent variables.

#### 2.2 Built-in "cars" dataset ####

# we assume that stopping distance `dist` depends on
# how cast the car is moving `speed`
# hence dist is the response and speed the predictor variable
# in the linear model below
model_cars <- lm(dist ~ speed, data = cars)

model_cars

summary(model_cars)

# think about the p-value of coefficients
# think about the adjusted R-squared value. What does it mean?

#### 2.3 Inspect Residuals of a Model from Above ####

par(mfrow=c(2,2)) # divide the plot into 4 sections

# 1. Check the linear relationship between two variables
plot(cars$dist, cars$speed, 
     pch = 16, col = 'seagreen', 
     main = 'Check Linear Relationship between Variables')

# 2. Check the homogeneity of model residuals
plot(model_cars$residuals, 
     pch = 20, col = 'firebrick', 
     main = 'Check for Homoskedasticity of Model Residuals')
#testing for homogeneity of variance, Fligner-Killeen Test
fligner.test(cars$dist ~ cars$speed)
# fail to reject the null

# 3. check if the model residuals follow a normal distribution
hist(model_cars$residuals, 
     col = 'gray85', 
     main = 'Histogram of Model Residuals for Normality Check') # create diagnostic plots for residuals of the model
qqnorm(model_cars$residuals, 
       pch = 15, cex = 0.85, col = 'cornflowerblue', 
       main = 'QQ-Plot of Model Residuals for Normality Check')
qqline(model_cars$residuals, 
       col = 'firebrick', cex = 1.5)

## 4. p-values for coefficients:
# p-value for intercept 0.0123 (intercept is sig. at alpha = 0.05)
# p-value for coefficient for speed variable is 1.49e-12 (sig. at alpha very very close to 0)

## Coefficient of determination from Adjusted R-squared
summary(model_cars) # 0.6438 --> what does this figure mean?

#### 2.4 Bonus: Make predictions ####
# make predictions using our linear model
cars$speed
new_car_speeds <- c(100, 70, 10, 9, 7, 4, 3, 0) # 8 new observations
new_speeds <- data.frame(speed = new_car_speeds) # create a data frame with same column header

pred_dist <- predict(model_cars, new_speeds) # perform a prediction using the model and new data

View(data.frame(new_car_speeds, pred_dist)) # view the result
# there is a slight problem with the predictions that you saw earlier,
# some of the predicted values are -ve
# this is not possible for distance (which is a ratio data with true 0)
# it is up to the scientist to identify issues like this
# and take them into account when making interpretations