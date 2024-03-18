# step04 explore data

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
fatal <- read.csv("data/fatal_clean.csv")

# counts of fatal interactions by year
fatal %>% 
  count(year)


        