library(tidyverse)
library(janitor)
library(skimr)
library(palmerpenguins)

data <- airquality

skim(data)
str(data)
View(data)

data <- data %>% 
  clean_names()

data
data

#remove rows with missing values
data_cleaned <- data %>% drop_na()

#filter out extreme wind speeds above 20 mph
data_filtered <- data_cleaned %>% 
  filter(wind <= 20)

#select relevant columns
data_selected <- data_filtered %>% 
  select(ozone, solar_r, wind, temp, month, day)

#Let's convert month numbers into season names (kinda fun)
data_selected <- data_selected %>% 
  mutate(season = case_when(
         month %in% c(5, 6)~"Spring",
         month %in% c(7,8)~ "Summer",
         month == 9 ~ "Fall",
         TRUE ~ "Unknown"
           ))

#now let's make season into a factor
data_selected <- data_selected %>% 
  mutate(season = factor(season))

#convert to long format
data_long <- data_selected %>% 
  pivot_longer(cols = c(ozone, solar_r, wind, temp),
               names_to = "measurement_type",
               values_to = "value")

#convert back into wide format
data_wide <- data_long %>% 
  pivot_wider(names_from = measurement_type, values_from = value)


#str_ functions
