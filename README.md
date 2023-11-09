# fatalv2

Analysis of [fatal police interactions](https://www.washingtonpost.com/graphics/investigations/police-shootings-database/).

Public files for **Morehouse Community Data Fellowship** research project.

View project resources at https://github.com/quant-shop/fatalv2

Ancillary files:

* `api.R` helps new users generate a [Census API key](https://api.census.gov/data/key_signup.html).

  - You should never share your Census API key. Follow the three steps below:
  
    - Set up an environment variable to hold your census api key with `usethis::edit_r_environ()`

    - Transfer information into your `.Renviron` by inserting `CENSUS_API_KEY='your_api_key'` into the file
  
    - Insert your census API key via `Sys.getenv("CENSUS_API_KEY")`
