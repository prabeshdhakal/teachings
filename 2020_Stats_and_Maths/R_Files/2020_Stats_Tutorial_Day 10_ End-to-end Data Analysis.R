# Statistics Tutorial - Day 10 - (Almost) End-to-end Data Analysis
# Created By: Prabesh Dhakal on 2020-06-17
# Last Edited: 2020-06-17

##### Goals: ####

# 1. Read/load the data
# 2. Process the data (also understand the data/problem/README file)
#     - Identify data types and change them
#     - Look at abnormalities: duplication, missing values, unexpected values
#     - Think about what the target variable could be
# 3. Perform Analyses
# 4. Create/Train Models if necessary
# 5. Test Model Performance

# ----------------------------------- * ----------------------------------- #

#### Load libraries ####

# Uncomment and run to install:
#install.packages("ggplot2") # plotting
#install.packages("plyr") # data manipulation
#install.packages("magrittr")
#install.packages("gdata")
#install.packages("stringr")
#install.packages("Metrics")

# Load the libraries
library(ggplot2)
library(plyr)
library(magrittr)
library(gdata)
library(stringr)
library(Metrics)
source("helper_functions.R")

# ----------------------------------- * ----------------------------------- #

#### 1. Read/Load Data File(s) ####

# Biodiesel yield dataset: 
# Link Source: http://users.stat.ufl.edu/~winner/datasets.html

file_dir <- "biodiesel_transest.csv"
raw_df = read.csv(file_dir)
head(raw_df)

str(raw_df)

#### 2. Process the data ####
# This step typically takes the longest time on your data analysis journey.


# 2.1 Remove non-essential rows/columns ----
df <- raw_df[, 2:10] # used index to only select columns 2 - 9

# 2.2 Change data types as necessary ----
factor_cols <- c("b_temp", "b_pres", "b_time")
df[factor_cols] <- lapply(df[, factor_cols], factor)
str(df)

# 2.3 Look for abnormalities: ----
# missing values (NA), duplicates, unexpected values
#    - no duplicates/missing values/unexpected values expected

# 2.4 Summary Statistics ----
summary(df)

# 2.5 Plots ----

plot(df)

boxplot(df)

energy_consumptions <- df[, c("meth_ec", "eth_ec", "prop1_ec")]
boxplot(energy_consumptions, main="Energy consumption for each alcohol type")

alcohol_yields <- df[, c("meth_pct", "eth_pct", "prop1_pct")]
boxplot(alcohol_yields, main="Boxplot for yields of each alcohol type")


# Create a plot using ggplot2:
b_pres_labs = c("Pressure: 8 MPa", "Pressure: 10 MPa", "Pressure: 12 MPa")
names(b_pres_labs) <- c("8", "10", "12")

temp_box_plot <- ggplot(df, aes(x=b_temp, y=meth_pct)) +
    geom_boxplot() +
    facet_grid(~b_pres, labeller=labeller(b_pres=b_pres_labs)) + 
    ggtitle("Box Plots for the Yield of Methanol") +
    labs(x="Temperature Levels", y="Yield Percentages")
temp_box_plot

# Save the plot (optional)
# png(filename="temp_box_plot.png")
# plot(temp_box_plot)
# dev.off()

# Density plot of one variable at each temperature level
mean_vals <- ddply(df, "b_temp", summarise, grp.mean=mean(meth_pct))
head(mean_vals)

density_plots <- ggplot(df, aes(x=meth_pct, color=b_temp)) + 
    geom_density() +
    geom_vline(data=mean_vals, aes(xintercept=grp.mean, color=b_temp),
               linetype="dashed") + 
    ggtitle("Density Plots for the Yield of Methanol \n (at different temperatures)") +
    labs(x="methanol Yield Percentage", y="Density")
density_plots

# Tasks:
#   1. Recreate this plot for the energy consumption.
#   2. Recreate this plot for the energy consumption with pressure
#       as the distinguishing factor.

#### 3. Perform analyses ####
head(df)

# 3.1 (If applicable) choose a dependent variable ----

# - You as a scientist have to do this based on your domain knowledge 
#   and the research question(s) that you are trying to answer.

# You may choose either energy consumption (_ec) or yield percentage (_pct)
# of each alcohol type as the dependent variable. (Whatever you don't choose 
# could be set as independent variable.)

#       let's say that eth_pct is the target variable
#       (eth_pct is the yield of ethanol in %)

# 3.2 Normality test for the dependent variable ----

# H0: data is normal
shapiro.test(df$eth_pct)
plot(density(df$eth_pct))

# Density plot of different (comparable) variables
plot(density(df$eth_pct), 
     col="seagreen", 
     "Density Plots for Yields of Different types of Alcohol")
abline(v=mean(df$eth_pct), col="seagreen", lty=2)

lines(density(df$meth_pct), col="firebrick")
abline(v=mean(df$meth_pct), col="firebrick", lty=2)

lines(density(df$prop1_pct), col="navy")
abline(v=mean(df$prop1_pct), col="navy", lty=2)

legend(x=80, y=0.02, 
       lty=c(1, 1),
       legend=c("Methanol Yield", "Ethanol Yield", "Propanol Yield"), 
       col=c("firebrick", "seagreen", "navy"))

# 3.3 t-Test between different yields of ethanol vs propanol ----

# H0: means yield of the two alcohols are equal
t.test(df$eth_pct, df$prop1_pct)

# H0: means yields are equal
# H1: mean yield of methanol > mean yield of propanol
t.test(df$meth_pct, df$prop1_pct, alternative="greater")

# t-Test is clearly not the right test here as there are three groups
#   that we would like to compare 
#   (if we are *just* talking about the different alcohol types)


# 3.4 ANOVA: compare alcohol yield averages ----
# to compare equality of means between 3 groups

yields <- df[, c("meth_pct", "eth_pct", "prop1_pct")]
yields <- stack(yields)
head(yields)

# H0: all means are statistically equal
anova(lm(values ~ ind, data=yields))
# conclusion: the means are not equal as p-value < 0.05

# 3.5 ANOVA: yield averages for ethanol vs. factors ----
anova(lm(eth_pct ~ b_temp, data=df))
anova(lm(eth_pct ~ b_pres, data=df))
anova(lm(eth_pct ~ b_time, data=df))

anova(lm(eth_pct ~ b_temp + b_pres + b_time, data=df))

anova(lm(eth_pct ~ b_temp + b_pres, data=df))

# Check for interaction effect
anova(lm(eth_pct ~ b_temp * b_pres, data=df)) 

# 3.6 Post-hoc Test ----
anova_model_1 <- aov(eth_pct ~ b_temp + b_pres + b_time, data=df)
TukeyHSD(anova_model_1)

anova_model_2 <- aov(eth_pct ~ b_temp + b_pres, data=df)
summary(anova_model_2)
TukeyHSD(anova_model_2)

anova_model_3 <- aov(eth_pct ~ b_temp * b_pres, data=df)
summary(anova_model_3)
TukeyHSD(anova_model_3)

#### 4. Train/create (Simple/Multiple Linear) Models ####

# Assume that we want to predict the yield of ethanol based on
# our knowledge about the pressure, temperature, time,
# the yield and efficiency figures for other types of alcohols,
# and the efficiency figure for ethanol.

# Here, the dependent variable is eth_pct

# Unfortunately, using multiple categorical/factor variables to create a regression
# model is a bit cumbersome and talking about it in detail is 
# out of the scope of the course. 
# (Do an online search for "one-hot encoding" if you want to know how to handle
#  categorical variables.)

# 4.1 Divide the data into "train" and "validation" sets ----
# "Train set": the data set that we use to build the model (usually 70% of data)
# "Validation set": the data set that we use to validate the model performance
# This technique is called train-test split.
# Some like to divide their data into 3 groups: train, validation, test data
#   and divide their data in this ratio: 60:20:20
#   Then, they try to improve their model in various ways using only the
#   validation data set and choose the final model that performs best on the 
#   validation data. The final assessment of the trained model is then done on
#   the test data set.

# 4.1.1 Shuffle the data set (important)

# Random sample row indices
train_idx <- sample(1:nrow(df), 0.8 * nrow(df))
val_idx <- setdiff(1:nrow(df), train_idx)

# 4.1.2 Divide the data set
train_df <- df[train_idx, ]

val_df <- df[val_idx, ]
X_val <- val_df[, -6] # dependent variables
y_val <- val_df[, "eth_pct"] # true values


# 4.2 Create different models ----
model_1 <- lm(eth_pct ~ ., data=train_df)
summary(model_1)

model_2 <- lm(eth_pct ~ . - 1, data=train_df) # model without intercept
summary(model_2)

model_3 <- lm(eth_pct~meth_pct+eth_ec+prop1_pct+prop1_ec, data=train_df)
summary(model_3)

model_4 <- lm(eth_pct~meth_pct+eth_ec+prop1_pct+prop1_ec-1, data=train_df)
summary(model_4)

# 4.3 Make predictions with diff. models ----

pred_1 <- predict(model_1, remove_missing_levels(model_1, X_val))
pred_2 <- predict(model_2, remove_missing_levels(model_2, X_val))
pred_3 <- predict(model_3, X_val)
pred_4 <- predict(model_4, X_val)

# 4.4 Evaluate model performance ----

# Using Root Mean Squared Error (RMSE) figures
# as performance comparison metric:
rmse(y_val[-17], as.numeric(pred_1)[-17])
rmse(y_val[-17], as.numeric(pred_2)[-17])
rmse(y_val, pred_3)
rmse(y_val, pred_4)

# It seems that based on RMSE, model_3 performs the best. However, we should 
# almost never pick only one evaluation metric. Having more than 1 metrics 
# allows us to make better decisions for model selection.

# Using Mean Absolute Error (MAE) figures
# as performance comparison metric:
mae(y_val[-17], as.numeric(pred_1)[-17])
mae(y_val[-17], as.numeric(pred_2)[-17])
mae(y_val, pred_3)
mae(y_val, pred_4)

# However, looking at MAE, model_4 seems to be performing better than the rest.

# This is because RMSE assigns more weights to bigger deviations from the true
# value as we square the data. However, MAE is just the absolute difference.
# Look at the following:
true_vals <- c(4, 3, 2, 2, 5, 3, 8, 6)

pred_vals_1 <- c(9, 8, 7, 6, 5, 4, 2, 3)
mae(true_vals, pred_vals_1)
rmse(true_vals, pred_vals_1)

pred_vals_2 <- c(9, 8, 7, 6, 5, 4, 2, 300)
mae(true_vals, pred_vals_2)
rmse(true_vals, pred_vals_2)

# Finally, the R-squared figure that we have been checking is also another form
# of evaluation metric that we use to perform model comparison/selection.

#### Task: ####
# Data for practicing stats: https://infoguides.gmu.edu/find-data/practice