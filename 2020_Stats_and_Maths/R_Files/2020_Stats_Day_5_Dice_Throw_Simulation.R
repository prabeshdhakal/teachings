# Statistics Tutorial - Day 5 - Walkthrough
# Created By: Prabesh Dhakal on 2020-05-06
# Last Edited: 2020-05-06


#### Goals: ####
#     i. Simulate throwing a fair dice many times
#    ii. Simulate throwing a loaded dice many times

# ----------------------------------- * ----------------------------------- #


#### 1. Simulate Fair Dice Throw ####

sample(1:6, size=1, replace = FALSE) # one throw

throws <- c()
for (i in 1:6000){
    throws <- c(throws, sample(1:6, size=1))
}

throws_table <- table(throws)

barplot(throws_table,
        main="No. of occurrance of each \nnumber in 6000 fair dice throws",
        col="gray",
        ylim=c(0, round(max(throws_table)*1.2)))


# question: why did we make a barplot here?


# ----------------------------------- * ----------------------------------- #

#### 2. Simulated  Loaded Dice Throw ####

# Use custom probability figures
probabilities <- c(0.5, 0.1, 0.05, 0.05, 0.25, 0.05)
#                   1    2     3     4     5     6

throws <- c()
for (i in 1:6000){
    throws <- c(throws, sample(1:6, size=1, prob=probabilities))
}

throws_table <- table(throws)

barplot(throws_table,
        main="No. of occurrance of each \nnumber in 6000 loaded dice throws",
        col="gray",
        ylim=c(0, round(max(throws_table)*1.2)))

