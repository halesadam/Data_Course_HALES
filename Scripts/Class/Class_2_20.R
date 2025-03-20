library(tidyverse)
install.packages("skimr")
library(skimr)
install.packages("janitor")
library(janitor)

dat <- read_csv("./Data/Bird_Measurements.csv") %>% clean_names()
skim(dat) #good place to see where you're at

#what's wrong
# - some columns have multiple variables
# - need a column for sex
# - get rid of _N columns
# - Extra dumb columns

#standardize column names with janitor
dat2 <- 
  dat %>% 
  clean_names()

# Split into M, F and U dfs
# pivot longer
# clean up names
# merge back together
# Remove anything that ends in "_N"

male <- 
dat %>% 
  select(-ends_with("_n")) %>% 
  select(family, species_name, english_name, clutch_size, egg_mass, mating_system, starts_with("m_")) %>% 
  mutate(sex = "male")
names(male) <- names(male) %>% str_remove("^m_") #take away M prefixes
names(male)

female <- 
  dat %>% 
  select(-ends_with("_n")) %>% 
  select(family, species_name, english_name, clutch_size, egg_mass, mating_system, starts_with("f_")) %>% 
  mutate(sex = "female") 
names(female) <- names(female) %>% str_remove("^f_")

unsexed <- 
  dat %>% 
  select(-ends_with("_n")) %>% 
  select(family, species_name, english_name, clutch_size, egg_mass, mating_system, starts_with("unsexed_")) %>% 
  mutate(sex = "unsexed")
names(unsexed) <- names(unsexed) %>% str_remove("^unsexed_")

names(male)
names(female)
names(unsexed)

identical(names(male), names(female))

dat <- male %>% 
  full_join(female) %>% 
  full_join(unsexed)

ggplot(dat)+
  aes(x = tarsus, y = mass, color = sex)+
  geom_point()+
  geom_smooth()

