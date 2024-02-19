# step03 clean data

## drafted by Nathan Alexander

# install packages
install.packages("tidyverse")
install.packages("tidyr")

# load libraries
library(tidyverse)
library(dplyr)
library(tidyr)

# import processed data
df <- read.csv("data/fatalv2_01.csv") %>% 
  select(-X, -X.1) %>% 
  as_tibble()
df

# check for missing values
sapply(df, function(x) sum(is.na(x))) # get a count of missing values

# drop missing values
df %>% 
  drop_na() -> df

# check for missing values; take note of what was dropped; check state.name
sapply(df, function(x) sum(is.na(x))) # get a count of missing values

## write a csv file
write.csv(fatal_03, "data/fatal_clean.csv")
