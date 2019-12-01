# Name: Vojtěch Válek
# Description:Dimensionality reduction techniques
# Data source: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

# read the human data
data_human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)
str(data_human)
dim(data_human)

## Our data consists of 195 observations and 19 variables and shows how each country in the world is doing with regard to some important indicators. Indicators such as groos national income per capita, life expectancy at borth and others.

# Task 1

library(stringr)

## Transforming GNI variable to numeric
data_human$GNI <- str_replace(data_human$GNI, pattern=",", replace ="")%>%as.numeric

# Task 2

## Excluding unneeded variables
keep_columns <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# Selecting the desired columns
human <- select(data_human, one_of(keep_columns))
dim(human)

# Task 3

## Removing rows with NA values
Human <- filter(human, complete.cases(human))

# Task 4

## By looking at few last observations, we can see that the last country is Niger. Last seven observations corresponds to regions, not countries.
tail(Human, 10)

## Getting rid of those last 7 observations
last <- nrow(Human) - 7
Human_ <- Human[1:last, ] # Excluding observations for regions from our dataset
tail(Human_, 10) # Checking that observations for regions are gone

# Task 5

## Defining row names by country names
rownames(Human_) <- Human_$Country
Human_data <- select(Human_, -Country)
dim(Human_data) # Dataset now have 155 observations and 8 variables

write.csv(Human_data, file = "human.csv", row.names = TRUE)
new_file <- read.csv(file = "human.csv")
str(new_file)
head(new_file)
