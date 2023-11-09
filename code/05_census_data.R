# step04 census data

## please be sure to run code in the api.R script prior to beginning analysis
### The api.R script can be found here: https://github.com/quant-shop/fatalv2/blob/main/api.R

# creating function to generate data sets by year
df.year <- function(yyyy){
  df1 %>% filter(year == yyyy)
}


pm <- function(yyyy){
  glm(deaths ~ black_pov, family = "poisson", data = df.yyyy)
}

pm(2015)