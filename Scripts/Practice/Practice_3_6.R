library(tidyverse)
install.packages('yarrr')
library(yarrr)

#Pirate's Guide to R####

##3.2 Descriptive Statistics####
mean(pirates$age)
max(pirates$height)
table(pirates$sex) # this is kinda handy

#now let's use aggregate to calculate the mean age of pirates for each sex
aggregate(x = age ~ sex,
          data = pirates,
          FUN = mean) #what function

##3.3 Plotting ####
ggplot(pirates)+
  aes(x = pirates$height,
      y = weight) +
  geom_point(alpha = 0.2) +
  theme_minimal() + 
  labs(
    x = "Height (cm)",
    y = "Weight (kg)",
    title = "My first scatterplot of pirate data",
    subtitle = "not really my first"
  ) +
  geom_smooth(method = lm)

##3.4 Hypothesis Tests####
#conduct a T test to see if there is a difference between ages of pirates who do and do not wear a headband
t.test(formula  = age ~ headband,
       data = pirates,
       alternative = 'two.sided')

#now we can test for correlation between pirates height and weight using cor.test
cor.test(formula = ~height + weight,
         data = pirates)

#now an ANOVA
#creata a tattoo model
tat.sword.lm <- lm(formula = tattoos ~ sword.type,
                   data = pirates)


##3.5 Regressions ####
#create a linear regression to see if pirate's age, weight, and number of tattoos that (s)he has preditcts how many treasure chests they've found
tchests.model <- lm(formula = tchests ~ age + weight + tattoos,
                    data = pirates)
summary(tchests.model)

##10.1 Sorting Data ####
#sorting data using the order() function

#sort the pirates df by height
pirates <- pirates[order(pirates$height),] #will sort by ascending order default

#sort in descending order
pirates <- pirates[order(pirates$height, decreasing = TRUE),]
pirates[1:5, 1:4]

#ordering by several columns
pirates <- pirates[order(pirates$sex, pirates$height),]
