# step01 import data

## import the v2 washington post fatal force data

### context: https://www.washingtonpost.com/graphics/investigations/police-shootings-database/
### content: https://github.com/washingtonpost/data-police-shootings
### v2 files: https://github.com/washingtonpost/data-police-shootings/tree/master/v2

fatal_raw <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv")

## check the imported data
head(fatal_raw)
tail(fatal_raw)

## write a csv file
write.csv(fatal_raw, "data/fatal_raw.csv")

## import the 
