#Subsetting Practice

data[row, column]

data(iris)
#select the first row
iris[1,]

#select the first column
iris[,1]

#select first 10 rows and first 2 columns
iris[1:10, 1:2]

#subsetting by column name
iris[,"Sepal.Length"]

iris[,c("Sepal.Length", "Species")]

#using the $ means "give me the value of"
iris$Sepal.Length

#subsetting with logical conditions
#rows wehere sepal length is greater than 5
iris[iris$Sepal.Length>5,]

#select the rows where species is "setosa"
iris[iris$Species == "setosa",]

#Select rows where Sepal.Length is greater than 5 adn species is "setosa"
iris[iris$Sepal.Length >5 & iris$Species == "setosa",]
