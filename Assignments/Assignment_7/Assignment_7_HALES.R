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
ggplot(dat_long)+
  aes(x = religion, 
      y  = )
cor(dat$, dat$religious)


# Compute correlation and p-values for each religion
cor_results <- dat %>%
  group_by(religion) %>%
  summarize(
    correlation = cor(pop_2010, proportion, use = "complete.obs"),
    p_value = cor.test(pop_2010, proportion, use = "complete.obs")$p.value
  ) %>%
  arrange(desc(abs(correlation)))  # Sort by absolute correlation strength

# Print the results
print(cor_results)

#wow, muslim has a correlation of 0.759 and a p value of <0.05

# Plot this correlation
ggplot(dat %>% filter(religion == strongest_religion), aes(x = pop_2010, y = proportion)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = paste("Population vs Muslim Population"),
       x = "County Population",
       y = "Muslim Proportion") +
  theme_minimal()








