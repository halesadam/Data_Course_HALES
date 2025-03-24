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
               values_to = "proportion") %>% 
  filter(religion!= "religious")

#Explore religious affiliations across the state 
state_religions_plot <- ggplot(dat_long)+
  aes(x = religion, y = proportion) +
  geom_col() + 
  theme(
    axis.text.x = element_text(angle = 90)
  ) +
  labs(
    x = "Religion",
    y = "Proportion",
    title = "Statewide Religion Proportions"
  )

#view the plot
state_religions_plot
#wow, not surprising

#save that plot
ggsave("state_religions_plot.png", plot = state_religions_plot, width = 8, height = 5, dpi =300)

#now that we've seen what we already know,
#let's find out what county is the most mormon!
lds_plot <- dat_long %>% 
  filter(religion == "lds") %>% 
  mutate(county = reorder(county, proportion)) %>% 
  ggplot(aes(x = county, y = proportion))+
  geom_col(fill = "steelblue") + 
  coord_flip() +
  labs(
    title = "LDS Proportion by County",
    x = "County",
    y = "Proportion"
  )

#View plot
lds_plot
#Insane there is such a difference in LDS people across the different counties
#almost 1/3 the proporiton of LDS people in Grand county than morgan county

#save LDS plot
ggsave("lds_plot.png", plot = lds_plot, width = 8, height = 5, dpi =300)

#let's make a plot showing total followers by religion
total_followers_plot <- dat_long %>%
  mutate(count = pop_2010 * proportion) %>%
  group_by(religion) %>%
  summarise(total_followers = sum(count, na.rm = TRUE)) %>%
  ggplot(aes(x = reorder(religion, total_followers), y = total_followers)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Number of Followers by Religion",
       subtitle = "From 2010 Population Data",
       x = "Religion",
       y = "Followers") +
  theme_minimal()

#view plot
total_followers_plot
#by follower count, the two biggest religious identifications in the state are LDS and non-religious

#save that plot
ggsave("total_followers_plot.jpg", plot = total_followers_plot, width = 8, height = 5, dpi =300)

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
relig_correlation_plot <- ggplot(cor_results)+
  aes(x = religion, y = correlation) +
  geom_point() +
  theme(
    axis.text.x = element_text(angle = 90)
  ) +
  labs(
    title = "Correlation of Religion and Population",
    x = "Religion",
    y = "Correlation"
  )
#again, muslim has the highest correlation

#view plot
relig_correlation_plot

#save plot
ggsave("task_1_plot.png", plot = relig_correlation_plot, width = 8, height = 5, dpi =300)


##Task2
#does proportion of a specific religion in a county correlate with proportion of non-religious
#pivot wider so each religion is its own column
dat_wide <- dat_long %>% 
  select(county, religion, proportion) %>% 
  pivot_wider(names_from = religion, values_from = proportion)

#put back into long format for all religions except non-religious
dat_nonrelig <- dat_wide %>% 
  pivot_longer(
    cols = -c(county, non_religious),
    names_to = "religion",
    values_to = "religion_proportion"
  )

#plot
nonreligious_plot <- ggplot(dat_nonrelig)+
  aes(x = non_religious, y = religion_proportion, color = religion)+
  geom_point(alpha = 0.5) +
  labs(
    title = "Religious Proportion and Non-Religious Proportion",
    x = "Proportion of Non-Religious",
    y = "Proportion of Religion" ,
    color = "Religion"
  ) +
  theme_minimal()

#view plot
nonreligious_plot
#interesting, as the population of LDS people goes down, the population of non-religious individuals goes up
#this is cool, an inverse correlation between LDS and Non-religious proportions

#save nonreligious plot
ggsave("task_2_plot.jpg", plot = nonreligious_plot, width = 8, height = 5, dpi =300)
