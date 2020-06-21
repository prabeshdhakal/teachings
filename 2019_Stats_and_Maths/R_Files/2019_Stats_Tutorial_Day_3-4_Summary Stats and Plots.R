# Statistics Tutorial - Day 3+4 - R

# Created By: Prabesh Dhakal on 28.04.2019 
# Last Edited: 30.04.2019

#### Goals: #### 
#   (i)   Create a vector with our data, 
#   (ii)  Perform summary statistics
#   (iii) Create scatter plot, line chart, bar chart, histogram, box plot
#   (iv)  Add horizontal lines showing the quartiles in the box plot
#   (v)   [optional] How the groups were created yesterday

#--------------------------------#

## (1) create a vector of numbers

# notice that the things are separated by commas `,` inside c()
class_vec <- c(17, 12, 14, 7, 8, 19, 23, 19, 10, 7, 12, 7, 12)

## (2) Get summary statistics on the vector of numbers
summary(class_vec)

## (3) Create normal plot, box plot, and bar plot

# Scatter plot
plot(class_vec)

# A line chart
plot(class_vec, type = 'l')

# Bar chart
barplot(class_vec, main = 'Bar plot for the vector')

# Histogram
hist(class_vec)

# Box plot with title
boxplot(class_vec, main = 'Box plot for the vector')

## (4)  Add lines for quartiles

# Red horizontal line for median
median_class_vec <- median(class_vec) # calculate the median
abline(h = median_class_vec, col = 'red') # add the horizontal line for median


class_vec_summary <- summary(class_vec) # store the summary into an object

lower_quartile_class_vec <- class_vec_summary[2] # access the lower quartile
upper_quartile_class_vec <- class_vec_summary[5] # access the upper quartile
# median could also be accessed with: `median_class_vec <- class_vec_summary[3]`

abline(h = lower_quartile_class_vec, col = 'blue') # blue line for Q1
abline(h = upper_quartile_class_vec, col = 'green') # green line for Q3





## (5) [optional] Random assignment of groups

n_students <- 25 # number of students in the class

seq_n_students <- seq(n_students) # creates a vector of a sequence of numbers

randomized <- sample(seq(n_students), n_students) # randomly order the numbers

groups <- matrix(randomized, nrow = 5, ncol = 5) # put the numbers into a matrix

groups <- as.data.frame(groups) # convert it into a data frame (optional)

# add column names to the data frame
colnames(groups) <- c('Group A', 'Group B', 'Group C', 'Group D', 'Group E')

View(groups) # open the result data frame in a separate tab