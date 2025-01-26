#make a vector
melons <- c(3.4,3.1,3,5)
melons[1]
melons[4]

#there was a problem with the melons...they are only half the weight 
melons/2

#can sum vector
adjusted_weight <-  melons + c(0.4, 0.2, 0.4, 0.3)

plot(melons, adjusted_weight)
sum(melons)
plot(mean(melons) ~ mean(adjusted_weight))

#comparisons
#which melons weigh more than 4 kg
melons>4
#which weigh exactly 3 kg
melons==3
ggplot(melons, adjusted_weight)
plot(melons, adjusted_weight)

#using R as a calculator
1+1
2+5

brassica_DSR_b1 <- c(1,2,3,4,5,5,6,8,10)
brassica_ID <- c(22,34,45,23,45,231,54,89,101)
mean(brassica_DSR_b1)
plot(brassica_DSR_b1)
plot(brassica_DSR_b1, brassica_ID)
getwd()
data.frame(adjusted_weight)
nrow()

file_path <- "C:/Users/adamhales/Desktop/Data_Course_HALES/Data/1620_scores.csv"
BIO_2 <- read.csv("C:/Users/adamhales/Desktop/Data_Course_HALES/Data/1620_scores.csv")
list.files(path="data")
