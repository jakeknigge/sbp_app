library(shiny)
library(rmarkdown)
library(markdown)

# Define UI for dataset viewer application
shinyUI(fluidPage(
      # Application title
      titlePanel("Stick breaking process"),
      
      # Plot the discrete random measure
      h3("Random measure obtained from SBP."),
      plotOutput("sbpPlot"),
      
      # Horizontal page break
      hr(),
      
      # Display parameter choices in three columns
      fluidRow(
            column(3,
                   h4("Stick breaking controls."),
                   # Select the number of stick breaking atoms
                   selectInput(inputId = "n",
                               label = "Number of atoms:",
                               choices = c(10, 25, 100, 250, 1000, 2500),
                               selected = 250),
                   
                   # Select the stick-breaking concentration parameter
                   sliderInput(inputId = "alpha", 
                               label = "Concentration parameter (alpha):", 
                               min = 1, max = 30, value = 10, step = 0.5)
            ),
            # Select a base distribution from the drop-down list
            column(4, offset = 1,
                   h4("Base measure controls."),
                   selectInput(inputId = "baseMeasure", 
                               label = "Choose a base distribution:", 
                               choices = c("normal", 
                                           "gamma", 
                                           "beta",
                                           "cauchy"),
                               selected = "normal"),
                   # Specify "location" parameters
                   uiOutput("ui_param_1"),
                   # Specify "scale" parameters
                   uiOutput("ui_param_2")
            ),
            column(4,  
                   # Show a summary of the dataset and an HTML table with the 
                   # requested number of observations
                   h4("Some output statistics."),
                   tableOutput("summary")
            )
      ),
      
      # Horizontal page break
      hr(),
      
      # Include markdown SBP tutorial
      includeMarkdown("sbp.Rmd")
))
