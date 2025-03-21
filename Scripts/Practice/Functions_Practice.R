#Functions####
library(tidyverse)

#syntax for writing a simple function
#create a function that converts Celcius to Farenheit
c_to_f <- function(celcius){
  (9/5)*celcius + 32
}

#practice doing the same in reverse, f to c
f_to_c <- function(farenheit){
  (5/9)*(farenheit - 32)
}
  
#now let's test it out
c_to_f(100)
c_to_f(32)
f_to_c(90)

#this is a little more complex
c_to_f <- function(celsius, freezing = 32){
  multiplication <- 9/5*celsius
  f <- multiplication + freezing
  return(f)
}

#write a function that takes numeric vector and returns the minimum, maximum and mean 
summarize_stats <- function(x){
  result <- list(
    min = min(x),
    max = max(x),
    mean = mean(x)
  )
  return(result)
}

#build a function that takes a df and returns a new df with a random column removed
remove_random_column <- function(df){
  if(!is.data.frame(df)){
    stop("Input must be a dataframe") #build in a stop
  }
  
  if(ncol(df)<1){
    stop("Dataframe has no columns to remove") #another stop
  }
  
  col_removed <- sample(ncol(df),1) #sample a random column 
  
  new_df <- df[,-col_removed] #remove that column
  
  return(new_df)
}  

#try it out
iris.rm <- remove_random_column(iris)
iris  

iris %>% ncol()  
iris.rm %>% ncol()

#building my own function
unique_random <- function(nrow, ncol, min, max) {
  total_needed <- nrow * ncol
  total_available <- max - min + 1
  
  # Check if it's possible
  if (total_needed != total_available) {
    stop("Number of matrix elements must equal the number of unique integers between min and max.")
  }
  
  # Generate and shuffle the numbers
  values <- sample(min:max)  # shuffled sequence of all unique values
  
  # Reshape into matrix
  result_matrix <- matrix(values, nrow = nrow, ncol = ncol)
  
  return(result_matrix)
}
random_196 <- unique_random(nrow = 14, ncol = 14, min = 1, max = 196) 

















