# import the data
fatal_raw <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv")

# write the csv file
write.csv(fatal_raw, "/Users/nathanalexander/Dropbox/Projects/fatalv2/data/fatal_raw.csv")
