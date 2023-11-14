library(shiny)
library(tidyverse)

# server
# Data pre-processing ----

# import data
df <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv")

# change vars to more appropriate formats
df$date <- as.Date(df$date) # check/change to date format
df$age <- as.numeric(df$age)
df$was_mental_illness_related <- as.logical(df$was_mental_illness_related)
df$body_camera <- as.logical(df$body_camera)

# create a two-column transfer df to match state to abb
transfer <- tibble(state = state.name) %>% 
  tibble(abb = state.abb) %>% 
  bind_rows(tibble(state = "District Of Columbia", abb = "DC")) # add DC
transfer

# add a state name variable to the fatal df
df$state.name <- state.name[match(df$state, transfer$abb)]
df %>% 
  mutate(state.abb = state) %>% 
  relocate(id, date, state.name, state.abb) -> df
df

# create a year column
# format to 20YY
df.year <- format(df$date, format="20%y") 
df$year <- df.year # add column to df
df %>% relocate(id, date, year, state.name, state.abb) -> df

# drop missing values
df %>% 
  drop_na() -> df

# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste("age ~", input$variable)
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against mpg ----
  # and only exclude outliers if requested
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = df,
            outline = input$outliers,
            col = "#007bc2", pch = 19)
  })
  
}

# Define UI for fatalaties per year ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Fatalaties Per Year"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(
    
    # Input: Selector for variable to plot against mpg ----
    selectInput("variable", "Variable:", 
                c("Year" = "year",
                  "State" = "state",
                  "Race" = "race")),
    
    # Input: Checkbox for whether outliers should be included ----
    checkboxInput("outliers", "Show outliers", TRUE)
    
  ),
  
  # Main panel for displaying outputs ----
  mainPanel()
)

# Define UI for miles per gallon app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Fatalatites Per Year"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for variable to plot against mpg ----
      selectInput("variable", "Variable:", 
                  c("Year" = "year",
                    "State" = "state",
                    "Race" = "race")),
      
      # Input: Checkbox for whether outliers should be included ----
      checkboxInput("outliers", "Show outliers", TRUE)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Formatted text for caption ----
      h3(textOutput("caption")),
      
      # Output: Plot of the requested variable against mpg ----
      plotOutput("Fatalaties Per Year")
      
    )
  )
)
shinyApp(ui, server)
