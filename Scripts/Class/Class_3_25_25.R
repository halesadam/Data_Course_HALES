#logistic regressions
library(tidyverse)
library(easystats)
library(palmerpenguins)


# model penguins
# response = "sex"

dat <- penguins %>% 
  dplyr::filter(!is.na(sex)) %>% 
  mutate(male = sex == "male") #need a true/false column

names(dat)

#make mod1
mod1 <-
  glm(data = dat %>% select(-sex), #take out sex
      formula = male ~ ., 
      family = 'binomial') #what shape do we bend reality into for the model


summary(mod1)



dat <- dat %>% 
  mutate(pred = predict(mod1, dat, type = "response"))


dat %>% 
  ggplot(aes(x = body_mass_g, y = pred, color = sex))+
  geom_point()

dat <- 
dat %>% 
  mutate(error = pred > 0.5) %>% 
  mutate(success = male == error)

View(dat)

dat$success %>% summary

#make a new model to predict grad school admissions
df <- read_csv("./Data/GradSchool_Admissions.csv")

mod2 <- df %>% 
  glm(data = .,
      formula = admit ~ (gre*gpa)*rank,
      family = 'binomial')

df %>% 
  mutate(pred = predict(mod2,df,type = 'response')) %>% 
  ggplot(aes(x = gre, y = pred, color = factor(rank)))+
  geom_point() +
  geom_smooth()

report(mod2)


