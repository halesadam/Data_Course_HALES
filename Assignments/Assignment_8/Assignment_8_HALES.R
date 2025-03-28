library(tidyverse)
library(easystats)
library(modelr)
library(MASS)
library(ranger)
library(mgcv) #GAM model later on 

#read in csv
dat <- read.csv("mushroom_growth.csv")

#make plots to explore relationships between response and predictors
#boxplot of growth rate and humidity for the two sp. 
ggplot(dat)+
  aes(x = Humidity, y = GrowthRate, fill = Species)+
  geom_boxplot()

#Scatter plot showing the effect of light on growth rate
ggplot(dat)+
  aes(x = Light, y = GrowthRate) + 
  geom_point()+
  geom_smooth(method = "lm")

#scatter plot showing growth rate by temperature for each light value
ggplot(dat)+
  aes(x = Temperature, y = GrowthRate)+
  geom_point()+
  geom_smooth(method = "lm")+
  facet_wrap(~Light) +
  labs(
    title = "Temperature vs Growth Rate for Three Light Levels"
  )
#interesting, for a high light environment, growth rate was highest at lower temperatures

#scatter plot of nitrogen and growth rate for the two species
ggplot(dat)+
  aes(x = Nitrogen, y =GrowthRate)+
  geom_point()+
  facet_wrap(~Species)
# AHH...why does cornucopiae have to haeve so many mushrooms that grow good no matter what
# silly biology

#make 4 models to explain dependent variable "Growth Rate"
mod1 <- 
  glm(data = dat,formula = GrowthRate ~ Humidity * Temperature)

mod2 <- 
  glm(data = dat, formula = GrowthRate ~ Species)

mod3 <- 
  glm(data = dat, formula = GrowthRate ~ .)

mod4 <- 
  glm(data = dat, formula = GrowthRate ~ .^2)

compare_models(mod1, mod2, mod3, mod4)

#find RMSE for each model
compare_performance(mod1, mod2, mod3, mod4)

#plot
compare_performance(mod1, mod2, mod3, mod4) %>% plot()
#mod 4 seems to be the best, still not great though

#add predictions using mod4
dat <- dat %>% 
  add_predictions(mod4)

#visualize predictions vs real
ggplot(dat)+
  aes(x = GrowthRate, y = pred)+
  geom_point() + 
  geom_smooth(method = "lm")

#get report
report(mod4)

#new model - I didn't like the others
#try to hone in mod4
step <- stepAIC(object = mod4)
step$formula

#mod5 which is the good stuff from mod4
mod5 <- 
  glm(data = dat,
      formula = step$formula)

compare_performance(mod1, mod2, mod3, mod4, mod5)
#dang, mod5 wasn't any better even with the cleaning up

#Okay, just for fun, what about a:
#Tree based model
mod6 <- 
  ranger(data = dat,
         formula = GrowthRate ~ .,
         importance = "permutation")

preds <-  predict(mod6, dat)

dat$tree_pred <- preds$predictions

ggplot(dat)+
  aes(x = tree_pred, y = GrowthRate) +
  geom_point() + 
  geom_smooth(method = "lm")
#wow, I like that better




#what about non-linear models
model_gam <- gam(GrowthRate ~ s(Light) + s(Temperature) + Humidity + Species, data = dat)
summary(model_gam)

# Plot smooth terms
plot(model_gam, pages = 1)




