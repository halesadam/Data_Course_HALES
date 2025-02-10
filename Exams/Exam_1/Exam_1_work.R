library(dplyr)
library(stringr)
library(ggplot2)

#1
df <- read.csv("cleaned_covid_data.csv")

#2
A_states <- df %>% 
  filter(str_starts(Province_State, "A"))

#Clean up Last_update for readability
A_states$Last_Update <- as.Date(A_states$Last_Update)

#3
ggplot(A_states) +
  aes(x = Last_Update, y = Deaths) +
  geom_point(size = 0.5) +
  facet_wrap(~Province_State, scales = "free_y") +
  labs(title = "Deaths over time for A states", 
       x = "Date",
       y = "Number of Deaths") +
  geom_smooth(method = "loess", se = FALSE, color = "steelblue")

#4
state_max_fatality_rate <- df %>%
  group_by(Province_State) %>%  
  summarize(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = TRUE)) %>%  
  arrange(desc(Maximum_Fatality_Ratio))

View(state_max_fatality_rate)

#5
state_max_fatality_rate <- state_max_fatality_rate %>%
  mutate(Province_State = factor(Province_State, levels = Province_State))

ggplot(state_max_fatality_rate)+
  aes(x = Province_State, y = Maximum_Fatality_Ratio) +
  geom_col(fill = "steelblue") +  
  labs(
    title = "Peak Case Fatality Ratio by State",
    x = "State",
    y = "Maximum Fatality Ratio"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust  = 0.5, vjust = 0.5),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(), 
    plot.title = element_text(face = "bold"), 
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold")
  )

#Bonus
# Last_Update is and makes a crap figure, converted to year, month format for readability and tidiness
df$Last_Update <- as.Date(df$Last_Update)

#Need to Summarize cumulative deaths over time
us_cumulative_deaths <- df %>%
  group_by(Last_Update) %>% 
  summarize(Cumulative_Deaths = sum(Deaths, na.rm = TRUE))

ggplot(us_cumulative_deaths, aes(x = Last_Update, y = Cumulative_Deaths)) +
  geom_line(color = "blue", size = 1.5) +  
  labs(
    title = "Cumulative COVID-19 Deaths Over Time in the US",
    x = "Date (Year, Month)",
    y = "Cumulative Deaths"
  ) +
  theme_minimal() +  
  theme(
    plot.title = element_text(face = "bold", size = 13, hjust = 0.5),  # Bold and centered title
    axis.title.x = element_text(face = "bold", size = 10),  # Bold x-axis label
    axis.title.y = element_text(face = "bold", size = 10),  # Bold y-axis label
    axis.text.x = element_text(angle = 45, hjust = 1), # Rotate x-axis labels for readability
  )

