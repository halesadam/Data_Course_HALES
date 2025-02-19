library(tidyverse)
library(gganimate)

#Part 1
df <- read.csv("BioLog_Plate_Data_copy.csv")
# dat <- read.csv("../../Data/BioLog_Plate_Data.csv") which way?

#lengthen df
df_long <- df %>% 
  pivot_longer(cols = starts_with("Hr_"),
               names_to = "Time",
               values_to = "Absorbance") %>% 
  mutate(Time = as.numeric(gsub("Hr_", "", Time)))

#Mutate a new column called "Type" that specifies either water or soil
df_long <- df_long %>% 
  mutate(Type = case_when(
    Sample.ID %in% c("Clear_Creek", "Waste_Water") ~ "Water",
    Sample.ID %in% c("Soil_1", "Soil_2") ~ "Soil",
    TRUE ~ NA_character_  # Assign NA to rows that don't match any condition
  ))

#filter for dilution of 0.1
filtered_df <- df_long %>% 
  filter(Dilution == 0.1) 

#plot
ggplot(filtered_df) +
  aes(x = Time, 
      y = Absorbance,
      color = Type) +
 geom_smooth(method = "loess", se = FALSE, linewidth = 0.5) +
  facet_wrap(~Substrate) +
  theme_minimal() +
  theme(
    strip.text = element_text(size = 6)
  )
warnings()

#Part 2 animated plot
#filter for Itaconic Acid
Itaconic_df <- df %>% 
  filter(Substrate == "Itaconic Acid")

#calculate mean for Sample ID replicates
mean_absorbance <- Itaconic_df %>% 
  group_by(Sample.ID, Dilution) %>% 
  summarise(across(starts_with("Hr_"), mean, na.rm  = TRUE)) 

mean_absorbance_long <- mean_absorbance %>%
  pivot_longer(cols = starts_with("Hr_"), 
               names_to = "Time", 
               values_to = "Mean_Absorbance") %>%
  mutate(Time = as.numeric(gsub("Hr_", "", Time)))

mean_absorbance_long

#plot
ggplot(mean_absorbance_long) +
  aes(x = Time, y = Mean_Absorbance,color = Sample.ID,group = Sample.ID)+
  geom_line()+ 
  theme_minimal()+
  facet_wrap(~Dilution) +
  labs(
    color = "Sample ID"
  ) +
  transition_reveal(Time)
