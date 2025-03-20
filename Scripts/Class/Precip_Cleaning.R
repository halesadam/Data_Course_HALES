#Cleaning Utah 
# SETUP ####

## Load Packages ####
library(tidyverse)
library(janitor)

## Load Datasets ####
dat1 <- read.csv("./Data/Utah_County_Precip/provo_hourly_precip_1980-2014.csv") %>% 
  clean_names()
dat2 <- read.csv("./Data/Utah_County_Precip/provo_hourly_precip_2014-2021.csv") %>% 
  clean_names()

View(dat1)
View(dat2)

names(dat2)
names(dat1)

#add station name to 2014-2021 set
dat2$station_name <- "South Jordan"

#create hpcp col in dat2
dat2$hpcp <- dat2$hourly_precipitation

#clean hpcp in dat2
dat2$hpcp %>% class
dat2$hpcp[dat2$hpcp == "T"] <- 0
dat2$hpcp <- dat2$hpcp %>% as.numeric()

#clean measurement units in dat1
dat1$hpcp %>% summary
dat1$hpcp[dat1$hpcp == 999.99] <- NA

#join both datasets
dat <- dat2 %>% 
  mutate(station = station %>% as.character()) %>% 
  select(names(dat1)) %>% 
  full_join(dat1)

View(dat)
dat %>% ggplot(aes(x =date, y= hpcp)) +
  geom_point(aes(color = station_name))+
  geom_smooth(method = "lm")

mod <- 
glm(data = dat,
    formula = hpcp ~ date)

summary(mod)


# Change "T" to 0
# get only variables from dat2 that match dat1
# make columns match
# merge with a full join