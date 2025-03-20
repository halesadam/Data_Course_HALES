library(tidyverse)

# Simulated messy dataset
set.seed(42)
df <- tibble(
  ID = 1:15,
  Name = c("Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Hank", "Ivy", "Jack",
           "Karen", "Leo", "Mona", "Nina", "Oscar"),
  Age = sample(20:50, 15, replace = TRUE),
  Group = rep(c("A", "B"), length.out = 15), 
  Income = c(50000, 60000, NA, 55000, 45000, NA, 70000, 52000, 58000, 61000,
             NA, 49000, 53000, NA, 62000),
  Address = c("123 St, CityA", "456 Rd, CityB", "789 Ln, CityC", "N/A", "456 Rd, CityB",
              "789 Ln, CityC", "123 St, CityA", "N/A", "456 Rd, CityB", "789 Ln, CityC",
              "123 St, CityA", "456 Rd, CityB", "N/A", "789 Ln, CityC", "123 St, CityA")
)

print(df)

#split up the data
df_a <- df %>% filter(Group == "A")
df_b <- df %>% filter(Group == "B")

#clean each subset
df_a_cleaned <- df_a %>% 
  mutate(Income = ifelse(is.na(Income), median(Income, na.rm = TRUE), Income))

df_b_cleaned <- df_b %>% 
  mutate(Address = ifelse(Address == "N/A", "Unknown", Address))

View(df_b_cleaned)

#join the two datasets
df <- bind_rows(df_a_cleaned, df_b_cleaned) %>% 
  arrange(ID)


#let's do some basic modeling
library(tidyverse)

data(iris)
str(iris)
summary(iris)

#build a simple model
model1 <- lm(Sepal.Length ~ Sepal.Width, data = iris)
summary(model1)

library(GGally)
ggpairs(model1)

#build another model
model2 <- lm(Sepal.Length ~ Sepal.Wiidth + Petal.Length + Petal.Width, data = iris)
