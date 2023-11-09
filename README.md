# Fatal Police Interactions

Analysis of [fatal police interactions](https://www.washingtonpost.com/graphics/investigations/police-shootings-database/). 

Base data files come from the [Fatal Force Database](https://github.com/washingtonpost/data-police-shootings) and other sources, such as US Census data. Shared here are public files for the **Community Data Fellowship** research projects at [Howard University](https://howard.edu/) and [Morehouse College](https://howard.edu/).

**Base files**:

* Base files for data processing are stored in the `code` folder.

* `data`

  - All raw data is stored or saved in the `data` folder.
  
  - Data analysis and results are stored in `output` and `report` folders.

**Ancillary files**:

* `api.R` helps new users generate and store a [Census API key](https://api.census.gov/data/key_signup.html).

  - You should never share your Census API key. Follow the steps below:
  
    - Set up an environment variable to hold your api key with `usethis::edit_r_environ()`

    - Transfer information into `.Renviron` (pop-up file) 
    
        - Insert `CENSUS_API_KEY='your_api_key'` into the `.Renviron` file
  
    - Insert your census API key via `Sys.getenv("CENSUS_API_KEY")`

Project leads: Hye Ryeon Jang, PhD; Nathan Alexander, PhD

Contributors: TBA

View project resources (forthcoming) at https://github.com/quant-shop/fatalv2

