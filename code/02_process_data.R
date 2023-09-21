# step02 process data

# install required packages and load libraries
install.packages("tidyverse")
library(tidyverse)

# load and check data
df <- read.csv("data/fatal_raw.csv")
df <- as_tibble(df)
df

# remove first column
df <- df %>% 
  select(-c(1))
df
