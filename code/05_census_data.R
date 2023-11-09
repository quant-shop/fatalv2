# step05 census data

## please be sure to run code in the api.R script at least once prior to beginning extraction
### The api.R script can be found here: https://github.com/quant-shop/fatalv2/blob/main/api.R
### by running the api.R script, you will load your census API key

# install packages / un-comment where needed
# install.packages("tidycensus")
# install.packages("tidyverse")
# install.packages("tidyr")

# load libraries
library(tidycensus)
library(tidyverse)
library(tidyselect)
library(dplyr)
library(tidyr)
library(stringr)

# load all variable labels for a specific year
labels <- function(yyyy){
  load_variables(yyyy, "acs5")
}
labels(2020) -> labels
labels

# create years vector
years <- data.frame(years = 2013:2021)
years

for (i in 2013:2021){
  print(i)
}

yearz = labels(for (i in 2013:2021){
  print(i)
})
yearz


# select all variables with the same root string
varlist = data.frame(variable=vars_select(labels$name, starts_with('B01001A')))
varlist

# extract information from labels
varlist1 <- labels %>% 
  separate(label, c("l-pos1", 
                    "l-pos2", 
                    "l-pos3", 
                    "l-pos4", 
                    "l-pos5", 
                    "l-pos6", 
                    "l-pos7")) %>% 
  select(-"l-pos1")
varlist1


# loading variable
var1 <- load_variables(2020, "acs5") %>% 
  filter(name=="B01001A_001")
var1

var.values <- get_acs(geography = "state",
                      variables = varlist,
                      year = 2020)

# sex by age (White alone) in the year 2020
var1.values <- get_acs(geography = "state",
                       variables = "B01001A_001",
                       year = 2020)

# extract information from labels
varlist[c("Label Head", "Label Tail")] <- str_split_i(varlist$label, '!!Total', 2)

varlist1 <- varlist %>% separate(label, c("l-pos1", "l-pos2", "l-pos3", "l-pos4", "l-pos5", "l-pos6", "l-pos7"))

# join data frames
var1.values %>% 
  left_join(var1,
            by = c("variable" = "name")) %>% 
  mutate(year = 2020)


