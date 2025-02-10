# Data Cleaning Practice

library(dplyr)
library(tidyverse)

#Example 1, Filling in NA
#sample dataset
df <- data.frame(
  ID = c(1,2,3,4,5),
  Name = c("Alice", "Bob", NA, "David", "Eva"),
  Score = c(85, NA, 90, 78, 88)
)

#remove rows with missing values
df_clean <- df %>% drop_na() #this is helpful if it says "NA"
View(df_clean)

#Fill missing values in score with the mean
df_filtered <- df %>% mutate(Score = ifelse(is.na(Score), 
                                            mean(Score, 
                                            na.rm = TRUE), 
                                            Score))

head(df_filtered)


#Example 2, Tidying data
df_wide <- data.frame(
  Name = c("Alice", "Bob", "Charlie"),
  Math = c(90, 80, 85),
  Science = c(95, 88, 82)
)

df_wide

#convert to long format
df_long <- df_wide %>% pivot_longer(cols = Math:Science, names_to = "Subject", values_to = "Score")
df_long #note the difference between that and the wide one


#Example 3, Seperating Columns
df <- data.frame(
  Name = c("Alice Johnson", "Bob Smith"),
  Score = c(90, 85)
)
df_separated <- df %>% separate(Name, into = c("First_Name", "Last_Name"), sep = " ")
df_separated

#Practice 1
dat <- data("mtcars")
View(mtcars)
#check for mising values
colSums(is.na(mtcars))

#rename mpg column to Miles_Per_Gallon
mtcars <- mtcars %>% rename(Miles_Per_Gallon = mpg)

#now rename disp to displacement
mtcars <- mtcars %>% rename(Displacement = disp)

#again, cyl to Cylinder_Number
mtcars <- mtcars %>% rename(Cylinder_Number = cyl)

#hp to horsepower
mtcars <- mtcars %>% rename(Horsepower = hp)

colnames(mtcars)

#filter the dataset to only include cars with Horsepower greater than 100
mtcars_filtered <- mtcars %>% filter(Horsepower >100)
mtcars_filtered
View(mtcars_filtered)

#lets understand the %>% functionality a little better
#without pipe
data(mtcars)
mtcars <- rename(mtcars, Miles_Per_Gallon = mpg)
mtcars_filtered1 <- filter(mtcars, hp > 100)
head(mtcars_filtered1)

#or we could do it with a pipe to save some steps
mtcars %>% 
  rename(Miles_Per_Gallon = mpg) %>% 
  filter(hp>100)

#another example of pipe use
mean(mtcars$hp, na.rm = TRUE)
#with pipe
mtcars %>% 
  summarise(Average_HP = mean(hp, na.rm = TRUE))
mtcars


#selecting specific columns without and with pipe
selected_data <- select(mtcars, Miles_Per_Gallon, hp, cyl)
head(selected_data)
#now with a pipe
mtcars %>% 
  select(Miles_Per_Gallon, hp, cyl) %>% 
  head()

#using a pipe to create an entirely new column
#without pipe
mtcars$new_col <- mtcars$hp/mtcars$wt
head(mtcars$new_col)
#now with a pipe
mtcars %>% 
  mutate(HP_Per_Weight = hp,wt) %>% 
  head()
