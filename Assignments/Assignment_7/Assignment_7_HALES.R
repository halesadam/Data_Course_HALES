#Assignment 7 ####
##Setup####
library(tidyverse)
library(janitor)
library(skimr)

#Read in CSV and clean names
dat <- read.csv("Utah_Religions_by_County.csv") %>% 
  clean_names()

#Lengthen Dataset
#rename religious to proportion_religious
dat_long <- dat %>% 
  pivot_longer(cols = -c(county, pop_2010),
               names_to = "religion",
               values_to = "proportion")

#Explore religious affiliations across the state 
ggplot(dat_long)+
  aes(x = religion, y = proportion) +
  geom_col() + 
  theme(
    axis.text.x = element_text(angle = 90)
  )
#wow, not surprising


#Let's make a column titled "count" which is the product of pop and proportion
#this serves as a count of followers for a given religion
dat1 <- dat_long %>% 
  mutate(count = as.integer(pop_2010 * proportion)) #used as.integer for whole numbers bc we are dealing with people

#use this new column to see count of relig. by county and total county population
ggplot(dat1)+
  aes(x = county, y = count) +
  geom_col() +
  facet_wrap(~religion) +
  scale_fill_brewer(palette = "Set3") +
  theme(
    axis.text.x = element_text(angle = 90)
  )

##Task1
#Does population of a county correlate with the proportion of any specific religious group in that county?
#Compute correlation for each religion
cor_results <- dat_long %>%
  group_by(religion) %>%
  summarize(
    correlation = cor(pop_2010, proportion)
  ) %>%
  arrange(desc(abs(correlation))) 

# Print the results
print(cor_results)
#interesting, muslim has the highest correlation

#plot 
ggplot(cor_results)+
  aes(x = religion, y = correlation) +
  geom_point() +
  theme(
    axis.text.x = element_text(angle = 90)
  ) +
  labs(
    title = "Correlation of Religion and Population",
    y = "Religion",
    x = "Correlation"
  )


##Task2
#does proportion of a specific religion in a county correlate with proportion of non-religious





