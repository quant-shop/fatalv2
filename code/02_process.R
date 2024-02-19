# step02 process data

## drafted by Nathan Alexander

# install packages
install.packages("tidyverse")
install.packages("tidyr")

# load libraries
library(tidyverse)
library(dplyr)
library(tidyr)

# load and check data
df <- read.csv("data/fatalv2_raw.csv")
df <- as_tibble(df)
df
tail(df) # view the tail of the data
glimpse(df) # get a glimpse of the data
str(df) # view the data structure

# fix vars
# change vars to more appropriate formats
df$date <- as.Date(df$date) # check/change to date format
df$age <- as.numeric(df$age)
df$was_mental_illness_related <- as.logical(df$was_mental_illness_related)
df$body_camera <- as.logical(df$body_camera)
str(df)

# view a summary of the data
summary(df)

# create a two-column transfer df to match state to abb
transfer <- tibble(state = state.name) %>% 
  tibble(abb = state.abb) %>% 
  bind_rows(tibble(state = "District Of Columbia", abb = "DC")) # add DC
transfer
tail(transfer)

# add a state name variable to the fatal df
df$state.name <- state.name[match(df$state, transfer$abb)]
df %>% 
  mutate(state.abb = state) %>% 
  relocate(id, date, state.name, state.abb) -> df
df

# create a year column
# format to 20YY
df.year <- format(df$date, format="20%y") 
df$year <- df.year # add column to df
df$year <- as.numeric(df$year)
df %>% relocate(id, date, year, state.name, state.abb) -> df
df
tail(df)

## write a csv file
write.csv(df, "data/fatalv2_02.csv")
