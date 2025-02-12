#Dplyr Practice
library(dplyr)
library(ggplot2)
library(forcats)
library(wesanderson)

pal <- wes_palette("BottleRocket1")
pal2 <- wes_palette("Moonrise1")
pal3 <- wes_palette("GrandBudapest1")

data(iris)
head(iris)
View(iris)

#filtering rows using filter()
iris_setosa <- 
  iris %>% 
  filter(Species == "setosa")

iris_versicolor <- 
  iris %>% 
  filter(Species == "versicolor")

iris_virginica <- 
  iris %>% 
  filter(Species == "virginica")

#selecting columns
sepal_data <- iris %>% 
  select(Sepal.Length, Sepal.Width)

numeric_info <- iris %>% 
  select(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)
head(numeric_info)

above_20 <- 
  numeric_info %>% 
  mutate(Sepal.Area = Sepal.Length*Sepal.Width) %>% 
  filter(Sepal.Area >20) %>% 
  arrange(desc(Sepal.Area)) 

ggplot(above_20) +
  aes(x = Sepal.Area, y = Petal.Length) +
  geom_point()

numeric_w_Sarea
View(numeric_w_Sarea)

petal_data <- 
  iris %>% 
  select(Petal.Length, Petal.Width)
head(petal_data)

#arranging rows using arrange()
iris_sorted <-
  iris %>% 
  arrange(desc(Petal.Length)) #sort by descending petal length

View(iris_sorted) 

#creating new columns with mutate
iris_with_area <- 
  iris %>% 
  mutate(Sepal.area = Sepal.Length * Sepal.Width) %>% 
  mutate(Petal.ratio = Petal.Length/Petal.Width) %>% 
  mutate(Petal.area = Petal.Length * Petal.Width)
iris_with_area

#practice now sorting that data
iris_with_area_sorted <- 
  iris_with_area %>% 
  arrange(desc(Sepal.area))

View(iris_with_area_sorted)

#summarize data using summarize()
#find mean sepal length across the whole dataset
mean_sepal_length <- iris %>% 
  summarise(mean_sepal = mean(Sepal.Length))

mean_sepal_setosa <- 
  iris %>% 
  filter(Species == "setosa") %>% 
  summarise(mean_sepal = mean(Sepal.Length))

mean_sepal_versicolor <- 
  iris %>% 
  filter(Species == "versicolor") %>% 
  summarise(mean_sepal = mean(Sepal.Length))

mean_sepal_virginica <- 
  iris %>% 
  filter(Species == "versicolor") %>% 
  summarise(mean_sepal = mean(Sepal.Length))

# you could also do everything you did above in one go
#watch this cowboy
species_means <- iris %>% 
  group_by(Species) %>% 
  summarise(mean_sepal = mean(Sepal.Length))
species_means

#now lets calculate overall mean sepal length
overall_mean <- 
  iris %>% 
  summarise(mean_sepal = mean(Sepal.Length)) %>% 
  mutate(Species = "Overall Average")

#combine species means and overall means
mean_sepal_df <- 
  bind_rows(species_means, overall_mean)

mean_sepal_df <-
  mean_sepal_df %>% 
  arrange(desc(mean_sepal))
  
#now lets plot the average of all species and the average of all the species
#look at fct_reorder because I wanted the data to be in descending order to plot
ggplot(mean_sepal_df, aes(x = fct_reorder(Species, mean_sepal, .desc = TRUE), y = mean_sepal, fill = Species)) +
  geom_col() + 
  scale_fill_brewer(pallette = pal)


#some practice plotting some junk
ggplot(mean_sepal_df) +
  aes(x = Species, y = mean_sepal, fill = Species) +
  geom_col() + 
  scale_fill_manual(values = pal3) +
  labs(
    title = "Mean Sepal Length vs Species",
    y = "Mean Sepal Length",
    x = "Species"
  ) +
  theme(
    axis.text.x = element_text(face = "bold", color = "black"),
    axis.text.y = element_text(face = "bold", color = "black"),
    axis.title.x = element_text(face = "bold", color = "black"),
    axis.title.y = element_text(face = "bold", color = "black"),
    plot.title = element_text(face = "bold", size = 20, color = "black"),
    plot.background = element_rect("grey"),
    legend.position = "none",
    panel.grid = element_blank()
  )


