# Statistics Tutorial - Day 5 - Exercise
# Created By: Prabesh Dhakal on 2020-05-06
# Last Edited: 2020-05-06

#### Goals ####
# 1. Make box plot
# 2. Extract the quartiles of the data
# 3. Distribution of the data

#### Instruction ####


# Please run the following code in order to store
# a list of numbers in your R environment.
# The exercise will be based on the variable named "df_width".
# You can see that the variable "df_width" is set in line 25
# Don't change the following 6 lines for the exercise.

github_url <- "https://raw.githubusercontent.com/prabeshdhakal/"
repo_url <- "teachings/master/2020_Stats_and_Maths/R_Files/datasets/clusters.csv"
full_url <- paste0(github_url, repo_url)
df <- read.table(full_url, header=TRUE, sep=",")
colnames(df) <- c("height", "weight", "length", "width", "speed", "damage")

df_width <- df$width

# You can continue with the tasks below:

#### Task 1: Box plot (~1 line of code) ####
# write your code below this line:



# Based on the box plot, answer the following:
#   Question 1: Are there any outliers?
#   Question 2: Can you say anything about the distribution of the width
#               by just looking at the box plot?

# ----------------------------------- * ------------------------------------ #

#### Task 2: Quartiles (~1 line of code)####
# Identify the following:
#   median, first quartile, third quartile
# write your code below this line:


# Question: based on the mean and the median, 
#                   can you say that the data is skewed?





# ----------------------------------- * ------------------------------------ #

#### Task 3: Data Distribution (~1 line of code)####
# What would be the best way to represent this distribution?
# (Hint: The data is continuous.)
# write your code below this line:


# How is the data distributed?
# What are the important parameters for this type of distribution?




# ----------------------------------- * ------------------------------------ #

#### Task 4: Challange yourself (many lines of code) ####
# Do as many things you can with the variable "df_width" 
# or with the data frame "df".
# (Both "df_width" and "df" are loaded when you run lines 19 - 25.)
# Examples of things you could do: summary statistics, different plots, ...



