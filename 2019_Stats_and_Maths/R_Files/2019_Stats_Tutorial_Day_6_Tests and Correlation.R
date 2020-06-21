# Statistics Tutorial - Day 6 - Walkthrough

# Created By: Prabesh Dhakal on 15.05.2019 
# Last Edited: 19.05.2019

#### Goals ####

# 1. Load data from the local storage
# 2. Perform a test of normality (Shapiro-Wilk's Test + Q.Q. Plot)
# 3. Perform a test of equality of variance (F-test) 
# 4. Perform a test of equality of means (t-Test)
# 5. Find correlation

# Primary Question: 
# Are average CO2 emission between electric cars and petrol cars equal?

#### Load + Process the Data ####

# Read the data file named pollution_data.csv
# Disclaimer: this data set was created for the purpose of this tutorial,
#             and hence, has no basis in reality (it is just an example).

pollution <- read.csv(file.choose())

# Alternatively, to reading the file, do:
# (i) set the working directory
# setwd("path/to/your/project/folder")
# (ii) use file name
# pollution <- read.csv('pollution_data.csv')
# this method is recommended. See the video linked below to learn more:
# Video on working directory : https://www.youtube.com/watch?v=LNw6hzGgyxM


# inspect the data
head(pollution)
str(pollution)
summary(pollution)

# subset the data by type of car (for convenience)
electric <- subset(pollution, car_type == 'electric')
petrol <- subset(pollution, car_type == 'petrol')

# We want to compare mean CO2 output of the two groups of cars. (t-Test)
# 3 key decisions of t-test: independence, normality, variance

#### 1. Independence ####

# Is the data independent?
# => yes. ( ans. depends on your methodologies ) <=> no formal test for this

#### 2. Test for Normality ####

# 2.1 Histograms
hist(electric$co2)
hist(petrol$co2)
# Problem: you need to rely on your gut

# 2.2 Shapiro-Wilk's Test
# H0 : normally distributed
# H1: not normally distributed

shapiro.test(electric$co2)  # p-value not low = cannot reject the H0
shapiro.test(petrol$co2)    # again, p-value not low = cannot reject the H0

# Problem: not a strong test

# 2.3 Quantile-Quantile Plot

qqnorm(electric$co2)
qqline(electric$co2)

qqnorm(petrol$co2)
qqline(petrol$co2)

# also relies on your judgement, but it is more systematic

## FINAL RECOMMENDATION:
# - USE MORE THAN 1 "TEST" if possible
# - If data is non-normal, perform data transformation
# - Check out some non-parametric test alternatives


#### 3. F-Test (Test for Equality of Variance)  ####

# 3.1 Calculate variance and make a gut judgement
var(electric$co2)
var(petrol$co2)
# Problem: your "gut" cannot be trusted

# 3.2 Perform a logical operation to check for equality
var(electric$co2) == var(petrol$co2)
# Problem: values have to be EXACT, precision is not enough 
# (3.8888889 is not the same as 3.8888888 even though you might only see 3.8888)
3.88888888888 # if you run this line, you get 3.888889 as an output
3.88888888888 == 3.888889 # this says otherwise

# 3.3 Perform a F-Test to compare variances
# H0 : Ratio of variance is equal to 1
# H1 : Ratio of variance is NOT equal to 1

var.test(co2 ~ car_type, data = pollution)
# p-value is low = reject the H0


#### 4. t-Test: (Test for Equality of Means) ####
# (2 tailed)
# H0 : means are equal
# H1 : means are not equal

# From the tests above, we have the following assumptions:
# i.    Samples are independent, (+ randomly drawn + representative) [gut feeling]
# ii.   Groups follow a normal distribution [histogram, Shapiro-Wilk & Q-Q Plots]
# iii.  Variance between the groups are different [F-test]

?t.test
# DEFAULT ARGUMENTS FOR t-Test: => standard setting for t-Test in R
# - alternative = 'two.sided'
# - mu = the mean difference value you want to set
# - paired = FALSE => (paired t-test = t test between related sample sets)
# - var.equal = FALSE => assumes that variances are unequal
# - conf.level = 0.95 => this is the same as saying significance level (alpha) = 0.05


t.test(electric$co2, petrol$co2)
# p-value is low = reject the H0
# => the mean co2 outputs between petrol and electric cars are not equal
# more formally: we reject the null hypothesis that the mean co2 outputs between
# electric cars and petrol cars are equal at significance level of 5% with p-value
# of 2.2e-16

# the following will give you the same result as line 104
t.test(co2 ~ car_type, data = pollution)

# store the t-Test into an object and extract parts of it
co2_ttest <- t.test(electric$co2, petrol$co2) 

co2_ttest$p.value # p-value
co2_ttest$statistic # test statistic
co2_ttest$parameter # degree of freedom


#### 5. Correlation ####
plot(pollution$co2, pollution$methane)

# are co2 emission and methane emission related?
cor(pollution$co2, pollution$methane)

# "Testing" Correlation
# H0 : correlation is equal to 0
# H1 : correlation is not equal to 0

cor.test(pollution$co2, pollution$methane)
# p-value is very very low: we reject the H0
# => there is a strong correlation between CO2 and Methane output
