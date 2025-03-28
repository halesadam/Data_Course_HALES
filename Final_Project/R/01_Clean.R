# Cleaning

## Setup
library(dplyr)
library(tidyr)
library(tidyverse)
library(skimr)

#read in Data/Updated_DSR.csv
df <- read.csv("./Data/Updated_DSR.csv")

#take out that first row of dates
df <- df %>% 
  slice(-1)

View(df)

#lengthen data to make column named Block and DSR
df_long <- df %>% 
  pivot_longer(
    cols = starts_with("B"),
    names_to = "Block",
    values_to = "DSR"
  )

#create new column called "Season". 
#assign 1 for B1:B3.1
df_long <- df_long %>% 
  mutate(Season = ifelse(Block %in% c("B1", "B2", "B3", "B1.1", "B2.1", "B3.1"), 1, 2)) %>% 
  mutate(Season = as.factor(Season)) %>% #make growing season into a factor
  relocate(Season, .after = X) %>% 
  rename(Accession_ID = X) 

#assign the "B1.1" etc to a replicate - that's essentially what they are
df_long <- df_long %>% 
  mutate(Rep = case_when(
    Block %in% c("B1", "B2", "B3") ~ "1",
    Block %in% c("B1.1", "B2.1", "B3.1") ~ "2",
    Block %in% c("B1.2", "B2.2", "B3.2") ~ "3",
    Block %in% c("B1.3", "B2.3", "B3.3") ~ "4",
    Block %in% c("B1.4", "B2.4", "B3.4") ~ "5",
  ))

#now let's get rid of the .whatever in the Block column
df_long <- df_long %>%
  mutate(Block = sub("\\..*", "", Block))

#now let's relocate the rep column
df_long <- df_long %>% 
  relocate(Rep, .after = Block)

#remove B prefix in Block
df_long$Block <- gsub("^B", "", df_long$Block)

#change DSR to an integer, Rep to factor, Block to factor
df_long <- df_long %>% 
  mutate(DSR = as.integer(DSR)) %>% 
  mutate(Rep = as.factor(Rep)) %>% 
  mutate(Block = as.factor(Block)) %>% 
  mutate(DSR = ifelse(DSR == 16, NA_integer_, DSR))

#look over df_long for problems
skim(data = df_long)

#Make a cleaned csv
write_csv(df_long, "./Data/cleaned_DSR.csv")

#now that DSR is cleaned, let's import and tidy the origin sheet
#this shows, ID, Accession Number, Origin, and Species


#Import Origin_sheet
origin_df <- read_csv("./Data/Origin_Sheet.csv")

View(origin_df)

#rename ID
origin_df <- origin_df %>% 
  rename(ID = 'ID #') 

#remove"S24-" prefix from the ID column
origin_df$ID <- str_replace(origin_df$ID, "^S24-", "")

#remove Brassica prefix from species column
origin_df$Species <- str_replace(origin_df$Species, "^Brassica ","")

#drop accession column, not necessary for this - only useful for book keeping
origin_df <- origin_df %>% 
  select(-Accession)

#save cleaned origin data set
write.csv(origin_df, "./Data/cleaned_origin_sheet.csv", row.names = FALSE)


#combine the two 
#read in the two
df_origin <- read.csv("./Data/cleaned_origin_sheet.csv", stringsAsFactors = FALSE)
df_dsr <- read.csv("./Data/cleaned_DSR.csv", stringsAsFactors = FALSE)

# Convert ID columns to the same type (character)
df_origin$ID <- as.character(df_origin$ID)
df_dsr$Accession_ID <- as.character(df_dsr$Accession_ID)

#merge the two
df_merged <- df_dsr %>%
  left_join(df_origin, by = c("Accession_ID" = "ID"))

#check up to see how it looks
glimpse(df_merged)

#neeed to set origin and species to factors - leave accession as character
df_merged$Origin <- as.factor(df_merged$Origin)
df_merged$Species <- as.factor(df_merged$Species)

#save the merged data set
write.csv(df_merged, "./Data/Merged_DSR_Origin_Dataset.csv", row.names = FALSE)


