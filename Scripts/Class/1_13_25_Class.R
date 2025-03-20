library(tidyverse)
data(iris)

dir.create("./figures")
iris %>% 
  ggplot(aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()
ggsave(filename = "./figures/basic_plot.png",#basic way to save
       width = 6,
       height = 6,
       dpi = 300) 

# Clean data
#every row is a single observation
#every column is a single variable


iris %>% 
  View
table1 #tidy data looks like this
table2
table3
table4a
table4b
table5

#review chapter 12 in R for datascience

table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE) #before, cases and pop. were characters, need to convert to numeric

table5 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE) %>% 
  mutate(year = paste0(century, year) %>% as.numeric) %>% 
  select(-century)

table2 %>% 
  pivot_wider(names_from = type, values_from = count)

table4c <- 
table4a %>% 
  pivot_longer(cols = c("1999", "2000"), #use these columns
               names_to = "year", #to make column named year
               values_to = "cases", #assign those values to count
               names_transform = as.numeric) 

table4d <- 
#do the exact same for table 4b
table4b %>% 
  pivot_longer(cols = c("1999", "2000"), #use these columns
               names_to = "year", #to make column named year
               values_to = "population", #assign those values to count
               names_transform = as.numeric) 

full_join(table4c, table4d)
  

#or do it all in one step
full_join( table4a %>% 
             pivot_longer(cols = c("1999", "2000"), #use these columns
                          names_to = "year", #to make column named year
                          values_to = "cases", #assign those values to count
                          names_transform = as.numeric),
           table4b %>% 
             pivot_longer(cols = c("1999", "2000"), #use these columns
                          names_to = "year", #to make column named year
                          values_to = "population", #assign those values to count
                          names_transform = as.numeric)  )


