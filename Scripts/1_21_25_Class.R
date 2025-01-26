# SETUP ####
#install tidyverse package
##load packages ####
library(tidyverse)
##load data####
dat <- 
read_delim("./Data/DatasaurusDozen.tsv")
unique(dat$dataset) #find the unique values within the dataset
dat[dat$dataset == "x_shape",]

#subset dataframe to include "star"
star <- 
dat[dat$dataset == "star",]

filter(dat, dataset == "star")

dat %>% 
  filter(dataset == "star") %>% 
  ggplot(aes(x,y)) + geom_point()

## Subsetting Rows ####
iris
data(iris)
head(iris)
#subset based on condition (sepal length>5)
subset1 <- iris[iris$Sepal.Length>5,]
head(subset1)
#subset rows based on sp.
subset2 <- iris[iris$Species == "setosa",]
head(subset2)

#subset with subset function
subset3 <- subset(iris, Sepal.Width < 3.5 & Species == 
                    "virginica")


## Subsetting Columns" ####
#specific columns
  # want to see sepal length and species
subset5 <- iris[,c("Sepal.Length", "Species")]
head(subset5)

#Excluding certain columns
subset6 <- iris[,!names(iris)%in% "Petal.Width"]
head(subset6)

## Rows and Columns ####
subset7 <- iris[iris$Sepal.Length>5 & iris$Species== "versicolor",
                c("Sepal.Length", "Petal.Length")]
head(subset7)

## Replicate what you did on Assignment_3 ####
# YOUR REMAINING HOMEWORK ASSIGNMENT (Fill in with code) ####

# 1.  Get a subset of the "iris" data frame where it's just even-numbered rows

seq(2,150,2) # here's the code to get a list of the even numbers between 2 and 150

data("iris") 
df <- iris
df[(seq(2,150,2)),]


# 2.  Create a new object called iris_chr which is a copy of iris, except where every column is a character class


# 3.  Create a new numeric vector object named "Sepal.Area" which is the product of Sepal.Length and Sepal.Width


# 4.  Add Sepal.Area to the iris data frame as a new column

# 5.  Create a new dataframe that is a subset of iris using only rows where Sepal.Area is greater than 20 
# (name it big_area_iris)

# 6.  Upload the last numbered section of this R script (with all answers filled in and tasks completed) 
# to canvas
# I should be able to run your R script and get all the right objects generated


