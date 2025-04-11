library(shiny)
library(DT)
library(dplyr)
library(ggplot2)
library(shinythemes)

fatal <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv")

# Convert date to year for plotting purposes
fatal$year <- format(as.Date(fatal$date), "%Y")

ui <- fluidPage(theme = shinytheme("flatly"),
                titlePanel("Fatal Police Interactions"),
                
                sidebarLayout(
                  sidebarPanel(
                    # Crosstab Inputs
                    conditionalPanel(
                      condition = "input.tabselected == 1",
                      selectInput("row_var", "Row Variable:", choices = names(fatal), selected = "race"),
                      selectInput("col_var", "Column Variable:", choices = names(fatal), selected = "gender"),
                      checkboxInput("show_props", "Show Row Proportions", FALSE)
                    ),
                    
                    # ggplot Inputs
                    conditionalPanel(
                      condition = "input.tabselected == 2",
                      selectInput("plot_type", "Plot Type:",
                                  choices = c("Bar Chart", "Scatter Plot")),
                      
                      # Variables for plots
                      selectInput("x_var", "X Variable:", choices = names(fatal), selected = "year"),
                      selectInput("y_var", "Y Variable:", choices = names(fatal), selected = "age")
                    )
                  ),
                  
                  mainPanel(
                    tabsetPanel(
                      id = "tabselected",
                      tabPanel("Crosstab", value = 1, DT::dataTableOutput("crosstab")),
                      tabPanel("ggplot", value = 2, plotOutput("ggplot_plot"))
                    )
                  )
                )
)

server <- function(input, output) {
  
  output$crosstab <- DT::renderDataTable({
    row_var <- input$row_var
    col_var <- input$col_var
    
    cross_tab <- table(fatal[[row_var]], fatal[[col_var]])
    
    if (input$show_props) {
      cross_tab <- prop.table(cross_tab, margin = 1)
    }
    
    as.data.frame.matrix(cross_tab)
  })
  
  output$ggplot_plot <- renderPlot({
    x_var <- input$x_var
    y_var <- input$y_var
    
    if (input$plot_type == "Bar Chart") {
      ggplot(fatal, aes(x = .data[[x_var]])) +
        geom_bar(fill = "skyblue") +
        theme_minimal() +
        labs(title = paste("Bar Chart of", x_var),
             x = x_var,
             y = "Count") +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    } else if (input$plot_type == "Scatter Plot") {
      ggplot(fatal, aes(x = .data[[x_var]], y = .data[[y_var]])) +
        geom_point(color = "steelblue") +
        theme_minimal() +
        labs(title = paste("Scatter Plot of", y_var, "vs.", x_var),
             x = x_var,
             y = y_var)
    }
  })
}

shinyApp(ui = ui, server = server)

