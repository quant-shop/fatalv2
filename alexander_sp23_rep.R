# goal: replication of spring 2023 analysis using wapo data only
# data: state by year and fatal force data
# author: nathan alexander
# notes: wapo data restricts analysis from 2015 to 2017

# install required packages and load libraries
install.packages("tidyverse")
install.packages("readxl")
library(tidyverse)
library(readxl)
library(dplyr)

# read in data

  # state data
  state <- read_excel("2022-2023/state_race.xlsx")
  state.na <- read_excel("2022-2023/state_race.xlsx", na = "0") # check for missing data==0
  
  # fatal force data
  fatal <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv")
  fatal.na <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv", na = "0") # check for missing data==0

# install package and library to compare data sets
install.packages("diffdf")
library(diffdf) # package to work with differences in dfs

  # identify missing values via differences in two dfs
  diffdf(state, state.na) 
  diffdf(fatal, fatal.na)

# examine state data
state
head(state)
tail(state)
glimpse(state)
str(state)

  # fix vars
  # turn incarcerated_pop from chr to num
  state$incarcerated_pop <- as.numeric(state$incarcerated_pop)
  str(state$incarcerated_pop)

# examine fatal data
fatal
  # turn data into a tibble
  fatal <- as_tibble(fatal)
  fatal
tail(fatal)
glimpse(fatal)
str(fatal)

  # fix vars
  # change vars to appropriate formats
  fatal$date <- as.Date(fatal$date) # check/change to date format
  fatal$age <- as.numeric(fatal$age)
  fatal$was_mental_illness_related <- as.logical(fatal$was_mental_illness_related)
  fatal$body_camera <- as.logical(fatal$body_camera)

str(state)
str(fatal)
summary(state) # view summary of fatal data
summary(fatal) # view summary of state data

# add state.abb and state.names to dfs

  # transform states names to title case in state df
  state$state <- str_to_title(state$state) 
  state

  # create a two-column transfer df to match state to abb
  transfer <- tibble(state = state.name) %>% 
    tibble(abb = state.abb) %>% 
    bind_rows(tibble(state = "District Of Columbia", abb = "DC")) # add DC
  transfer
  tail(transfer)

  # add state abb variable to the state df
  state$abb <- state.abb[match(state$state, transfer$state)]
  state %>% 
    relocate(state, abb, year) %>% 
    replace_na(list(abb = "DC")) -> state
  
  # add state name variable to the fatal df
  fatal$name <- state.name[match(fatal$state, transfer$abb)]
  fatal %>% mutate(abb = state) %>% 
    mutate(state = name) %>% 
    relocate(state, abb) -> fatal

# aggregate fatal data by state and year; fix other things like year

  # format to 20YY
  fatal.year <- format(fatal$date, format="20%y") 
  fatal$year <- fatal.year # add column to df
  fatal %>% relocate(state, abb, year) -> fatal
  fatal

  # get counts by year
  fatal %>% count(year)

  # get counts by state then year
  fatal %>% 
    filter(year==2015 | year==2016 | year==2017) %>% 
    count(state, year)

  # remove years !=2015/16/17
  state.year.fatalities <- fatal %>%
    filter(year==2015 | year==2016 | year==2017) %>% 
    count(state, year) %>% 
    replace_na(list(state = "District Of Columbia"))

  state.year.fatalities
  tail(state.year.fatalities)
  str(state.year.fatalities)
  state.year.fatalities$year <- as.numeric(state.year.fatalities$year)
  str(state.year.fatalities)
  
  #### join state.year.fatalities and state dfs

  # subset state data to three years 2015/16/17 for join
  state.year.join <- state %>% 
    filter(year==2015 | year == 2016 | year == 2017)
  state.year.join

  # join data frames
  df1 <- left_join(state.year.fatalities, state.year.join, by=c('state'='state', 'year'='year'))
  df1
  
  sum(df1$n)
  fatal %>% 
    count(year)

  sum(df1$n) == 995 + 958 + 983 # check to see if values match
  
  df1 <- df1 %>% 
    mutate(deaths = n) %>% 
    relocate(state, abb, year, deaths) %>% 
    select(-n)
  view(df1)

 
# poisson regression
install.packages("ggplot2")
install.packages("msm")
library(ggplot2)
library(msm)

summary(df1)

# creating function to generate data sets by year
df.year <- function(yyyy){
  df1 %>% filter(year == yyyy)
  }

# view resulting data frames
print(df.2015 <- df.year(2015))
print(tail(df.2015 <- df.year(2015)))




df.2016 <- df.year(2016)
df.2017 <- df.year(2017)


pm <- function(yyyy){
  glm(deaths ~ black_pov, family = "poisson", data = df.yyyy)
}

pm(2015)

summary(poi2015 <- glm(deaths ~ black_pov, family = "poisson", data = df.2015))



summary(m2 <- glm(deaths ~ black_pov + incarcerated_pop, family = "poisson", data = df1))
summary(m3 <- glm(deaths ~ black_pov + incarcerated_pop + white_pop, family = "poisson", data = df1))

  
  ###################
  
lm(df1$deaths ~ df1$black_pov)






  # check other counts
df1 %>% count(state)
df1 %>% count(state, year) # count by state

count(df1)
fatal

fatal.counts <- fatal %>% 
  group_by(state, year) %>% 
  summarize(n = n())
fatal.counts
tail(fatal.counts)


fatal %>% 
  group_by(state, year, city) %>% 
  arrange(state, year, city) %>% 
  summarize(n = n())





  # join data




view(fatal)

aggregate(fatal$age,
          by = list(fatal$state),
          FUN = sum,
          na.rm=T)
