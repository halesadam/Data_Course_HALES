library(tidyverse)
library(janitor)
library(palmerpenguins)
library(skimr)
library(lubridate)

dat <- penguins_raw

dat <- clean_names(dat)

View(dat)
names(penguins)

#change culmen to bill
names(dat) <- names(dat) %>% 
  str_replace("culmen", "bill")

skim(dat)

#do cleaning to match penguins
dat <- dat %>% 
  select(bill_length_mm, bill_depth_mm, body_mass_g, flipper_length_mm, species, island, sex, date_egg) %>% 
  mutate(year = date_egg %>% year() %>% as.numeric()) %>% 
  select(-date_egg) %>% 
  mutate(sex = sex %>% str_to_lower() %>% factor(levels = "female", "male")) %>% 
  mutate(species = species %>% str_split(" ") %>% map_chr(1)) %>% 
  select(species, island, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g, sex, year) %>% 
  mutate(flipper_length_mm = flipper_length_mm %>% as.integer(), 
         body_mass_g = body_mass_g %>% as.integer(), 
         year = year %>% as.integer(),
         species = species %>% factor(levels = c("Adelie", "Chinstrap", "Gentoo")),
         island = island %>% factor(levels = c("Biscoe", "Dream", "Torgersen")))


full_join(dat, penguins)
