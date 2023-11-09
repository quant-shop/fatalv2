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

