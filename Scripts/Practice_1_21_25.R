## PRACTICE ####
library(tidyverse)
library(ggplot2)
data(mtcars)
head(mtcars)
mtcars

#extract cars with good gas mileage
commuters <- mtcars[mtcars$mpg >20,]

#Multiple conditions
narrow <- mtcars[mtcars$mpg <15 & mtcars$cyl == 8,]
head(narrow)
narrow
#subset a subset
guzzlers_high_hp <- narrow$hp>216
guzzlers_high_hp
class(guzzlers_high_hp)

plot(x=mtcars$mpg, y=mtcars$cyl)
ggplot(mtcars, aes(x = factor(cyl), y=mpg))+
  geom_boxplot() +
  labs(x = "Number of Cylinders", y= "MPG")+
  theme_minimal()


## Operators in R ####
old <- c(1:10)
x[(x>8|x<5)] #look for values greater than 8 AND include les than 5
x
x>8
x<5
x>8 |x<5

x %in% c(1,2,3) #This is much easier to type than x==1|x==2|x==3

## Subsetting ####
### Basics Of ####

#example[x,y] | Example is the df we want to subset, x is the rows we want, y is the columns we want
# pull this example dataset for some practice
### import education expenditure data set and assign column names
education <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/robustbase/education.csv", stringsAsFactors = FALSE)
colnames(education) <- c("X","State","Region","Urban.Population","Per.Capita.Income","Minor.Population","Education.Expenditures")
View(education)

#we need the info for State, Minor.pop, and Education, Expenditures
ed_exmpl <- education[c(10:21),c(2,6:7)]
ed_exmpl2 <- education[c(10:21),c(2,4:7)]
View(ed_exmpl2)

### Another way ####
#to save you from digging though a Huge df
ed_exmpl3 <- education[which(education$Region==2),names(education)%in% c("State", "Minor.Population", "Education.Expenditures")]
View(ed_exmpl3) #that kinda sucked though, lets try an easier way

### Subset Function ####
#using the subset() function
ed_exp4 <- subset(education, Region == 2, select = c("State","Minor.Population","Education.Expenditures"))
#how this works:
#subset function takes 3 arguments:
  #The df you want subsetted (in this case education)
  #rows corresponding to the condition you want subsetted
  #the columns you want returned
#In other words, subset the df "education" to include specific rows (region2) and return minor pop and education expend for those areas


### Cool Way ####
library(tidyverse)
library(dplyr)

filter()#is used to subset rows
select() #is a way to choose specific columns from that df
#filter for sepal lengths greater than 5
filtered_sp_area <- sp_area %>% filter(Sepal.Length>5) #notice I used a pipe command here
#filter for sepal length >5 and sepal width <3.5
filtered_sp_area <- sp_area %>% 
  filter(Sepal.Length >5 & Sepal.Width <3.5)
filtered_sp_area

#now, lets say you want to select the sepal lentg and sepal area columns from the sp_area df
#selecting specific columns
selected_sp_area <- sp_area %>%
  select(Sepal.Length, Sepal.Area)

x <- c(2.1,4.2,3.3,5.4)

x[c(3,1)] #returns elements at specific locations
x[c(1,4)] 
x[order(xx)]

x[c(TRUE,TRUE,FALSE,FALSE)] #selects elements where corresponding value is TRUE
x[c(TRUE, FALSE)] #this is shorter than the vector xx so it will recycle the answer
x[]
x[0]

#you can also use a character vector inside a numercial vector to return elements with matching names
(y <- setNames(x, letters[1:4]))
y
y[c("a", "a", "b")]


## Data Frames ####
df <- data.frame(x = 1:3,y=3:1,z=letters[1:3])
df
df$mean(x)
#you can select columns from a df two ways:
### Like a list ####
df[c("x","y")]
### Like a Matrix ####
df[,c("x","y")] #all rows, columns x and y

## Lists ####
?matrix
a <- matrix(1:9, nrow =3)
colnames(a) <- c("A", "B", "C")
a[1:2,]
a[c(TRUE, FALSE, TRUE), c("B","A")] #Include the first and third rows
#View the rows 1 and 3 for columns B and A

data(iris)
iris
str(iris)
#subset "iris" to 1:50 and show Species, Petal Length 
sppl <- iris[c(1:50), c("Species", "Petal.Length")]

spsl <- iris[c(51:100), c("Species", "Sepal.Length")]

#create a subset that only includes sepal width and lenth
#call it sp_area
sp_area <- iris[,c("Sepal.Length","Sepal.Width")]
str(sp_area)
sp_area

#now, create a third row called Sepal.Area that is the product of the other two
sp_area$Sepal.Area <- 
  sp_area$Sepal.Length*sp_area$Sepal.Width
# add that new row on to the existing Iris dataframe
iris$Sepal.Area <- sp_area
iris$Sepal.Area

