#Define groups
group_x <- c(3,2,1)
group_y <- c(5,3,4)
group_z <- c(5,6,7)

#### The following block is data formatting (will not be part of the exam) ####

# Construct a data frame in a format that can run an ANOVA
results <- cbind.data.frame(group_x,group_y,group_z)
groups <- factor(rep(1:3, c(3,3,3)))

y <- c(group_x,group_y,group_z)

#### End of data formatting block ####

# two ways to arrive at the same graph: boxplot
boxplot(group_x,group_y,group_z, names = c("x", "y", "z"), xlab = "Group", ylab = "Property of interest")
plot(groups,y,names = c("x", "y", "z"),xlab = "Group", ylab = "Property of interest")


#ANOVA version 1
modelA <- lm(y ~ groups)
anova(modelA)
summary(modelA)

#ANOVA version 2 / recommended for most purposes
modelB <- aov(y ~ groups)
summary(modelB)
