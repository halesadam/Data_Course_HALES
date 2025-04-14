# Exam 3 Work
# I chose to do all my work here and then copy to markdown for report

#Load needed libraries
library(tidyverse)
library(janitor) #used to clean names
library(broom) #used for tidy() function

#1.- Recreate the Graph
#read in csv and clean names
faculty <- read.csv("FacultySalaries_1995.csv") %>% clean_names()

#view
View(faculty)

#view the data
head(faculty)

#Tidy data
#Lengthen dataset 
#Make cols that include info and value
faculty_long <- faculty %>%
  pivot_longer(
    cols = matches("^avg_|^num_"), #starts with "avg_" or "num_"
    names_to = "info",
    values_to = "value"
  )

View(faculty_long) #getting there

#Extract necessary information from info column
#This includes prof rank - need to set as Full, Assoc, or Assist per figure
#Also need to see if the info is salary, compensation, or number/count
faculty_long <- 
  faculty_long %>% 
  mutate(
  rank = case_when(
    str_detect(info, "full_prof") ~ "Full",
    str_detect(info, "assoc_prof") ~ "Assoc", #abbreviations to match figure
    str_detect(info, "assist_prof") ~ "Assist", 
    str_detect(info, "_all") ~ "All",
    TRUE ~ NA_character_ #catches NAs 
  ),
  info_type = case_when(
    str_detect(info, "salary") ~ "salary",
    str_detect(info, "comp") ~ "compensation",
    str_detect(info, "num") ~ "num_faculty",
    TRUE ~ NA_character_
  ))

#select only "salary" for plotting
#exclude rows where column equals V11B
#exclude All from rank
faculty_long_salary <- faculty_long %>% 
  filter(info_type %in% c("salary")) %>% 
  filter(tier != "VIIB") %>% 
  filter(rank != "All")

#Drop info_type and fed_id for the purpose of the tidyness and rename value to salary
salary <- faculty_long_salary %>% 
  select(-c(info, info_type, fed_id)) %>% #dropped info column as it was repetitive
  rename(salary = value) %>% 
  mutate(tier = as.factor(tier), #set tier, state, and rank as factors - useful for model 
         state = as.factor(state),
         rank = as.factor(rank))

#make the plot
p1_salary <- ggplot(salary)+
  aes(x = rank, y = salary, fill = rank)+
  geom_boxplot()+
  facet_wrap(~tier)+
  labs( #no title - example doesn't have a title
    x = "Rank", 
    y = "Salary", #change "Value" to "Salary"
    fill = "Rank" #capitalize R in Rank
  ) + 
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust=1)
  ) 

print(p1_salary)


#2. Build an ANOVA model and display results in your report
# Test influence of "State" "Tier" and "Rank" on "Salary" but no interactions between predictors

#verify class is right prior to making model
head(salary) #univ_name is a character but that's okay

anova_mod <- aov(salary ~ state + tier + rank, data = salary)

summary(anova_mod)

#3. Juniper oil
#read in csv and clean names
juniper <- read.csv("./Juniper_Oils.csv") %>%  clean_names()

#Let's have a look
head(juniper)

#there are a lot of columns here we really don't need. Let's only select what we do need
important_juniper <- juniper %>% 
  select(c(sample_id, alpha_pinene:thujopsenal, years_since_burn)) #select the span of chemicals

#now we can clean it up
long_important_juniper <- important_juniper %>% 
  pivot_longer(cols = alpha_pinene:thujopsenal, #select the span of chemicals again
               names_to = "chemical",
               values_to = "concentration")

#look at data
head(long_important_juniper)

#4. Graph
p2_juniper <- ggplot(long_important_juniper)+
  aes(x = years_since_burn, y = concentration)+
  facet_wrap(~chemical, scales = "free_y")+
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

#view the plot
print(p2_juniper)

#5. Model of Juniper
#Make one big model and then we can clean it up later
juniper_mod_big <- glm(concentration ~ years_since_burn * chemical, data = long_important_juniper)

summary(juniper_mod_big)

#tidy model output
mod_output <- tidy(juniper_mod_big)

#filter for significant interactions
significant_chemicals <- mod_output %>% 
  filter(p.value < 0.05) #way easier to just make a big model and then select the significant ones

print(significant_chemicals)
