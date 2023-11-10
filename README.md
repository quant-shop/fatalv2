## FATAL: A Study of Fatal Police Interactions in the US

Analysis of [fatal police interactions](https://www.washingtonpost.com/graphics/investigations/police-shootings-database/). This repository contains some of the base modifications used by our lab. Visitors are welcome to examine and utilize the integration components outlined to help prepare for further analysis. Base data files come from the [Fatal Force Database](https://github.com/washingtonpost/data-police-shootings) and many other sources; here we share integrations with US Census data using [tidycensus](https://walker-data.com/tidycensus/). Shared here are public files for the **Community Data Fellowship** research projects at [Howard University](https://howard.edu/) and [Morehouse College](https://morehouse.edu/) conducted in spring 2023 and fall 2023.

Funding for this project was provided by [Data.org](https://data.org/) in collaboration with the [The University of Chicago Data Science Institute](https://datascience.uchicago.edu/) as a part of the Institute's [Capacity Accelerator Network](https://datascience.uchicago.edu/outreach/capacity-accelerator-network/).

**Base files**:

* Base files for data processing are stored in the `code` folder.

* `data`

  - All raw data is stored or saved in the `data` folder.
  
  - Data analysis and results are stored in `output` and `reports` folders.

* **Python scripts** are located in the `python` folder.

**Ancillary files**:

* `api.R` helps new users generate and store a [Census API key](https://api.census.gov/data/key_signup.html).

  - You should never share your Census API key. Follow the steps below:
  
    - Set up an environment variable to hold your api key with `usethis::edit_r_environ()`

    - Transfer information into `.Renviron` (pop-up file) 
    
        - Insert `CENSUS_API_KEY='your_api_key'` into the `.Renviron` file
  
    - Insert your census API key via `Sys.getenv("CENSUS_API_KEY")`

View project resources (forthcoming) at https://github.com/quant-shop/fatalv2

