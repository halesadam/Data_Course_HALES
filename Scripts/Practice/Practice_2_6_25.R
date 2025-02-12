#Cleaning and plotting practice 2/10/25

library(ggplot2)
library(tidyverse)
library(dplyr)

#messy chatgpt dataset
# Step 1: Create a Messy Dataset
set.seed(123)
messy_data <- tibble(
  ID = c(101, 102, 103, 104, 105, 106, 107, 108, 108),  # Duplicate ID
  Name = c("Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", NA, "Henry"), # Missing value
  Age = c(25, "30", 35, "forty", 45, 50, NA, 60, 65),  # Mixed types, text error
  Height_cm = c(160, 175, 168, 180, 155, 190, 165, 170, 300),  # Outlier
  Weight_kg = c(55, 80, 72, 85, 50, 90, 65, 70, 500),  # Outlier
  JoiningDate = c("2020-01-15", "2019/02/20", "18-03-2018", "2017-04-10", 
                  "2021-06-25", "2016-07-30", "2022-09-05", "2023-10-01", "2023-10-01"), # Inconsistent date formats
  Gender = c("M", "M", "F", "Male", "Female", "F", "F", "M", "M") # Inconsistent values
)

View(messy_data)

#clean the dataset
cleaned_data <- messy_data %>% 
  distinct() %>% #removes duplicates
  mutate(
    Age = as.numeric(replace(Age, Age == "forty", "40")),#changes the word forty to 40
    Height_cm = ifelse(Height_cm > 250, NA, Height_cm), #remove height outliers
    Weight_kg = ifelse(Weight_kg > 200, NA, Height_cm), #remove weight outliers
    JoiningDate = lubridate::parse_date_time(JoiningDate, orders = c("ymd", "dmy", "mdy")), # fix the dates
    Gender = case_when(
      Gender %in% c("M", "Male") ~ "Male",
      Gender %in% c("F", "Female") ~ "Female",
      TRUE ~ Gender
    )
  ) %>% 
  drop_na()

View(cleaned_data)
cleaned_data


#ggplot visualization
#Scatter plot of Height vs weight
p1 <- ggplot(cleaned_data, aes(x = Height_cm, y = Weight_kg, color = Gender)) +
  geom_point(size = 3) +
  labs(title = "Height vs. Weight", x = "Height (cm)", y = "Weight (kg)") +
  theme_minimal()

p1

ggplot(cleaned_data) +
  aes(x = Gender, y = Age, fill = Gender) +
  geom_boxplot() + 
  theme_minimal()

ggplot(cleaned_data)+
  aes(x = Name, y = Height_cm) +
  geom_point(color = "blue") +
  theme_dark() +
  labs(
    title = "NOTITIE",
    x = "Name",
    y = "Height (cm)",
    subtitle = "nothing",
    caption = "NOCAPTION"
  ) +
  theme(
  axis.text.x = element_text(angle = 60, vjust = 0.5, hjust = 0.5),
  plot.background = element_rect(fill = "yellow"),
  panel.grid = element_blank(),
  plot.title = element_text(color = "red", face = "bold", size = 20),
  axis.title.x = element_text(color = "orange", face = "bold", size = 20),
  axis.title.y = element_text(color = "orange", face = "bold", size = 40)
  )

#some random ggplot practice to do it myself
data(iris)
iris

ggplot(iris) + 
  aes(x = Species, y = Sepal.Length) + 
  geom_boxplot(fill = "limegreen", color = "white") + 
  theme_minimal() +
  labs(
    title = "Iris Sepal Length vs Species",
    subtitle = "A box plot",
    y = "Sepal Length (cm)",
    caption = "From iris dataset in R"
  ) +
  theme(
    plot.background = element_rect(fill = "black"),
    axis.title = element_text(color = "white", face = "bold", size = 18),
    plot.title = element_text(color = "white", face = "bold", size = 20),
    axis.text = element_text(color = "white"),
    plot.subtitle  = element_text(color = "white", size = 15),
    plot.caption = element_text(color = "white", size = 10),
    panel.grid.major.x = element_line(color  = "yellow"),
    panel.grid.major.y = element_line(color = "hotpink")
  )

#practice with mutate() function
#mutate creates new columns or modified existing ones in a df

mtcars_new <- mtcars %>% 
  mutate(km_per_liter = mpg * 0.425144) #Creates a new column titled "km per liter" and is the product of mpg and a scalar

head(mtcars)
head(mtcars_new)

#modifying an existing column
#lets add a decimal place to mpg
mtcars_newer <- mtcars %>% 
  mutate(mpg = round(mpg,1))
head(mtcars_newer)

#using ifelse() to create a new column based on a condition
#three categories
  #high is mpg >20
  #med is mpg >15
  #low is otherwise
mtcars_1 <- mtcars %>% 
  mutate(fuel_efficiency = ifelse(mpg>20, "High",
                            ifelse(mpg>15, "Medium", "Low")))
head(mtcars_1)


#use case_when for multiple conditions
mtcars_2 <- mtcars %>% 
  mutate(
    car_type = case_when(
      mpg > 25 ~ "Super Efficient",
      mpg > 20 ~ "Efficient",
      mpg > 15 ~ "Average",
      TRUE ~ "Inefficient"
    )
  )
head(mtcars_2)
View(mtcars_2)

mtcars_6 <- mtcars %>% 
  mutate(
    carb_type = case_when(
      carb == 4 ~ "4",
      carb == 1 ~ "1",
      carb == 2 ~ "2"
    )
  )

head(mtcars_6)

mtcars_7 <- mtcars %>% 
  mutate(weight_to_mpg_ratio = wt/mpg)

head(mtcars_7)

mtcars

#now lets create a power to weight ratio using hp and wt
mtcars_3 <- mtcars %>% 
  mutate(pwr_to_wt = hp/wt)

#an extra practice
mtcars_5 <- mtcars %>% 
  mutate(disp_to_mpg_ratio = disp/mpg)

head(mtcars_5)

head(mtcars_3)

#changing multiple columns with across()
mtcars_4 <- mtcars %>% 
  mutate(across(c(mpg, hp, wt), round, digits =1))
head(mtcars_4)

#using row_number() to add row number
mtcars_new <- mtcars %>% 
  mutate(row_id = row_number())


head(mtcars_new)
