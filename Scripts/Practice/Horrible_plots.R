#some ggplot Practice
library(ggplot2)

ggplot(iris) + 
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width))

ggplot(iris) +
  geom_point(mapping = aes(x = Sepal.Length, 
                           y = Sepal.Width, 
                           color = Species))
ggplot(iris) +
  geom_point(mapping = aes(x = Sepal.Length, 
                           y = Sepal.Width,
                           size = Petal.Length))
ggplot(iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  facet_wrap(~Species)

#Customizing theme elements
#this one is pretty ugly
ggplot(iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Species))+
  theme(
    plot.title = element_text(size = 16, face ="bold", hjust = 0.5),
    axis.title.x = element_text(size = 12, face = "bold", color = "blue"), 
    axis.title.y = element_text(size = 12, color = "limegreen"), 
    panel.background = element_rect(fill = "orange"),
    panel.grid.major = element_line(color = "yellow")
  )

library(ggplot2)

ggplot(iris) +
  geom_point(
    aes(x = Sepal.Length, y = Sepal.Width, 
        color = Species, 
        shape = Species, 
        size = Petal.Length)) + 
  scale_color_manual(values = c("setosa" = "limegreen", 
                                "versicolor" = "hotpink",
                                "virginica" = "yellow")) +
  theme(
    plot.background = element_rect(fill = "magenta", color = "lightpink", size = 24),
    panel.grid.major = element_line(color = "green")

    library(ggplot2)
    library(ggimage)
    
ggplot(iris) +
      geom_point(
        aes(x = Sepal.Length, y = Sepal.Width, color = Species, shape = Species, size = Petal.Length), 
        alpha = 0.9, stroke = 5
      ) +
      scale_color_manual(values = c("setosa" = "cyan", "versicolor" = "magenta", "virginica" = "yellow")) +
      scale_size_continuous(range = c(3, 10)) +
      theme(
        plot.background = element_rect(fill = "hotpink", color = "black", size = 5),
        panel.background = element_rect(fill = "yellow"),
        panel.grid.major = element_line(color = "green", linetype = "dotted", size = 2),
        panel.grid.minor = element_line(color = "red", linetype = "solid"),
        axis.line = element_blank()
      ) +
      labs(
        title = "🔥WORST PLOT EVER🔥",
        subtitle = "Your eyes will never recover",
        x = "SePaL LeNgTh (wHy So BiG?)",
        y = "SePaL WiDtH (wHy ThIs FoNt?)",
        caption = "Made by a monster"
      ) +
      scale_y_reverse() +
      geom_text(aes(x = 7, y = 4.5, label = "WHY?!"), size = 12, color = "red", angle = 45, fontface = "bold") +
      annotate("rect", xmin = 4, xmax = 5, ymin = 2, ymax = 4, fill = "cyan", alpha = 0.5)
    
   install.packages("ggimage")
 
#this one is pretty good  
library(ggplot2)
library(ggimage)

image_path <- "https://i1.sndcdn.com/artworks-000338100936-kt6c6s-t500x500.jpg"
p2 <- 
ggplot(iris) +
  geom_point(mapping = aes(x = Species, y = Sepal.Width, color = Species)) +
  geom_abline()
  theme(
    plot.title = element_text(size = 16, face ="bold", hjust = 0.5),
    axis.title.x = element_text(size = 12, face = "bold", color = "blue"), 
    axis.title.y = element_text(size = 12, color = "limegreen"), 
    panel.background = element_rect(fill = "orange"),
    panel.grid.major = element_line(color = "yellow")
  )

ggbackground(p2, image_path)


library(ggplot2)
library(ggimage)

ugly_data <- read.csv("Ugly_Plot_Dataset.csv")

ggplot(ugly_data, aes(x = X1, y = X2, color = Category, shape = as.factor(X4), size = X3)) +
  geom_point(alpha = 1) +  # No transparency = Overplotting mess
  scale_color_manual(values = rainbow(length(unique(ugly_data$Category)))) +  # Too many colors
  scale_size(range = c(5, 20)) +  # Oversized points
  theme_minimal(base_size = 5) +  # Tiny text
  labs(title = "The Worst Plot Ever", x = "X1 (Completely Random)", y = "X2 (Also Random)", 
       color = "Point Color is Meaningless", size = "Point Size is Arbitrary", shape = "99 Categories of Confusion") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5),  # Hard-to-read x-axis
        legend.position = "top",  # Puts a gigantic legend at the top
        plot.title = element_text(size = 20, face = "bold")) + 
  facet_wrap(~Category)  # Unnecessary facets for extra chaos

library(ggplot2)
small_ugly_data <- read.csv("Small_Ugly_Dataset.csv")  # Adjust if needed

p1 <- ggplot(small_ugly_data, aes(x = X1, y = X2, color = Category, shape = as.factor(X3), size = X3)) +
  geom_point(alpha = 1) +
  scale_color_manual(values = c("grey", "lightgrey", "darkgrey")) +  # Random bright colors
  scale_size(range = c(10, 30)) +  # Oversized points for no reason
  xlim(-50, 200) +  # Meaningless axis limits
  ylim(-50, 200) +
  labs(title = "Damn good plot", 
       x = "Some Stuff", 
       y = "Some other stuff", 
       color = "Useless Legend", 
       size = "Size Means Nothing") +
  theme_classic(base_size = 6) +
  facet_wrap(~Category) +
  theme(legend.position = "none",  # **Remove the legend**
        axis.title = element_text(color = "purple"),  # Purple axis labels
        axis.text = element_text(color = "darkorange"),  # Orange axis values
        plot.title = element_text(color = "red", face = "bold", size = 18),  # Red bold title
        strip.text = element_text(color = "blue", face = "italic")) +  # Blue italic facet labels
  annotate("text", x = 50, y = 150, label = "jUnK", color = "darkgrey", size = 10) 

ggbackground(p1, image_path)

  