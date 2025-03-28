# Plotting

# Setup
library(tidyverse)
library(gganimate)
library(gifski)
library(ggthemes)

#load data set
df <- read_csv("./Data/Merged_DSR_Origin_Dataset.csv")

#Set appropriate factors and characters for plotting
#leave Accession ID as a character
df$Season <- as.factor(df$Season)
df$Block <- as.factor(df$Block)
df$Origin <- as.factor(df$Origin)
df$Species <- as.factor(df$Species)
df$DSR <- as.integer(df$DSR)

#1. Create a plot showing DSR progression over time
# Remove missing values in DSR
df_clean <- df %>% drop_na(DSR)

# Aggregate data: Get mean DSR for each Rep and Season
df_avg <- df_clean %>%
  group_by(Season, Rep) %>%
  summarise(Avg_DSR = mean(DSR, na.rm = TRUE), .groups = 'drop') %>% 
  mutate(Rep = as.integer(Rep)) #replicate needs to be a integer for plot to work

# Create the plot
p1_anim <- 
ggplot(df_avg, aes(x = Rep, y = Avg_DSR, group = Season, color = as.factor(Season))) +
  geom_line(size = 1) +         # Line showing progression
  geom_point(size = 2) +        # Points for each Rep        # Facet wrap by Season
  labs(title = "Average DSR Progression Over Replicates", 
       x = "Replicate", 
       y = "Average DSR",
       color = "Season") +
  transition_reveal(Rep)

#save animated plot to Plots folder
anim_save("./Plots/p1_anim.gif", animation = p1_anim)


