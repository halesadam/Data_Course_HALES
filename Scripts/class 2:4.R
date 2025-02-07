library(ggplot2)
library(tidyverse)
iris
ggplot(iris) + 
  aes(x = Sepal.Length, y = Species) +
  geom_point() +
  labs(
    x = "Sepal Length", 
    y = "Species", 
    title = "Sepal Length vs Species") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),  
    axis.title.x = element_text(size = 14, face = "italic"),  
    axis.title.y = element_text(size = 14, face = "italic"),  
    axis.text = element_text(size = 12) )
  
# Do cars with big engines use more fuel than cars with small engines?
# lets use the mpg dataframe

data(mpg)
View(mpg)        

ggplot(mpg) +
  geom_point(mapping =  aes(x = displ, y = hwy))

#the mapping argument above defines how variables in the dataset are mapped to visual properties
#isn't this basically the same thing?
ggplot(mpg)+
    aes(x= displ, y = hwy)+
  geom_point()

#lets make a graphing TEMPLATE
ggplot(data=<DATA>) +
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS))

ggplot(data=mpg)
nrow(mpg)
ncol(mpg)
?mpg

ggplot(mpg) + 
  aes(x=class,y = drv) +
  geom_point()

#we can map "class" to a color aesthetic
ggplot(mpg) +
  geom_point(mapping =  aes(x = displ, y = hwy, color = class))

#we can also map "class" to a size aesthetic
#But it's ugly as hell
ggplot(mpg)+
  geom_point(mapping=aes(x = displ, y=hwy, size = class))

#we can also map class to alpha aesthetic
ggplot(mpg)+
  geom_point(mapping=aes(x = displ, y=hwy, shape = class))

#now lets make the color of the plot blue
ggplot(mpg) +
  geom_point(mapping = aes(x=displ, y = hwy), color = "blue")

#another thing we can do is add some faects using facet_wrap
ggplot(mpg) +
  aes(x=displ, y=hwy) +
  geom_point() +
  facet_wrap(~class, nrow = 2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

ggplot(mpg)+
  aes(x=displ, y=hwy) +
  geom_point() +
  facet_grid(drv~cyl)

#left off on 3.5.1
  