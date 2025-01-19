#4. Write a command that lists all the .csv files found in the Data/ directory
#Store that list as csv_files
getwd()
?list.files()
csv_files <- 
  list.files(path = "data", pattern = ".csv", all.files = TRUE, 
             full.names = TRUE, recursive = TRUE)
class(csv_files)

#5. Find how many files match that description using the length() function
#class(csv_files)
length(csv_files)

#other stuff
csv_files[1]
csv_files[1:10]
#combine 
csv_files[c(1,3,5)]
c(1:50, 53,55,57)

c("your", "mom", "is", 100)
y <- c(1,2,3,4,5,"6")
x <- "asdfjkl"
c("your mom is",x)
z <-  as.numeric(c(x,y,100))
mean(z,na.rm = TRUE)

#Practice head()
#Inspect the first 5 lines of this data set using the head() function
?head()
head(csv_files,5)
#list.files() to find relative path to file named Cleaned bird data
#Save as bird"
bird <- 
  list.files(path = "Data",
             recursive=TRUE, 
             pattern = "cleaned_bird_data.csv",
             full.names = TRUE)


#6. Open the wingspan_vs_mass.csv file and store contents as an R object named "df" 
#using read.csv() function
read.csv("wingspan_vs_mass.csv")
getwd()

wingspan_vs_mass <- 
  list.files(path = "Data",
             recursive=TRUE, 
             pattern = "wingspan_vs_mass.csv",
             full.names = TRUE)
df <- read.csv(wingspan_vs_mass)


df$wingspan
df$mass
plot(df$wingspan, df$mass)
class(dat)
dim(dat)
big_span <- df$wingspan >30
plot(big_span,df$mass)
big_span$dfvariety


# Practice Example
dat <- read.csv(bird)
class(dat)
dim(dat)
#rows 1,3,5 of dat
dat[c(1,3,5),]
#show just column called "egg mass"
dat[,"Egg_mass"]
#below does the same thing
dat$Egg_mass
keepers <- dat$Egg_mass > 10
big_egg_mamas <- dat[keepers,]
#find missing data
is.na(dat$Egg_mass)
#subset keep greater than 10 AND is not N/A
big_egg_mamas <- dat[dat$Egg_mass >10 & !is.na(dat$Egg_mass),]
#! means not equal to 
4 !=4
plot(big_egg_mamas$Egg_mass)
plot (density(big_egg_mamas$Egg_mass))

summary(big_egg_mamas$Egg_mass)

str(dat)
summary(dat$mass)
summary(dat$tarsus)

big_mass_buddies <- 
  dat$mass > median(dat$mass,na.rm = TRUE) &
  dat$tarsus > median(dat$tarsus, na.rm = TRUE)

dat[big_mass_buddies,]

plot(dat[big_mass_buddies, "Egg_mass"])
file.remove("./cleaned_bird_data.csv")
file.remove("./Assignment_2.R")

#7. Inspect the first 5 lines of this data set using the head() function
head(df,5)

#8. Find any files (recursively) in the Data/ directory that begin with the letter "b"
# ^ (shift +6) = "starts with"
list.files(path = "Data",
           recursive=TRUE, 
           pattern = "^b")

#9. Write a command that displays the first line of each of those "b" files
#full.names is important for reading
b_files <- 
  list.files(path = "Data", recursive = TRUE, pattern = "^b", full.names = TRUE)
#Loop through each "b_file" and show first line
# Find all "b" files with full paths
b_files <- list.files(path = "Data", recursive = TRUE, pattern = "^b", full.names = TRUE)

# Loop through each "b" file and display the first line
for (file in b_files) {
  # Read the first line of the current file
  first_line <- tryCatch(
    readLines(file, n = 1),
    error = function(e) "Not a readable text file"
  )
  
  # Display the file name and its first line
  cat("File:", file, "\nFirst Line:", first_line, "\n\n")
}

#10. Do the same thing for all files that end in ".csv"
csv_files <- 
  list.files(path = "data", pattern = ".csv", all.files = TRUE, 
             full.names = TRUE, recursive = TRUE)
# Loop through each ".csv" file and display the first line
for (file in csv_files) {
  # Read the first line of the current file
  first_line <- tryCatch(
    readLines(file, n = 1),
    error = function(e) "Not a readable text file"
  )
  
  # Display the file name and its first line
  cat("File:", file, "\nFirst Line:", first_line, "\n\n")
}