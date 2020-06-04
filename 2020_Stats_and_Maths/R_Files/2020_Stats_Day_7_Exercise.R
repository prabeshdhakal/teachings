# Statistics Tutorial - Day 7 - Performing Statistical Tests
# Created By: Prabesh Dhakal on 2020-05-26
# Last Edited: 2020-05-28


#### Goals: ####
#     i. Perform the t-Tests
#             - 1 sample t-Test
#             - Paired t-Test
#             - Independent t-Test (same var. assumed)
#             - Independent t-Test (diff. var. assumed)
#    ii. Perform F-Test

# ----------------------------------- * ----------------------------------- #

#### Task 1: One Sample t-Test ####

# Problem I: ----
# A company designed a machine that purifies toxic water produced by leather
# factories. It claims that the machine can process 7 liters of water per hour. 
# You are an auditor that works for the environmental agency and need to test
# this claim in order to certify the machine and collected the following data
# from the machine at different time of the day:

# data you collected:
processed_water <- c(5.20, 9.29, 6.06, 5.65, 8.26, 
                     6.83, 10.23, 6.15, 5.91, 9.34) # liters per hour

theoretical_mean <- 7 # liters per hour

mean(processed_water) # sample mean

# H0: sample mean and (hypothesized) population mean are equal
#       = the machine processes 7 liters of water per hour
t.test(processed_water, mu=theoretical_mean, conf.int=0.95)

# Problem II: ----
# Let's say that the factory claimed that the minimum amount of water processed
# per hour is 7 liters. How would you test that?
#      => this is when we use a one tailed test

# In this case, the hypotheses look like this:

# H0: amount of water processed per hour >= 7 liters
# H1: amount of water processed per hour < 7 liters
t.test(processed_water, mu=theoretical_mean, alternative="less")

#### Task 2: Paired t-Test ####

# Problem I: ----
# As a sustainability scientist, you are experimenting with different ways
# of reducing food waste from kids in school. So, you collect data on the mass
# of food wasted by 10 kids for 1 week. Then, you give an hour long presentation
# about the downsides of wasting food to the 10 kids. After this, you again
# collect data on the mass of food wasted by the kids for 1 week.

# data you collected:

before_presentation <- c(2.97, 0.12, 2.23, 2.91, 1.96, 
                         3.73, 0.25, 0.23, 0.32, 0.96) # food wasted in kg

after_presentation <- c(2.47, 0.38, 1.73, 2.41, 1.46, 
                        3.23, 0.25, 0.27, 0.18, 0.46) # food wasted in kg

# H0: the mean amt. of food wasted before and after the presentation are equal
t.test(before_presentation, after_presentation, paired=TRUE)


# Problem II: ----
# You want to check how two different sleep inducing drugs work on same group
# of 10 people. So, you collect the data and store it in a data table.

# You can find out more about built-in datasets with: ?dataset_name
# for `sleep` dataset:
?sleep

# Here, ID refers to the id of the individuals, and group refers to the two
# different types of drugs (group 1 = drug 1 and group 2 = drug 2).
# The drugs are being administered to same group of people (same sample) in both
# the cases.

# H0: the mean effect of the two drugs are same
t.test(extra ~ group, data=sleep, paired=TRUE)

# Here, `extra` is the dependent variable (amount of sleep)
# and `group` is the independent variable (the drug administered)


#### 3: Independent t-Test (same var. assumed) ####

# Problem:
# You want to check the amount of CO2 emmissions of 
# eating seasonal food vs. eating regional food. (Emmissions in kg)
# You have the following data:

seasonal <- round(rnorm(44, 20, 5.5), 2) # CO2 emmission in kg
regional <- round(rnorm(50, 22, 4), 2)  # CO2 emmission in kg

print(seasonal)
print(regional)

mean(seasonal) # mean co2 output (kg)
mean(regional) # mean co2 output (kg)

t.test(seasonal, regional, var.equal = TRUE)
# Note that we assumed the variances of the two samples to be equal in this test

#### 4: Independent t-Test (diff. var. assumed) ####

# Take the same dataset as above. Earlier, we assumed that the variances are
# equal. However, we cannot really be sure that the variances are equal as we 
# have not made any tests about equality of variances yet. So, let's perform
# the same test with the assumption that the variances are different.

t.test(seasonal, regional, var.equal = FALSE)

# How is this result different from the case 
#    in earlier section (Section 3 above)?

#### 5: F-Test ####

# Now, let's see if the variances of the two samples from Section 3 & 4 
# are actually different.

# Data:
seasonal <- round(rnorm(44, 20, 5.5), 2) # CO2 emmission in kg
regional <- round(rnorm(50, 22, 4), 2)  # CO2 emmission in kg

# Variances at a glance: significantly different?
var(seasonal)
var(regional)

# H0: The variances are equal
# H1: The variances are not equal
var.test(seasonal, regional)


#### Tasks: ####
# 1. Perform Task 1 with a theoretical mean of 8 instead of 7. How does the test
#    result differ?
# 2. Perform Task 1 with confidence level of 99% instead of 95%. How does the
#    result differ?
# 3. Let's rethink Task 4. Instead of checking for the equality, you have a  
#    hypothesis that eating strictly regional food is much better than eating
#    strictly seasonal food. How do your hypotheses change? State the new 
#    hypotheses and perform the test.
#