# Name: Vojtěch Válek
# Date: 18.11.2019
# Description: Logistic regression
# Data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance

library(dplyr)

# Task 3

## Reading the data
getwd()
data_mat <- read.csv("student-mat.csv", sep = ";")
data_por <- read.csv("student-por.csv", sep = ";")

## Looking at the structure and dimensions of the data
str(data_mat)
dim(data_mat) #395 observations and 33 variables
str(data_por)
dim(data_por) #649 observations and 33 variables

#Task 4

## Using columns as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","reason","nursery","internet")

## Joining the datasets by the selected identifiers
mat_por <- inner_join(data_mat, data_por, by = join_by, suffix = c(".math", ".por"))

## Looking at the structure and dimensions of the data
str(mat_por)
dim(mat_por) #382 observations and 53 variables

# Task 5

## Combining the duplicate answers in the joined data

## Creating a data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

## Columns not used for joining the data 
notjoined_columns <- colnames(data_mat)[!(colnames(data_mat)%in% join_by)]

## The if-else structure

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Task 6

## Creating a new column alc_use (average of the answers related to weekday and weekend alcohol consumption)
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

## Creating a new logical column high_use (true for students with alc_use > 2)
alc <- mutate(alc, high_use = alc_use > 2)

# Task 7

glimpse(alc)
write.csv(alc, file = "StudentData.csv", row.names = FALSE)
new_file <- read.csv(file = "StudentData.csv")
str(new_file)
head(new_file)
dim(new_file) # 382 observations and 35 variables

