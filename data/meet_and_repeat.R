# Name: Vojtěch Válek
# Description: Analysis of longitudinal data
# Data sources: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt, https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

# Task 1

## Loading the data

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ", header = T)

names(BPRS)
dim(BPRS) # 40 observations and 11 variables
head(BPRS)
str(BPRS)
summary(BPRS)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "\t", header = T)

names(RATS)
dim(RATS) # 16 observations and 13 variable
head(RATS)
str(RATS)
summary(RATS)

# Task 2

BPRS$treatment <- as.factor(BPRS$treatment)
BPRS$subject <- as.factor(BPRS$subject)

RATS$ID <- as.factor(RATS$ID)
RATS$Group <- as.factor(RATS$Group)

## Checking that desired variables are now factors
lapply(BPRS, class) 
sapply(BPRS, class)


lapply(RATS, class)
sapply(RATS, class)

# Task 3

## Converting the data sets to long form
library(dplyr)
library(tidyr)

## Adding desired variables
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
head(BPRSL)

RATSL <-  RATS %>% gather(key = time, value = gram, -Group, -ID)
head(RATSL)

# Task 4

names(BPRSL)
dim(BPRSL) # 360 observations and 4 variables
head(BPRSL)
str(BPRSL)
summary(BPRSL)

names(RATSL)
dim(RATSL) # 176 observations and 4 variables
head(RATSL)
str(RATSL)
summary(RATSL)

## Comparing now the datasets to their original (wide) form, now our data are better arranged and easier to read. Number of variables in each dataset shrinked, but number of observations increased.