# Statistics Tutorial - Day 2 - Walkthrough

# Created By: Prabesh Dhakal on 11.04.2019 
# Last Edited: 30.04.2019

#### Goals: #### 
#     (i)   recap & tips, 
#     (ii) learn about basic data types
#     (iii) learn about vector objects
#     (iv)  work with real data in R

#--------------------------------#

#### 1. Recap and Tips ####

## ways to get help: function and a special command:
help(print) # using the help()  function
            # objects that print can take
            # arguments that print can take

?plot # using the question mark
 

## get a list of built in functions
builtins()

View(builtins())

## replacing values in objects

a <- 3
print(a)

a <- 5
print(a)

a <- a + 3
print(a)

#--------------------------------#

#### 2. Basic Data Types in R ####

## character or string: anything inside single or double quotes
a <- 'apple'

## numeric: whole numbers and decimal numbers
b <- 1.618

# check what type of object `b` is

typeof(b)
class(b) # numeric

## integers: positive and negative whole numbers 
#             with `L` attached at the end (faster computation)
c <- 3L
d <- -5L

## booleans: logical TRUE or FALSE statements (always capitalized)
e <- TRUE

## missing values: to communicate that no entry exists
f <- NA

#--------------------------------#

#### 3. Vector Objects in R ####

## create a vector object
v <- c(1, 3, 4, 5, 6, 10, 1.4, 0.1, 0.9)

## check how many items are in the vector
length(v)

## get the summary of the vector object
summary(v)

#--------------------------------#

#### 4. Working with Real Data in R ####

## get the `mtcars` dataset and store it in an object called `car_data`
car_data <- mtcars

## what type of object is it? 
typeof(car_data)

## what class of object is it?
class(car_data)

## how is it structured?
str(car_data)

## get a summary of this data set
summary(car_data)

## View the data in a separate tab
View(car_data) # notice the capital `V`

## select row called `mpg` from the `car_data` object by using a dollar `$` sign
car_data$mpg

## create a histogram of `mpg` from `car_data`
hist(car_data$mpg)

## create a box plot of `mpg` from `car_data`
boxplot(car_data$mpg)

