library(tidyverse)
library(janitor)
library(readxl) #reads excel

dat <- read.csv("./Data/Utah_Religions_by_County.csv")
read_xlsx("./Data/Utah_Religions_by_County.xlsx")


#determine what you want the plot to look like...an aesthetic on a plot must be its own column
myorder<- dat %>% 
  clean_names() %>% 
  pivot_longer(-c(county, pop_2010, religious),
               names_to = "religion",
               values_to = "proportion") %>% 
  group_by(religion) %>% 
  summarise(sum = sum(proportion)) %>% 
  arrange(desc(sum))

myorder$religion

dat %>% 
  clean_names() %>% 
  pivot_longer(-c(county, pop_2010, religious),
               names_to = "religion",
               values_to = "proportion") %>% 
  mutate(religion = factor(religion, levels = myorder$religion)) %>% 
  ggplot(aes(x = religion, y = proportion))+
  geom_col() +
  facet_wrap(~county)


ggplot(dat)+ 
  aes(x = religion, y = value) +
  geom_col() +
  facet_wrap(~County)



  
