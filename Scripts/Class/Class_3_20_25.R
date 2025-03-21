library(tidyverse)
library(easystats)
library(MASS)
library(caret) #used to subset dataset later on, line 93
library(tidymodels)#this is a good resource if you want to look into it

dplyr::select()
# make 2 vectors of random numbers drawn from normal/gaussian distribution
x <- rnorm(100,100) # 100 numbers, mean of 100
y <- rnorm(100,99.9) # 100 numbers, mean of 99.9
t.test(x,y) # do a t-test to see if means are statistically different

# plot distributions
data.frame(x,y) %>%
  pivot_longer(everything()) %>% 
  ggplot(aes(x=value,fill=name)) +
  geom_density(alpha=.5)

# run a linear regression (instead of a t-test)
data.frame(x,y) %>%
  pivot_longer(everything()) %>% 
  glm(data=.,
      formula = value ~ name) %>% 
  summary()


library(palmerpenguins)
#make three models predicting body_mass_g
penguins %>% glimpse

mod1 <- 
penguins %>% 
  glm(data = .,
      formula = body_mass_g ~ species)

mod2 <- 
penguins %>% 
  glm(data = ., 
      formula = body_mass_g~sex)

mod3 <- 
penguins %>% 
  glm(data = .,
      formula = body_mass_g~ island)

mod4 <- 
  glm(data = penguins,
      formula = body_mass_g ~ .^2) # the interaction between everything . is for everything

compare_models(mod1, mod2, mod3)

compare_performance(mod2, mod3, mod4, mod5) %>% plot()

mod4$formula
mod2$formula


step <- stepAIC(object = mod4)
step$formula #revised mod formula

mod5 <- 
  glm(data = penguins,
      formula = step$formula)

compare_performance(mod2, mod3, mod4, mod5) %>% plot()

#take a model and predict outcome based on new thing you haven't seen before 
new_penguin <- 
  data.frame(species = "Adelie",
             island = "Torgersen",
             bill_length_mm = 40,
             bill_depth_mm = 20,
             flipper_length_mm = 500,
             sex = "female",
             year = 2007)

predict(object = mod5, newdata = new_penguin)

#predict your model based on your model
#not a great indicator of model performance
#add as a new column
penguins$preds <- predict(mod5, penguins)

#make a prediction
predict(mod5, penguins)

#plot
ggplot(penguins)+
  aes(x = body_mass_g, y = preds)+
  geom_point()+
  geom_smooth(method = "lm")

#split up dataset to train model
#split up into two random chunks
#have to split up so that this can be done
#called cross validation - subset data and test on the half that it wasn't trained on
dat <-
  penguins[complete.cases(penguins),] #only use rows where there is no NA

train_rows <- caret::createDataPartition(y = dat$body_mass_g,p = 0.5,)

train <- dat[train_rows$Resample1,]
test <- dat[-train_rows$Resample1,]

mod_xval <- 
  glm(data = train, 
      formula = step$formula)

xval_preds <- predict(mod_xval,newdata = test)

test %>% 
  mutate(xval_preds = xval_preds) %>% ggplot(aes(x = body_mass_g, y =xval_preds))+
  geom_point()+
  geom_smooth(method = "lm")

model_performance(mod_xval)
model_performance(mod5)
check_model(mod_xval)

report(mod_xval)
