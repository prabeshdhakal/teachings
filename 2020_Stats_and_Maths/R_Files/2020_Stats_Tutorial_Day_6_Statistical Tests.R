# Statistics Tutorial - Day 6 - Performing Statistical Tests
# Created By: Prabesh Dhakal on 2020-05-13
# Last Edited: 2020-05-14


#### Goals: ####
#     i. Tests for Normality
#    ii. Goodness of Fit (Chi-squared test)
#   iii. Test for Independence (Chi-squared test)

# ----------------------------------- * ----------------------------------- #

#### 1. Testing for Normality ####

# We have talked about several ways we can check if the data is normally
# distributed:
# 1. Box plot
# 2. Histogram
# 3. Density Plot
# 4. Q-Q Plot
# 5. Shapiro-Wilk's Test
# Let's try them all:

# Genrate some data:
set.seed(8848)
norm_vals <- rnorm(n=1000, mean=1.29, sd=1.44)


# 1.1 Box plot
boxplot(norm_vals)

# 1.2 Histogram
hist(norm_vals)

# 1.3 Density Plot
plot(density(norm_vals))

# 1.4 Q-Q Plot
qqnorm(norm_vals)
qqline(norm_vals)

# 1.5 Shapiro-Wilk's Test
shapiro.test(norm_vals)
# how do we interpret the results?
# First remember what the H0 and H1 of this test are:
# H0 : Data comes from normally distributed population
# H1 : Data does not come from normally distributed population
# Look at the p-value
# given a significant level (alpha)
# if p-value <= alpha, reject the null
# Usually, an alpha = 0.05 is chosen

# Let's see Shapiro-Wilk's test in action\
# with data we know does not come from a normally
# distributed population
another_data <- rgamma(n=1000, shape=3)
plot(density(another_data))
shapiro.test(another_data)

#### 2. Goodness of Fit Test (Chi-square Test) ####
# H0 : Both data come from the same distribution
# H1 : The data don't come from the same distribution

# Assume that you organized an event that and the no. of students, professors,
# and businesspeople that participated this year's event was 
# 232, 37, and 54 respectively.
# Last year, 70% students, 15% profs, and 15% businesspeople
# participated on same event.
# You want to know if this year's proportions look significantly different
# from the last year's.


participants <- c(S=232, P=37, B=54) # Students, Profs, Businesspeople
N = sum(participants) # Total no. of participants
participants_freq <- participants / N


freq_last_year <- c(0.70, 0.15, 0.15)

# i. Manually solving the problem

E_i <- freq_last_year * N # Expected Values

test_stat <- sum( (participants - E_i)^2/E_i ) # Chi-sq. test stat


# Making decision:
# Assuming significance level (alpha) = 0.05,
# check the Critical value on a table for Chi-square test
# Reject H0 if test statistic > crit. value
# Alternatively, check the p-value:
df <- 3 - 1 # degrees of freedom: k - 1 where k = no. of categories
p_value <- pchisq(test_stat, df=df, lower.tail=FALSE)
p_value

# Reject H0 if p-value <= significance level

# ii. Using R function to do this same thing
chisq.test(x=participants, p=freq_last_year)
# Either way, the way you make a decision stays the same.

#### 3. Test of Independence (Chi-square Test) ####
# H0 : The two variables are independent
# H1 : The two variables are not independent

# This example is an implemention of this YouTube video:
# https://www.youtube.com/watch?v=LE3AIyY_cn8
# Here, the two variables that we are interested in are:
# Gender and Color

# Create the original table
color_data <- matrix(c(100, 20, 150, 30, 20, 180), ncol=3)
colnames(color_data) = c("Blue", "Green", "Pink")
rownames(color_data) <- c("Boys", "Girls")
color_data

data_table <- as.table(color_data)
N = sum(data_table)

# The H0 and H1 for this particular problem:
# H0 : For the population of students, 
#       gender and fav. color are not related
# H1 : For the pop. of students, 
#       gender and fav. color are related
# significance level (alpha) = 0.05

addmargins(data_table)

E_blue <- c(270*120/N, 230*120/N)
E_green <- c(270*180/N, 230*180/N)
E_pink <- c(270*200/N, 230*200/N)

data.frame(E_blue, E_green, E_pink,
           row.names = c("Boys", "Girls"))

test_stat <- sum((100-64.8)^2/64.8, (150-97.2)^2/97.2, (20-108)^2/108,
                 (20-55.2)^2/55.2, (30-82.8)^2/82.8, (180-92)^2/92)

# Decision time:
# Check the critical value on the Chi-square test table
# Reject H0 if test stat > critical value

# Or, calculate the p-value
df = (2-1)*(2-1) # df = (nrows - 1)*(ncols - 1)
p_value <- pchisq(test_stat, df=df, lower.tail=FALSE)
p_value

# Reject H0 if p-value <= alpha

# Alternatively, do this:
chisq.test(data_table)

#### Tasks this week ####
# You will find a Problem Set in MyStudy. :) 
