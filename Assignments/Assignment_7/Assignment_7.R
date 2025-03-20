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
dat <- dat %>% 
  pivot_longer(cols = -c(county, pop_2010,religious),
               names_to = "religion",
               values_to = "proportion") %>% 
  rename("proportion_religious" = religious)

#Explore religious affiliations across the state 
ggplot(dat)+
  aes(x = religion, y = proportion) +
  geom_col() + 
  theme(
    axis.text.x = element_text(angle = 90)
  )



#Let's make a column titled "count" which is the product of pop and proportion
#this serves as a count of people following that religion
dat1 <- dat %>% 
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

# Find the religion with the strongest correlation
strongest_religion <- cor_results$religion[which.max(abs(cor_results$correlation))]

# Plot the strongest correlation
ggplot(dat %>% filter(religion == strongest_religion), aes(x = pop_2010, y = proportion)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = paste("Population vs", strongest_religion, "Proportion"),
       x = "County Population",
       y = paste(strongest_religion, "Proportion")) +
  theme_minimal()








