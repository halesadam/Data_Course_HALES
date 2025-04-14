library(tidyverse)
library(broom)

#1. 
dat <- read.csv("FacultySalaries_1995.csv")

dat <- dat %>% 
  filter(Tier %in% c("I","IIA", "IIB")) %>% 
  select("Tier", "State",
         Full = "AvgFullProfSalary", 
         Assoc = "AvgAssocProfSalary", 
         Assist = "AvgAssistProfSalary") %>% 
  pivot_longer(cols = c("Full", "Assoc", "Assist"),
               names_to = "Rank",
               values_to = "Salary")

p1_dat<- 
  ggplot(dat)+
  aes(x = Rank, y = Salary, fill = Rank)+
  geom_boxplot()+
  facet_wrap(~Tier)+
  labs( 
    x = "Rank", 
    y = "Salary", 
    fill = "Rank" 
  ) + 
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45)
  ) 

print(p1_dat)

#2. Build an ANOVA model and display results in your report
# Test influence of "State" "Tier" and "Rank" on "Salary" but no interactions between predictors
#verify factors are set before making model
head(dat)
#set factor levels
dat$Tier <- factor(dat$Tier)
dat$Rank <- factor(dat$Rank)

anova_mod <- aov(Salary ~ State + Tier + Rank, data = dat)

summary(anova_mod)

#3. 
juniper <- read.csv("Juniper_Oils.csv")

important_juniper <- juniper %>% 
  select(YearsSinceBurn, alpha.pinene:thujopsenal)

long_juniper <- important_juniper %>% 
  pivot_longer(cols = alpha.pinene:thujopsenal,
               names_to = "Chemical_name",
               values_to = "Concentration")

#4. Make plot
ggplot(long_juniper)+
  aes(x = YearsSinceBurn, y = Concentration)+
  facet_wrap(~Chemical_name, scales = "free_y")+
  geom_smooth(color = "blue")+
  theme_minimal() +
  theme(
    strip.text = element_text(size = 7) #make text just a little smaller so you can see the full chemical name
  ) +
  labs(
    title = "Chemical Concentrations and Years Since Burn",
    x = "Years Since Burn",
    y = "Concentration"
  )


#5. Model
#Make one big model and then we can clean it up later
juniper_mod_big <- glm(Concentration ~ YearsSinceBurn * Chemical_name, 
                       data = long_juniper)

#tidy model output
mod_output <- tidy(juniper_mod_big)

#filter for significant interactions
significant_chemicals <- mod_output %>% 
  filter(p.value < 0.05) #filter for significance

print(significant_chemicals)
