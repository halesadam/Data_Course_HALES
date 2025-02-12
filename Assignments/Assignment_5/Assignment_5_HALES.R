#Assignment 5, Ugly Plot Contest
library(ggplot2)
library(ggimage)

image_path <- "https://i1.sndcdn.com/artworks-000338100936-kt6c6s-t500x500.jpg"

small_ugly_data <- read.csv("Small_Ugly_Dataset_copy.csv")

p1 <- ggplot(small_ugly_data, aes(x = X1, y = X2, color = Category, shape = as.factor(X3), size = X3)) +
  geom_point(alpha = 1) +
  scale_color_manual(values = c("grey", "lightgrey", "darkgrey")) +  
  scale_size(range = c(10, 30)) +  
  xlim(-50, 200) +  
  ylim(-50, 200) +
  labs(title = "Damn good plot", 
       x = "Some Stuff", 
       y = "Some other stuff", 
       color = "Useless Legend", 
       size = "Size Means Nothing") +
  theme_classic(base_size = 6) +
  facet_wrap(~Category) +
  theme(legend.position = "none",  
        axis.title = element_text(color = "purple"),  
        axis.text = element_text(color = "darkorange"),  
        plot.title = element_text(color = "red", face = "bold", size = 18),  
        strip.text = element_text(color = "blue", face = "italic")) +  
  annotate("text", x = 50, y = 150, label = "jUnK", color = "darkgrey", size = 10) 

ggbackground(p1, image_path)
