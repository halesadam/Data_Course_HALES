library(tidyverse)

#practicing select()
iris %>% 
  select(Species, Sepal.Length)

#filter
iris %>% 
  filter(Species == "virginica")

#mutate
iris %>% 
  mutate(sepal_area = Sepal.Length *Sepal.Width)

#arrange
#sort data by one or more columns
iris %>% 
  arrange(desc(Sepal.Length))

#group by and summarize
#used to aggregate data
iris %>% 
  group_by(Species) %>% 
  summarise(avg_sepal_length = mean(Sepal.Length))

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(avg_hwy_mpg = mean(hwy))

mpg %>% 
  group_by(class) %>% 
  summarise(avg_hwy_mpg = mean(hwy)) %>% 
  arrange(desc(avg_hwy_mpg))

#rename to rename columns
iris %>% 
  rename(species = Species)

iris %>% 
  rename(sepal.length = Sepal.Length)

#pivot longer
df_wide <- data.frame(
  species = c("setosa", "versicolor"),
  sepal_length = c(5.1, 7.0),
  petal_length = c(1.4, 4.7)
)

df_long <- df_wide %>% 
  pivot_longer(-species,
               names_to = "measurement",
               values_to = "value")

#pivot wider, bring it back to the wide format
df_long %>% 
  pivot_wider(names_from = measurement,
              values_from = value)


#using ggpairs to explore a dataset
#load up packages
library(GGally)
library(ggplot2)
library(dplyr)

#load up data
data(iris)
head(iris)

ggpairs(iris,aes(color = Species))

#you can also only select selected columns
ggpairs(iris, columns = 1:4)

#Pracice workflow
library(tidyverse)
library(lindia)
library(GGally)

df <- mtcars
glimpse(mtcars)
summary(mtcars)

ggpairs(mtcars)

#clean the data
#convern tow names to a column and rename it car
df_tidy <- df %>% 
  rownames_to_column(var = "Car") %>% 
  mutate(
    cyl = as.factor(cyl),
    gear = as.factor(gear)
  )

#summarise data
#calculate mean MPG and standard deviation by cylinder type
df_tidy %>% 
  group_by(cyl) %>%
  summarise(
    mean_mpg = mean(mpg, na.rm = TRUE),
    sd_mpg = sd(mpg, na.rm = TRUE),
    count = n()
  )

#plot the data
#UGA color themed plot
ggplot(df_tidy)+
  aes(x = cyl, y = mpg, fill = cyl) +
  geom_boxplot() +
  theme(panel.background = 
          element_rect(fill = "grey"),
        plot.background = 
          element_rect(fill = "#E4002B"))+
  scale_fill_manual(values = c("#BA0C2F", "#000000", "#FFFFFF"))+
  labs(
    title = "MPG by Cylinder Type",
    subtitle = "nothing",
    caption = "nothing else",
    x = "cylinders",
    y = "Miles per Gallon (MPG)" 
  )


#Recreate a plot 




