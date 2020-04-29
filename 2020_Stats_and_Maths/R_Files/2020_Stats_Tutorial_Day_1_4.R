# Statistics Tutorial - Day 1 / 4 - Walkthrough
# Created By: Prabesh Dhakal on 2020-04-14
# Last Edited: 2020-04-29


#### Goals: ####
#     i. Use R for the first time,
#    ii. Learn about basic data types,
#   iii. Work with real dataset

# ----------------------------------- * ----------------------------------- #


#### 1. Basic Stuffs ####

# This is a comment
# Use comments to take notes/explain steps/make to-do lists, etc

# Run a line of code with "Ctrl/Strg + Enter" or "Shift + Enter"


# Basic mathematics operations in R:

3 + 0.14
55 - 13
11 * 5
162 / 9

2 ** 2
2 ^ 2

30 %% 9 # modulo operation

# mathematical constants

pi
month.abb
month.name

# "Variables" work like they do in mathematics
    # they store values that could be many things:
    # numbers, text, data tables, matrices, functions ...
# They are also called "objects" for technical reasons.

# You can store values in variables using "assignment operators"
#  which are arrow (<-) and equals-to sign (=)

a = 3.14
b = pi

# you can see what is stored in an object by using print statements
print(a)
print(b)
print("This is my text.")

#-------------------------------------------------------------------------#

#### 2. Data Types ####

# 2.1 Bad examples:
my_var <- 9              # number
myVar = 3.2              # number
myvar <- "a text"        # character or string
my.var <- 3 + 4i         # complex numbers
mYvAr = TRUE             # boolean

myvar_ <- 9L

class(myvar_)  # check if


# Question: Why are the examples above bad?




# giving your variables meaningless names like "myvar" or its variations
# is not a good idea. Give your variables more meaningful names.

# 2.2 Slightly better names:

my_num <- 9
my_int <- 9L
my_char <- "a text"
my_complex <- 3 + 4i

# 2.3 Data structures
my_vector <- c(1, 3, 5, 7, 9, 11)
my_df <- data.frame()
my_matrix <- matrix()


# Using "my" in your variable name is useful
# when you are learning it for the first time.
#    but, you will find that it is 
#    not vary useful for general tasks.

# Be consistent in how you name your variables
#  - use lower case
#  - either use camel case: "UserResponseMatrix"
#        or use snake case: "user_response_matrix"
#  - numbers cannot be used as variables/objects
#      but, you can place numbers 
#      at the end or the middle of the name: "customer1"

# don't make obvious comments like the following:

my_range = 1:5 # a range
my_seq = seq(1, 5, 1) # a sequence



#-------------------------------------------------------------------------#

#### 3. Use R with the list of numbers ####

num_list <- c(17, 12, 14, 7, 8, 19, 23, 19, 10, 7, 12, 7, 1200)

num_list_sorted <- sort(num_list, decreasing=FALSE) # use the sort function

N <- length(num_list) # the number of items in the list

num_list_sum <- sum(num_list)

num_list_mean <- num_list_sum / N # mean

# R provides many statistical functions
mean(num_list)
median(num_list)


max(num_list)
min(num_list)

var(num_list)

sd(num_list)


quantile(num_list, c(0.25, 0.5, 0.75)) # all quartiles

num_list_summary = summary(num_list)
num_list_summary[2]
num_list_summary[5]



boxplot(num_list)
hist(num_list) # notice how the large value skews the distribution

# what if a statistical function is not available on R?
# => Packages!

BBmisc::computeMode(num_list)

library(stats)
mad(num_list) # median absolute deviation
mad(num_list, center=mean(num_list)) # mean absolute deviation

#-------------------------------------------------------------------------#

#### 4. Install Packages, Use Functions ####


# 4.1 Install and Load a Package

install.packages("swirl") # install a package

library(swirl) # load a library

# 4.2 Use functions that come with R (built-in functions)

airquality # a built-in dataset

str(airquality) # inspect the structure of the dataset
summary(airquality) # get summary statistics

# 4.3 Make a plot
wind <- airquality$Wind # extract colmns with column names
temp <- airquality[, 4] # extract columns with column number

plot(wind, temp)

# 4.4 Heeelp!
help(plot)

plot(x=wind, y=temp, main="Temp vs Wind Speed")


#### Tasks for you ####

# 1. Load a dataset called "mtcars".
# 2. Calculate summary statistics and try to understand the results.
# 3. Make a box plot of "mpg" column/variable from the mtcars dataset.
# 4. Are there any outliers in the mpg variable? 
#    What about hp variable in the mtcars data?

