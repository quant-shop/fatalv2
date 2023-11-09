# step04_01 exploratory data analysis - by year

# install packages
install.packages("tidyverse")
install.packages("tidyr")
install.packages("ggplot2")

# load libraries
library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)

## load cleaned data
df <- read.csv("data/fatal_clean.csv")

# get a count of fatal interactions by year
df %>% 
  count(year)

# creating bar graphs of fatal encounters ...

barplot(table(df$year)) # by year

# build base plot
base <- ggplot(df, aes(year))

base + geom_bar()


ggplot(df, aes(year, fill = body_camera)) + geom_bar(stat="count", position = "dodge") # body camera
ggplot(df, aes(year, fill = was_mental_illness_related)) + geom_bar(stat="count", position = "dodge") # mental illness
ggplot(df, aes(year, fill = gender)) + geom_bar(stat="count", position = "dodge") # gender
ggplot(df, aes(year, fill = race)) + geom_bar(stat="count", position = "dodge") # race
ggplot(df, aes(year, fill = age)) + geom_bar(stat="avg", position = "dodge") # age




        