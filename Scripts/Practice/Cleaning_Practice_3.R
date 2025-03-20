#Cleaning practice from some youtube video
library(tidyverse)
View(starwars)

#Variable types
glimpse(starwars) #this allows you to have a look at your variables
class(starwars$gender) #what type of data is in the column gender
unique(starwars$gender) #what can be found in that particular variable

starwars$gender <- as.factor(starwars$gender) #this makes gender into a factor
class(starwars$gender)
levels(starwars$gender)

starwars$gender <- factor((starwars$gender), #this reorders the levels
                          levels = c("masculine",
                                     "feminine"))

#select variables
names(starwars)

starwars %>% 
  select(name, height, ends_with("color"))

#now we filter for the ones we want
#what are the possible values of hair color
unique(starwars$hair_color)

starwars %>% 
  select(name, height, ends_with("color")) %>% 
  filter(hair_color %in% c("blond", "brown") & height <180)

#missing data
mean(starwars$height, na.rm = TRUE)

starwars %>% 
  select(name, gender, hair_color, height) %>% 
  na.omit() 

starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) #filters for incomplete cases 

starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>% 
  drop_na(height) #drop the height nas

starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>% 
  mutate(hair_color = replace_na(hair_color, "none")) #replace hair color nas with none


#duplicates
Names <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)

friends <- data_frame(Names, Age)
View(friends)         

friends %>% 
  distinct()

#recoding variables
starwars %>% 
  select(name, gender)

starwars %>% 
  select(name, gender) %>% 
  mutate(gender_coded = recode(gender, 
                "masculine" = 1,
                "feminine" = 2)) #this could be useful for Brassica Project
