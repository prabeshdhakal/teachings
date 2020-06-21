# Statistics Tutorial - Day 6 - Walkthrough

# Created By: Prabesh Dhakal on 26.05.2019 
# Last Edited: 27.05.2019

#### Goals ####

# 1. Load data
# 2. Perform a correlation (for two data)
# 3. Perform a regression analysis (for two data)
# 4. (load new data +)Perform an ANOVA test (next week)


#### Load + Process + Inspect the Data ####


# a custom pair of data
student_attitude <- c(94,73,59,80,93,85,66,79,77,91) # a vector
correct_answers <- c(17,13,12,15,16,14,16,16,18,19) # a vector
student_df <- data.frame(student_attitude, correct_answers) # a dataframe

# the other data set we will use is the built-in `cars` data set

#### 1. Correlation ####

#### 1.1 Data from students  ####

# inspect the data

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


#### 1.2 Built-in "cars" dataset ####

plot(cars$speed, cars$dist)

cor(cars$speed, cars$dist) # = 0.8068949 


#### 2. Regression using lm() function ####

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


#### 3. ANOVA  ####

# Load the yields.txt data into R
dat <- read.table(file.choose(),header=T)
attach(dat)

# Inspect the yields dataset
str(dat)
summary(dat)



boxplot(yield ~ soil, ylab="Yield [mg]", xlab = 'Soil type')

# R always sorts x-axis labels alphabetically, 
# if you want to sort from lowest to highest:
# change order by defining soil to be an ordered factor
soil <- factor(soil,levels=c("sand","clay","loam"))
#Create the boxplot again
boxplot(yield ~ soil, ylab="yield [mg]", xlab = 'Soil type')

####The following plots explain SSY (total sum of squares), SSE (error sum of squares)
# and SSA (treatment sum of squares OR explained variation) SSA = SSY-SSE
# SSA = explained variation = treatment sum of squares
# SSE = unexplained variation = error sum of squares
# SSY = SST = total variation = data points to overall mean
# These plots explain the theory,you will not do this for every ANOVA!
plot(yield)

# Compare groups:
par(mfrow=c(1,2)) # section the plot windo into two columns

## Column 1
# Draw an empty plot
plot(yield, pch="")
points(yield[soil=="sand"], pch=15)
points(11:20,yield[soil=="clay"],pch=3)
points(21:30,yield[soil=="loam"],pch=24)

abline(h=mean(yield), col="red", cex = 2) # mean of all the yeild data

# draw lines from the mean to the data points
for(i in 1:30){
  lines(c(i,i), c(yield[i], mean(yield)))
}

text(3,18,"SSY") # add a text label for Total Sum of Squares (=SST)


## Column 2
# Draw another empty plot
plot(yield, pch="")
points(yield[soil=="sand"], pch=15)
points(11:20, yield[soil=="clay"], pch=3)
points(21:30, yield[soil=="loam"], pch=24)

SANDmean <- mean(yield[soil=="sand"]) # calculate mean yield for sand
lines(c(0,10),c(SANDmean,SANDmean), col='cornflowerblue', lwd=3) # draw a line for mean of sand

CLAYmean<-mean(yield[soil=="clay"]) # mean for yield for clay
lines(c(11,20),c(CLAYmean,CLAYmean), col = 'firebrick', lwd = 3) # a line for mean of clay

LOAMmean<-mean(yield[soil=="loam"]) # mean for loam
lines(c(21,30),c(LOAMmean,LOAMmean), col = 'seagreen', lwd = 3) # a line for mean of loam

# draw lines from mean of each group to their corresponding points :
for(i in 1:10)lines(c(i,i),c(yield[i],mean(yield[soil=="sand"]))) 
for(i in 11:20)lines(c(i,i),c(yield[i],mean(yield[soil=="clay"])))
for(i in 21:30)lines(c(i,i),c(yield[i],mean(yield[soil=="loam"])))
text(3,18,"SSE") # add text label for Sum of Squared Errors (from Mean)

#### plots to explain SSY (total sum of squares) AND SSE (error sum of squares; unexplained), 
# when SSE is zero
# SSA (treatment sum of squares OR explained variation) SSA = SSY-SSE
xvc <- 1:15
yvs <- rep(c(10,12,14),each=5)
par(mfrow=c(1,2))
plot(xvc,yvs,ylim=c(5,16),pch=(15+(xvc>5)+(xvc>10)))
for(i in 1:15)lines(c(i,i),c(yvs[i],mean(yvs)))
abline(h=mean(yvs),col="red")
text(3,15,"SSY")
plot(xvc,yvs,ylim=c(5,16),pch=(15+(xvc>5)+(xvc>10)))
lines(c(1,5),c(10,10),col="red")
lines(c(6,10),c(12,12),col="red")
lines(c(11,15),c(14,14),col="red")
text(3,15,"SSE")



#################################
# ANOVA
# Two approaches to calculate ANOVA in R
# Refer to the book chapter on ANOVA that is uploaded on MyStudy
# And watch videos (linked on slides from Day 8)
# To understand this better

# Yield figures differ based on soil <=> yield depends on soil
# We want to check if the mean yield of each soil type
# differ from one another

# H0: The (population) means of all groups are equal
# H1: Not all means are equal

#1. Use lm() and then anova()
model <- lm(yield ~ soil)
#summary(model)
anova(model)

#2. Use aov() directly
model <- aov(yield ~ soil)
summary(model)

hist(resid(model))
shapiro.test(resid(model))
# fail to reject the null



# test for homogeneity of variance, Fligner-Killeen Test
fligner.test(yield~soil)
# fail to reject the null


# Another think you could do is test every factor level against each other 
# To do this, use TukeyHSD
# If you run help(TukeyHSD), you will see that it takes aov fit as input (x)

TukeyHSD(model) # `model` was fitted in a line above using aov() function 

# Data in R guinea pigs, two-way ANOVA
data(ToothGrowth) # Load ToothGrowth data (built in to R)
?ToothGrowth # learn about the data

# Create a box plot of the data
boxplot(len ~ dose:supp, data = ToothGrowth,
        boxwex = 0.5, col = c("orange", "yellow"),
        main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg", ylab = "tooth length",
        sep = ":", lex.order = TRUE, ylim = c(0, 35), yaxs = "i")

# fit the linear model (regression)
model<-lm(len~dose+supp,data=ToothGrowth)
# perform anova test
anova(model)

hist(resid(model))
shapiro.test(resid(model))
fligner.test(len~dose,data=ToothGrowth)
fligner.test(len~supp,data=ToothGrowth)

