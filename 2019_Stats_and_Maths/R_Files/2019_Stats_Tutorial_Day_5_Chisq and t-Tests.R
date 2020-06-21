# Statistics Tutorial - Day 5 - Walkthrough

# Created By: Prabesh Dhakal on 12.05.2019 
# Last Edited: 13.05.2019

#### Goals: #### 
#     (i)  Load a data from the local storage
#     (ii) Perform Chi-Square Test of Independence
#     (iii)  Perform a Shapiro-Wilk's Test of Normality


#### Section I ----------------------------------------------------------------

# Set your working directory
setwd("C:/Users/prabe/Google Drive/02_Work/05_Teaching/2019-Statistics Tutorial/Day 6  - Res")


#### 1. Read the data file ####
survey <- read.csv('Survey_Chi-Sq_data.csv', encoding = 'utf-8')
colnames(survey) <- c('tutor', 'mood', 'dist_km')

# Check out the data
head(survey) # check the first 5 rows
str(survey) # check the structure
summary(survey) # perform summary statistics on the data frame


#### 2. Chi-Square Test for Independence ####
# H0 : The two variables are (stochastically) independent
# H1 : The two variables are related

# 2.1 Create a contingency table
contingency_table <- table(survey$tutor, survey$mood)
View(contingency_table) # Check how the cont. table looks like

# 2.2 Calculate X2 statistic
chisq.test(contingency_table) 
# the p-value smaller than 0.05 : we reject the H0
# ==> the two variables are related

# 2.3 R does all the work for you:
# you could skip 2.1 and 2.2 altogether (saves time and effort)
chisq.test(survey$tutor, survey$mood)


#### 3. Shapiro-Wilk's Test of Normality ####
# Only applies to data set with observation between 3 and 5000

# In Shapiro-Wilk's Test:
# H0 :  the population is normally distributed
# H1 :  the population is not normally distributed

shapiro.test(survey$dist_km)
# The p-value is (a lot) smaller than 0.05 : we reject the H0
# ==> the population is not normally distributed


# CAUTION!! THIS TEST IS NOT ROBUST FOR DATA SMALLER THAN ~ 20 and BIGGER THAN ~80
# ANOTHER APPROACH, SEE BELOW:

hist(survey$dist_km,
     col = 'gray85',
     main = 'Histogram of the variable dist_km',
     xlab = 'Values',
     ylab = 'Rel. frequency/Density')

hist(survey$dist_km,
     col = 'gray85',
     main = 'Histogram of the variable dist_km',
     xlab = 'Values',
     ylab = 'Rel. frequency/Density')





##### Misc. ####
# Density plot overlapped onto a histogram
hist(survey$dist_km, 
     breaks = 100,
     freq = FALSE,
     col = 'gray85',
     main = 'Histogram of the variable dist_km',
     xlab = 'Values',
     ylab = 'Rel. frequency/Density')
lines(density(survey$dist_km), col = 'darkred', cex = 4)

plot(density(survey$dist_km), col = 'darkred', cex = 2)
