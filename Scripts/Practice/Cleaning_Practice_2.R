library(palmerpenguins)
library(tidyverse)
penguins_data <- penguins

penguins_clean <- drop_na(penguins_data)
penguins_clean

#or we could fill in missing values in numeric columns with median
penguins_clean <- 
  penguins_data %>% 
  mutate(across(where(is.numeric),~replace_na(.x, median(.x, na.rm = TRUE)))) 

#lets now find inconsistent formatting
penguins_clean <- penguins_clean %>% 
  mutate(species = str_to_lower(species)) #standardizes sp capitalization

#reshaping data, long and wide format
penguins_long <- penguins_clean %>% 
  pivot_longer(cols = c(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g), #these are the columns we want to pivot from wide to long format
               names_to = "measurement_type", values_to = "value") #for abovementioned columns, change name to ___ and numbers to "value"
penguins_long

#filtering and selecitng data
penguins_filtered <- penguins_long %>% 
  filter(species == "adelie") %>% #filter for adelie penguins
  select(species, island, sex, measurement_type, value) #for those penguins, show me species, island, sex, measurement_type, value

penguins_filtered

#removing duplicates
penguins_unique <- penguins_filtered %>% 
  distinct() #that's it

#still struggling with long vs wide format, lets practice some more
#create a sample dataset
students_wide <- tibble(
  student = c("Alice", "Bob", "Charlie"),
  math = c(90, 95, 78),
  science = c(88, 92, 80),
  english = c(75, 78, 85)
)

print(students_wide)
#convert wide to long with pivot longer
students_long <- students_wide %>% 
  pivot_longer(cols = c(math, science, english), #select the rows to pivot
               names_to = "subject", #new column for subject names
               values_to = "score") #new column for scores

print(students_long)

#now some practice wity pivot_wider
students_long <- tibble(
  student = rep(c("Alice", "Bob", "Charlie"), each = 3),
  subject = rep(c("math", "science", "english"), times = 3),
  score = c(90, 88, 75, 85, 92, 78, 78, 80, 85)
)
print(students_long)
students_wide <- students_long %>% 
  pivot_wider(names_from = subject, #use subject names as new column names
              values_from = score) #fill these new columns with score values


##practice on your own
cars_wide <- tibble(
  car = c("Toyota", "Honda", "Ford"),
  mpg_2020 = c(30, 28, 25),
  mpg_2021 = c(32, 29, 26)
)
print(cars_wide)

#use pivot_longer() to create columns year and mpg
cars_long <- cars_wide %>% 
  pivot_longer(cols = c(mpg_2020,mpg_2021),
               names_to = "year",
               values_to = "mpg")
#now clean up the year column
cars_long %>% 
  mutate(year = str_remove(year, "mpg_")) #removes mpg_


#use pivot wider to take this long dataset into a wide one
cars_long <- tibble(
  car = rep(c("Toyota", "Honda", "Ford"), each = 2),
  year = rep(c("mpg_2020", "mpg_2021"), times = 3),
  mpg = c(30, 32, 28, 29, 25, 26)
)
print(cars_long)
#bring back seperate columns for mpg_2020 and mpg_2021
cars_long %>% 
  pivot_wider(names_from = year,
              values_from = mpg)

install.packages("agridat")
library(agridat)
library(tidyverse)


