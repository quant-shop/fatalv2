# step05 census data

## please be sure to run code in the api.R script at least once prior to beginning extraction
### The api.R script can be found here: https://github.com/quant-shop/fatalv2/blob/main/api.R
### by running the api.R script, you will load your census API key

# loading variables
var1 <- load_variables(2020, "acs5") %>% 
  filter(name=="B19013B_001")
var1

# Median Income of African American Household in 2020 
var1.values <- get_acs(geography = "state",
                             variables = "B19013B_001",
                             year = 2020)
var1.values %>% 
  left_join(var1,
            by = c("variable" = "name")) %>% 
  mutate(year = 2020)

