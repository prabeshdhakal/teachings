# Statistics Tutorial - Day 10 - Revisit

# Created By: Prabesh Dhakal 
# Last Edited: 24.06.2019

#### Goals ####
# Revisit:
# 1. Shapiro Wilk's Test for Normality
# 2. One-Way ANOVA
# 3. Two-Way ANOVA


### First, presentation: ----

# create a vector of group names
groups = c('Pi',
           'Blue & Glue',
           'Not presenting next week',
           'Flisckq',
           'Vanilla Thunder')

# pick 1 name randomly from the vector above
set.seed(10)
sample(groups, size = 1)


#### 1. Shapiro-Wilk's Test ####
# we will perform this in section 2

#### 2. One-Way ANOVA  ####
# H0: The (population) means of all groups are equal
# H1: Not all means are equal

# read the data
plants = PlantGrowth
attach(plants)

# check out the data
str(plants)
summary(plants)

# 
# Visual inspection of group means
boxplot(weight ~ group, ylab='Weight of plants', xlab='Groups')


# 2 approaches to perform ANOVA in R:

#1. Use lm() and then anova()
model <- lm(weight ~ group)
#summary(model)
anova(model)


#2. Use aov() directly
model <- aov(weight ~ group)
summary(model)



# Check if the residuals are normally distributed

## Shapiro-Wilk's Test for Normality ----

# In Shapiro-Wilk's Test:
# H0 :  the population is normally distributed
# H1 :  the population is not normally distributed

hist(resid(model))
shapiro.test(resid(model))

#### 3. Two Way Anova ####

# Check if the means differ based on 2 factors of variability

# H0 : The means are equal for both factor variables
# H1 : The means not same for at least one of the factor variables

# read the `poison1.csv` file into R

# use read.csv() or "Import Dataset" from top right
df <- poisons1 
attach(df)

str(df) # inspect the structure

df$poison <- as.factor(df$poison) # convert the `poison` column to factor

str(df) # inspect the structure
# time = survival time of hamsters
# poison = types of poison
# treat = types of treatment


#1. Use lm() and then anova()
model <- lm(time ~ poison + treat)
#summary(model)
anova(model)


#2. Use aov() directly
model <- aov(time ~ poison + treat)
summary(model)
