#4. Write a command that lists all the .csv files found in the Data/ directory
#Store that list as csv_files
getwd()
csv_files <- 
list.files(path = "data", pattern = ".csv", all.files = TRUE, 
           full.names = TRUE, recursive = TRUE)
class(csv_files)

#5. Find how many files match that description using the length() function
#class(csv_files)
length(csv_files)

#6. Open the wingspan_vs_mass.csv file and store contents as an R object named "df" 
#using read.csv() function
wingspan_vs_mass <- 
list.files(path = "Data",
           recursive=TRUE, 
           pattern = "wingspan_vs_mass.csv",
           full.names = TRUE)
df <- read.csv(wingspan_vs_mass)

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
