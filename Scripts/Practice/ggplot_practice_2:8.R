# ggplot practice
# 3.5, facets
library(ggplot2)

ggplot(mpg) +
  geom_point(mapping = aes(x = displ, y=hwy)) +
  facet_wrap(~class, nrow = 2)

#to facet based on two variables, add facet_grid()
ggplot(mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#3.6, Geometric Objects
# a geom is just an object that the plot used to represent the data

#note the geom is point, this will produce scatter plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#here the geom is smooth, and will be a line
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# you can combine two geoms
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "orange", shape = 2, alpha = 0.75) +
  geom_smooth(mapping = aes(x = displ, y = hwy), color = "darkgreen", fill = "purple")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class, shape =manufacturer)) 

#faceting
ggplot(mpg)+
  aes(x = displ, y=hwy) + 
  geom_point() + 
  facet_wrap(~class) + #this creates seperate plots for each car class
  theme_minimal()

#custom themes
ggplot(mpg) + 
  aes(x = displ, y=hwy, color = class) + 
  geom_point(size = 3) + 
  theme_minimal() + 
  labs(
    title = "Stuff", 
    subtitle = "more stuff", 
    x = "engine displ",
    y = "hwy mpg",
    caption = "datasource: ggplot2 mpg dataset"
  ) +
  annotate("text", x = 4, y = 39, label = "Higher efficiency", color = "darkgreen", size = 6)
# the annotate is pretty cool, allows you to add text to the data, pretty cool

#Dual axis plots
#uses a secondary y axis to compare two metrics with different scales
ggplot(mpg) +
  aes(x = displ) +
  geom_line(aes(y = hwy), color = "blue") +
  geom_line(aes(y = cty), color = "red") +
  scale_y_continuous(
    name = "highway mpg",
    sec.axis = sec_axis(~./1.5, name = "city MPG")
  )

#interactive plot with plotly
install.packages("plotly")
library(plotly)

p <- ggplot(mpg) + 
  aes(x = displ, y =hwy, color = class) +
  geom_point(size = 2, shape = 2) +
  theme_minimal()

ggplotly(p) # converts the ggplot to an interactive plot

# complex geoms
# violin plot
ggplot(mpg)+
  aes(x = class, y = hwy, fill = class)+
  geom_violin()

#customizing legends and scales
ggplot(mpg) +
  aes(x = displ, y = hwy, color = class) + 
  geom_point(size=3)+
  scale_color_brewer(palette = "Set1") #use this to change color of geompoint
  theme_minimal() + 
  theme(legend.position = "bottom", legend.title = element_blank())

#by default, ggplot will put the legend on the right side
ggplot(mpg)+
  aes(x = displ, y=hwy, color = class) + 
  geom_point(size =2) + 
  scale_color_brewer(palette = "Set1") + 
  theme_minimal() + 
  labs(color = "Vehicle Class", #changes the legend title to say Vehicle class
    title = "Hwy MPG vs Displacement",
    subtitle = "Based on class",
    y = "Hwy MPG",
    x = "Engine Displacement",
    caption = "data source ggplot2 mpg"
  ) + 
  theme(legend.position = "bottom") #moves legend to the bottom of the page

# Customizing legend appearance
ggplot(mpg)+
  aes(x = displ, y=hwy, color = class) + 
  geom_point(size =2) +
  theme_minimal()+
  theme(
    legend.position = "bottom",
    legend.background = element_rect(fill = "lightgrey", color = "black"), #background color and border
    legend.key = element_rect(fill = "white"), #background of each legend key
    legend.text = element_text(size = 12, face = "bold"), #bigger, bold text
    legend.title = element_text(size = 14, face = "bold") #larger red legend title
  ) +
  annotate("text", x = 4, y = 39, label = "Higher Efficiency", color = "darkgreen", size = 4) # some fun annotations for practice

#using a gradient for a continuous variable
ggplot(mpg) +
  aes(x = displ, y = hwy, color = cyl) +
  geom_point() + 
  scale_color_gradient(low = "red", high = "darkgreen") + #allows you to change the color of the points based on a gradient. really cool
  theme_minimal()

#customizing axis labels and tick marks
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  scale_x_continuous(name = "Engine Displacement (L)", breaks = seq(1, 7, 1)) +  # Custom breaks
  scale_y_continuous(name = "Highway Fuel Efficiency (MPG)", limits = c(10, 50)) +  # Set limits
  theme_minimal

#Way too deep dive into theme()
ggplot(mpg) + 
  aes(x = displ, y = hwy, color = class) +
  geom_point() + 
  theme(
    panel.background = element_rect(fill = "orange"), #set background color
    panel.grid.major = element_line(color = "gray90"), #light gray grid lines
    panel.grid.minor = element_line(color = "purple"), #set minor grid line color
    axis.title = element_text(size = 14, face = "bold", color = "darkgreen"), #bold axis titles
    axis.text = element_text(size = 12, color = "black", face = "bold"), #larger, bold axis labels
    legend.position = "bottom", #move legend to below the plot
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5), #centered, bolded title
    plot.subtitle = element_text(size = 13, face = "italic", hjust = 0.5), #subtitle in italics
    plot.caption = element_text(size = 10, color = "black") #caption reformatting
  )+
  labs(
    title = "Engine Size and Fuel Efficiency",
    subtitle = "highway mileage tends to decrease with larger engines",
    caption = "source: ggplot2 mpg dataset"
  )

