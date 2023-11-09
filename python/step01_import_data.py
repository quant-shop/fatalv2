# step01 import data

## import packages
import pandas as pd

## import data
### context: https://www.washingtonpost.com/graphics/investigations/police-shootings-database/
### content: https://github.com/washingtonpost/data-police-shootings
### v2 files: https://github.com/washingtonpost/data-police-shootings/tree/master/v2
url <- "https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv"
fatal_raw = pd.read_csv(url)

df = fatal_raw

## check data
df
df.head()
df.tail()

# show column labels
for col in df.columns:
  print(col)
  
# print columns as keys
print(df.keys)
