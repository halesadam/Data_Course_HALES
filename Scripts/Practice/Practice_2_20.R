library(tidyverse)
library(skimr)
library(janitor)

#create a messy dataset
# Create a messy dataset
messy_data <- tibble(
  ID = c(1, 2, 3, 4, 4, 5, 6, 7, NA, 9),
  Name = c("Alice", "Bob", "Charlie", "David", "David", "Eve", "Frank", NA, "Grace", "Hank"),
  Age = c(25, 30, NA, 22, 22, 29, 35, 40, 26, 50),
  Gender = c("F", "M", "M", "M", "M", "F", "M", "M", "F", "Other"),
  Income = c(50000, 60000, 70000, NA, 45000, 55000, 62000, 58000, 61000, 50000),
  City = c("New York", "Los Angeles", "New York", "Chicago", "Chicago", "Houston", "Houston", "Phoenix", NA, "Miami"),
  Marital_Status = c("Single", "Married", "Single", "Single", "Single", "Married", "Divorced", "Married", "Single", "Widowed")
)

#check it out
skim(messy_data)

#look through and clean names
messy_data <- messy_data %>% 
  clean_names()

#look for and drop NAs
cleaned_data <- messy_data %>% 
  drop_na()

#Or we could fill in missing values with appropriate replacements
messy_data <- messy_data %>% 
  mutate(
    Age = replace_na(Age, median(Age, na.rm = TRUE)),
    Income = replace_na(Income, mean(Income, na.rm = TRUE)),
    City = replace_na(City, "unknown"),
    Name = replace_na(Name, "no_name")
  )

messy_data

#look for duplicates
duplicated(messy_data)

messy_data <- messy_data %>% 
  distinct()

#make ID into a character
messy_data <- messy_data %>% 
  mutate(ID = as.character(ID))

messy_data

#filter and select necessary columns
messy_data <- messy_data %>% 
  select(id, name, age, gender, city, income)
messy_data

#now lets filter for only adults that are above 25 years
filtered_data <- messy_data %>% filter(age >25)
filtered_data

#tidying; 
# - converting wide to long
tidy_data <- messy_data %>% 
  pivot_longer(cols = c(age, income), names_to = "variable", values_to = "value")

tidy_data

###Okay, let's practice tidying the billboard dataset
library(tidyverse)
billboard <- as_tibble(billboard)

print(billboard)

#use pivot longer to tidy
billboard_long <- billboard %>% 
  pivot_longer(cols = starts_with("wk"),
               names_to = "Week",
               values_to = "Rank") %>% 
  clean_names()

#okay, now back to long format
billboard_wide <- billboard_long %>% 
  pivot_wider(names_from = "week", values_from = "rank")
print(billboard_wide)

#now lets use the relig_income dataset
#load dataset
data("relig_income")
relig_income

View(relig_income)

#now let's convert to long format
relig_long <- relig_income %>% 
  pivot_longer(cols = -religion,
               names_to = "income_level",
               values_to = "count")







