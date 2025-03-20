# R for Data Science Exercise Notes ####
##WholeGame ####
###Data Visualization ####
library(tidyverse)
library(palmerpenguins)
install.packages("ggthemes")
library(ggthemes)

####1.2 First Steps ####
penguins
glimpse(penguins)

#goal is to create visualization displaying relationship between flipper length and body masses of the penguins
ggplot(penguins) +
  aes(x = flipper_length_mm, y = body_mass_g) +
  geom_point(mapping = aes(color = species, shape = species)) + #change color and shape of geoms here
  geom_smooth(method = "lm") + 
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)",
    y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind() #this is cool

#### Exercises ####
#1. how many rows and columns are in penguins
ncol(penguins)
nrow(penguins)

#2. What does bell_depth_mm variable in penguins df describe
?penguins

#3. Make a scatterplot of bill depth and bill length
ggplot(penguins)+
  aes(x = bill_length_mm, y = bill_depth_mm)+
  geom_point() 

#4. What would be a better scatterplot of Sp. vs Bill depth
#what might be a better geom?
ggplot(penguins) +
  aes(x = species, y = bill_depth_mm) + 
  geom_boxplot() #boxplot would be better

#5. Why does this give an error and how do you fix
ggplot(data = penguins) + 
  aes(x = species, y = island) + #did not have aesthetics mapped to it
  geom_point()

#6. What does na.rm do in geom_point
#create a scatterplot where you successfully use this argument set to TRUE
ggplot(penguins) +
  aes(x = species, y = bill_depth_mm) + 
  geom_point(na.rm = TRUE) #removes na data

#7. Add caption to your previous plot
ggplot(penguins) +
  aes(x = species, y = bill_depth_mm) + 
  geom_boxplot() +
  labs(
    caption = "Data come from the palmerpenguins R package"
  )

#8. Recreate the following visualization
ggplot(penguins)+
  aes(x = flipper_length_mm, y = body_mass_g) +
  geom_point(aes(color = bill_depth_mm)) + 
  geom_smooth(color = "blue")

####1.3 ggplot2 calls ####
#can use pipe to make the same fig
penguins %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = species)) + 
  geom_point() + 
  theme_minimal() + 
  scale_color_colorblind()

###1.4 Visualizing Distrubutions
#categorical variable
ggplot(penguins)+
  aes(x = species)+
  geom_bar()

#if we want to make these in descending order we have to transform the variable into a factor
ggplot(penguins)+
  aes(x = fct_infreq(species)) +
  geom_bar()

#numerical values
#histogram is common for these
ggplot(penguins) +
  aes(x = body_mass_g) + 
  geom_histogram(binwidth = 2000) #determines the width of the "bin"
#density plot is also a useful distrubution
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

####Exercises####
#1. make bar plot of species of penguins where you assign species to the y asthetic
ggplot(penguins) + 
  aes(y = species) + 
  geom_bar()

#2. is color or fill more useful for changing color of bars?
ggplot(penguins) + 
  aes(y = species) + 
  geom_bar(fill = "red")

#3. Experiment with carat variable in diamonds dataset
#make histogram and explore different binwidths
data("diamonds")
ggplot(diamonds)+
  aes(x = carat) + 
  geom_histogram(binwidth=0.1)

####1.5 Visualizing relationships####
ggplot(penguins)+
  aes(x = body_mass_g, color = species, fill = species) +
  geom_density(linewidth = 1.0) +
  scale_color_colorblind()

#can use stacked bar plots to visualize relationship between 2 categorical variables
#relationship of island and species
ggplot(penguins)+
  aes(x= island, fill =species) +
  geom_bar()

#this plot is a frequency plot created by setting position = "fill
ggplot(penguins)+
  aes(x = island, fill = species)+
  geom_bar(position = "fill")

#three or more variables
ggplot(penguins)+
  aes(x = flipper_length_mm, y =body_mass_g) +
  geom_point(aes(color = species, shape = island))

#a better way to do this is to divide into facets
#single variable, use facet_wrap
ggplot(penguins)+
  aes(x = flipper_length_mm, y =body_mass_g) +
  geom_point(aes(color = species))+
  facet_wrap(~island) #facet based on island

#### Exercises ####
#2. using mpg, make scatterplot of hwy vs displ using mpg df. 
#next, map a third numerical variable to color, then size, then both to color and size, then shape
data(mpg)
ggplot(mpg)+
  aes(y = hwy, x = displ, shape = trans, linewidth = cty)+
  geom_point()

#make a scatterplot of bill depth and bill lengths
#color the points by species
#facet by species
ggplot(penguins)+
  aes(x = bill_depth_mm, y = bill_length_mm) + 
  geom_point(aes(color =species)) + 
  facet_wrap(~species) 

#why does this generate two legends?
#how do you fix to combine two legends
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species", shape = "Species") #all you had to do is add shape = "species" here

###Data Transformation ####
install.packages("nycflights13")
library(nycflights13)
library(tidyverse)

#exploring basic dplyr verbs
flights
#tibble is a special type of df used by tidyverse to avoid some common gotchas
#tibbles are designed for large datasets
glimpse(flights)

flights %>% 
  filter(dest == "IAH") %>% 
  group_by(year, month, day) %>% 
  summarise(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

####Rows####
#most important verbs that operate on rows are filter and arrange
#filter allows you to keep rows based on the columns
flights %>% 
  filter(dep_delay>120) #filter for dep delays of greater than 120 min

#now lets find flights that departed on Jan 1
flights %>% 
  filter(month ==1, day==1)

#flights from jan or feb
flights %>% 
  filter(month == 1 | month ==2)

#shorter way to select flights that departed in Jan or Feb
flights %>% 
  filter(month %in% c(1,2)) #take note of this

#this doesn't modify the original data. If you want to save it do this
jan1 <- flights %>% 
  filter(month ==1 & day==1)

#####Arrange####
#changes the order of rows based on values of columns
flights %>% 
  arrange(year, month, day, dep_time)
#can also use desc to order that in descending order 
flights %>% 
  arrange(desc(dep_delay)) #we are only arranging the data, not filtering it

#####Distinct####
#finds all unique rows in a dataset
#remove duplicate rows, if any
flights %>% 
  distinct()
#find all unique origin and destination pairs
flights %>% 
  distinct(origin,dest)
#can keep the other columns when filtering for unique rows using the .keep_all
flights %>% 
  distinct(origin,dest, .keep_all = TRUE)

#Exercises#
#3.2.5
filtered_flights <- flights %>%
  filter(arr_delay >= 120) %>%   # Arrival delay of two or more hours
  filter(dest %in% c("IAH", "HOU")) %>%  # Flew to Houston (IAH or HOU)
  filter(carrier %in% c("UA", "AA", "DL")) %>%  # Operated by United, American, or Delta
  filter(month %in% c(7, 8, 9)) %>%  # Departed in summer (July, August, September)
  filter(arr_delay > 120, dep_delay <= 0) %>%  # Arrived 2+ hours late but didn’t leave late
  filter(dep_delay >= 60, (dep_delay - arr_delay) > 30)  # Delayed 1+ hour but made up 30+ minutes
filtered_flights  
   
#sort based on longest departure delays
#find flights earliest in the morning
flights %>% 
  arrange(desc(dep_delay))
flights %>% 
  arrange(sched_dep_time) #this is the default

#find the fastest flights
fastest_flights <- flights %>%
  filter(air_time > 0) %>%  # Avoid division by zero
  mutate(speed = distance / air_time) %>%  # Calculate speed (miles per minute)
  arrange(desc(speed))  # Sort by fastest speed
fastest_flights

#was there a flight every day in 2013?
#count the unique days
days_w_flights <- flights %>% 
  mutate(flight_date = make_date(year, month, day)) %>% 
  distinct(flight_date) %>% 
  count()
days_w_flights  #output is 365, so all days had a flight

#which flights traveled the longest & shortest distances
shortest_flights <- flights %>% 
  arrange(distance)
longest_flights <- flights %>% 
  arrange(desc(distance))

View(longest_flights)

#It is smart to use filter first, then sort

####Columns####
#Mutate
#adds new columns from existing columns
flights %>% 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time *60,
    .before = 1 #moves this info from above to left columns
  )

flights %>% 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time *60,
    .after = day #moves the columns where you want them
  )

flights %>% 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time *60,
    .keep = "used" #only keeps the columns you used
  )

######Select#####
#sort columns by name
flights %>% 
  select(year, month, day)

#select all columns between year and day
flights %>% 
  select(year:day)

#select columns except those from year to day
flights %>% 
  select(!year:day)

#select all columns that are characters
flights %>%
  select(where(is.character))

#can rename variables as you select them by using =
flights %>% 
  select(tail_num = tailnum)

######Rename####
flights %>% 
  rename(tail_num = tailnum)

#####Relocate####
#moves variables around
flights %>% 
  relocate(time_hour, air_time)

#can also specify where to like in mutate
flights %>% 
  relocate(year:dep_time, .after = time_hour)
flights %>% 
  relocate(starts_with("arr"), .before = dep_time)


######Exercises####
#select deptime, depdelay, arrtime, and arrdelay
flights %>% 
  select(dep_time, dep_delay, air_time, arr_delay) 

variables <- c("year", "month", "day", "dep_delay", "arr_delay")

flights %>% 
  select(any_of(variables))

####The Pipe####
library(ggplot2)
library(tidyverse)
mtcars %>% 
  group_by(cyl) %>% 
  summarise(n= n())

####Groups####
#use Group by to divide dataset into meaningful groups
  library(nycflights13)

flights %>% 
  group_by(month)

#summarise
flights %>% 
  group_by(month) %>% 
  summarise(
    avg_delay = mean(dep_delay) #this gives an error, lets fix it
  )

flights %>% 
  group_by(month) %>% 
  summarise(
    avg_delay = mean(dep_delay, na.rm = TRUE)
  )

flights %>% 
  group_by(month) %>% 
  summarise(
    avg_delay = mean(dep_delay, na.rm = TRUE),
    n = n()
  )

#slice functions
#allow you to extract specific ros within each group
#df |> slice_head(n = 1) takes the first row from each group.
#df |> slice_tail(n = 1) takes the last row in each group.
#df |> slice_min(x, n = 1) takes the row with the smallest value of column x.
#df |> slice_max(x, n = 1) takes the row with the largest value of column x.
#df |> slice_sample(n = 1) takes one random row.


###Tidy Data####
#three rules of tidy data
##each variable is a column, each column is a variable
##Each observation is a row, each row is an observation
##Each value is a cell, each cell is a single value

#use table 1 to compute rate per 10,000
table1 %>% 
  mutate(rate=cases/population *1000)

#compute total cases per year
table1 %>% 
  group_by(year) %>% 
  summarise(total_cases = sum(cases))

#visualize this change over time
ggplot(table1)+
  aes(x = year, y = cases) +
  geom_line(aes(group = country), color = "grey50")+
  geom_point(aes(color = country, shape = country)) +
  scale_x_continuous()

####Lengthening Data####
#use pivot to change data into a tidy form
billboard

billboard %>% 
  pivot_longer(
    cols = starts_with("wk"),#take the columns that start with wk
    names_to = "week", #rename those columns to be "week"
    values_to = "rank" #assign those values to rank
  )

#we have some NAs in the dataset above, let drop them
billboard_long <- billboard %>% 
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE #drops the rows with NA
  )

#This looks good, but days of the week are characters, lets make them into numbers
billboard_longer <- billboard_long %>% 
  mutate(
    week = parse_number(week) #parse number takes the first number from the string and ignores text
  )

billboard_longer %>% 
  ggplot(aes(x = week, y = rank, group = track))+
  geom_line(alpha = 0.25)+
  scale_y_reverse()


#but what does pivoting actually do?
df <- tribble( #make small tibbles by hand
  ~id, ~bp1, ~bp2,
  "A",100, 120,
  "B", 140, 115,
  "C", 120, 125
)

#lets change the data to 
#have a column for measurement
#have a column for value of those measurements
df %>% 
  pivot_longer(
    cols = bp1:bp2,
    names_to = "measurement",
    values_to = "value"
  )

household %>% 
  pivot_longer(
    cols = !family,
    names_to = c(".value", "child"),
    names_sep = "_",
    values_drop_na = TRUE
  )

####Widening Data####
#makes datasets wider by increasing columns and reducing rows
#helps when one observation is spread across multiple rows
#Important: use pivot longer to solve problem where values have ended up in column names
cms_patient_experience
View(cms_patient_experience)

cms_patient_experience %>% 
  distinct(measure_cd, measure_title)

#pivot wider has opposite interface to pivot longer. 
#you must provide column names that define the values using values_from and column names (names_from)
cms_patient_experience %>% 
  pivot_wider(
    id_cols = starts_with("org"),
    names_from = measure_cd,
    values_from = prf_rate
  )

#How is this working
#we'll make a simple dataset with two patients (A and B) and bloodpressure measurements
df <- tribble(
  ~id, ~measurement, ~value,
  "A",        "bp1",    100,
  "B",        "bp1",    140,
  "B",        "bp2",    115, 
  "A",        "bp2",    120,
  "A",        "bp3",    105
)

#now we will take values from value column and names from measurement
df %>% 
  pivot_wider(
    names_from = measurement,
    values_from = value
  )

#this finds the unique values
df %>% 
  distinct(measurement) %>% 
  pull()
