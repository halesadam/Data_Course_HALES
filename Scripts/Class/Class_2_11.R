library(ggplot2)
install.packages("palmerpenguins")
library(palmerpenguins)
library(dplyr)
library(ggimage)
library(gganimate)
install.packages("wesanderson")
library(wesanderson)
install.packages("GGally")
library(GGally)

# A cool way to visualize a lot of data at the same time
# great way to begin
penguins %>% 
  GGally::ggpairs()

penguins %>% 
  ggplot(aes(x = bill_length_mm)) +
  geom_density()

#custom themes, etc
pal <- wesanderson::wes_palette("IsleofDogs1",3)
theme_set(theme_minimal() +
            theme(axis.text = element_text(size = 14, face = "bold"))


pal

data("penguins")

View("penguins")
pen

penguins
penguins

penguins_clean <- na.omit(penguins)

penguins <- penguins_clean %>%
  mutate(sex = case_when(
    sex == "female" ~ "Female",
    sex == "male" ~ "Male",
    TRUE ~ as.character(sex)  # Keeps NA values unchanged
  ))

head(penguins)
head(penguins_clean)

pe

p <- 
ggplot(penguins) +
  aes(x = flipper_length_mm, y = body_mass_g, color = species) +
  geom_point() +
  stat_ellipse() +
  facet_wrap(~sex) + 
  scale_color_manual(values = pal) +
  theme_bw() +
  labs(
    color = "Species",
    y = "Body mass (g)",
    x = "Flipper length (mm)",
  ) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )
 


p + gganimate::transition_states(species) + gganimate::ease_aes()

p


