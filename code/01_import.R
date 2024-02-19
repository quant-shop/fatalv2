# step01 import data

## drafted by Nathan Alexander

# import the v2 Washington Post fatal force data

### context: https://www.washingtonpost.com/graphics/investigations/police-shootings-database/

### content: https://github.com/washingtonpost/data-police-shootings

### code - v2 data: https://github.com/washingtonpost/data-police-shootings/tree/master/v2

fatalv2 <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv")

## check the imported data
head(fatalv2)
tail(fatalv2)

## write a csv file
write.csv(fatalv2, "data/fatalv2_raw.csv")
