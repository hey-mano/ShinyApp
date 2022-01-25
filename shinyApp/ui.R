library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(ggsci)

# Define UI for application
shinyUI(fluidPage(
    
    headerPanel("Star Wars Data Explorer:"),
    sidebarPanel(
        
        sliderInput("height_slide",
                    "Height Slider Filter: Filters height data used to train the
                    mass prediction model as well as the ouput of the plot",
                    min = 50,
                    max = 275,
                    value = c(50,275)),
        
        sliderInput("mass_slide",
                    "Mass Slider Filter: Filters mass data used to train the mass
                    prediction model as well as the output of the plot",
                    min = 30,
                    max = 160,
                    value = c(30,160)),
        
        numericInput("height_input",
                     "Height Input for Mass Prediction: Insert height to predict
                     the mass of an individual",
                     value = 180),

        checkboxGroupInput('species_input', 
                           'Species Filter: The model will be trained on filterd species and the plot will change
                           according to the filtered species chosen',
                           c("Human","Droid","Gungan","Kaminoan","Mirialan","Twi'lek","Wookiee"),
                           selected = c("Human","Droid","Gungan","Kaminoan","Mirialan","Twi'lek","Wookiee")),
        
        selectInput('colour', 'Variable to colour points', choices = c("gender","species"), selected = "species"),
        width = 3),
    
    h3("Predicted Mass according to chosen height: "),
    textOutput("pred"),
    
    mainPanel(
        plotlyOutput('trendPlot', height = "900px",width = "900px")
    )
))
