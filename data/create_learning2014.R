# Name: "Vojtěch Válek"
# Date: 11.11.2019
# Desription: "Data wrangling" 

# Task 2

## Read the data 
my_data <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE )

## Structure and dimension of tha data
str(my_data)
dim(my_data)

### Command str() showed us that all variables except gender are integers. Gender is a factor. Dim() showed us that there 183 observations of 60 variables in the data frame.

# Task 3

## Access the dplyr library
install.packages("dplyr")
library(dplyr)

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

## Scaling variables
deep_columns <- select(my_data, one_of(deep_questions))
my_data$deep <- rowMeans(deep_columns)

surface_columns <- select(my_data, one_of(surface_questions))
my_data$surf <- rowMeans(surface_columns)

strategic_columns <- select(my_data, one_of(strategic_questions))
my_data$stra <- rowMeans(strategic_columns)

## Excluding obs. with exam point = 0
adjusted_data <- filter(my_data[,c("gender", "Age", "Attitude", "deep", "stra", "surf","Points")], Points > 0)
dim(adjusted_data)
head(adjusted_data)

# Task 4
getwd()
?write.csv
write.csv(adjusted_data,file = "learning2014.csv", row.names = FALSE)
new_file <- read.csv(file = "learning2014.csv")
str(new_file)
head(new_file)
