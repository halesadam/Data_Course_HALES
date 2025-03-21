library(tidyverse)
library(easystats)

#1.read in csv
dat <- read.csv("unicef-u5mr.csv")

#have a look before tidying
View(dat)

#2. tidy data
dat_tidy <- dat %>% 
  pivot_longer(
    cols = starts_with("U5MR."),
    names_to = "Year",
    names_prefix = "U5MR.",
    values_to = "U5MR") %>% 
  mutate(Year = as.integer(Year))

#3. Plot U5MR over time
p1 <- 
ggplot(dat_tidy)+
  aes(x = Year, 
      y = U5MR,
      group = CountryName) +
  geom_line() + 
  facet_wrap(~Continent) +
  theme_bw()

#4. Save plot
ggsave("HALES_Plot_1.png", plot = p1, width = 10, height = 6, dpi = 300)

#.5 mean U5MR for all countries within a given continent at each year
#calculate the mean first
dat_mean <- dat_tidy %>% 
  group_by(Continent, Year) %>% 
  summarise(Mean_U5MR = mean(U5MR, na.rm = TRUE))

p2 <- 
ggplot(dat_mean) +
  aes(x = Year,
      y = Mean_U5MR,
      color = Continent) +
  geom_line(size = 1.0) + 
  theme_bw()

#6. Save the plot
ggsave("HALES_Plot_2.png", plot = p2, width = 10, height = 6, dpi = 300)

#7. Create three models of U5MR
#mod1 accounts for only year
mod1 <- glm(data = dat_tidy, formula = U5MR ~ Year)

#mod2 for Year and Continent
mod2 <- glm(data = dat_tidy, formula = U5MR ~ Year + Continent)

#mod3 for Year, Continent, and THEIR INTERACTION
mod3 <- glm(data = dat_tidy, formula = U5MR ~ Year * Continent)

#8. Compare models
compare_models(mod1, mod2, mod3)
compare_performance(mod1, mod2, mod3)
#the only place where these models differed was in R2 and RMSE
#mod3 had the highest R2 (most desireable)
#mod3 also has the lowest RMSE (most desireable)

#but let's double check by piping that to a plot
compare_performance(mod1, mod2, mod3) %>% plot()
#yep, mod3 is the best

#9. Plot models
#Make predictions for each model
predict_mod1 <- predict(mod1, newdata = dat_tidy) 
predict_mod2 <- predict(mod2, newdata = dat_tidy) 
predict_mod3 <- predict(mod3, newdata = dat_tidy) 

dat_tidy$predict_mod1 <- predict_mod1
dat_tidy$predict_mod2 <- predict_mod2
dat_tidy$predict_mod3 <- predict_mod3

#lengthen predictions
dat_tidy <- dat_tidy %>% 
  pivot_longer(
    cols = c(predict_mod1,predict_mod2,predict_mod3),
    names_to = "Model",
    values_to = "Predicted_U5MR"
  )

#Mutate to remove predict_mod prefix
dat_tidy <- dat_tidy %>% 
  mutate(Model = str_replace(Model, "predict_mod", "mod"))

#plot predictions
p3 <- ggplot(dat_tidy)+ #save plot as p3
  aes(x = Year,
      y = Predicted_U5MR,
      color = Continent) + 
  geom_line() +
  facet_wrap(~Model) +
  labs(
    title = "Model Predictions",
    x = "Year",
    y = "Predicted U5MR",
    color = "Continent"
  ) + 
  theme_bw()

#view the plot
p3

#save the plot
ggsave("HALES_Model_Predict_Plot.png", plot = p3, width = 10, height = 6, dpi = 300)

#10. Bonus


