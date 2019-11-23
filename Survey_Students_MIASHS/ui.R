#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(leaflet)
library(r2d3)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sliderInput( inputId = "num"
                 ,label = "Choose a number" 
                 ,value = 25
                 ,min = 1
                 ,max = 100
                )
  , plotOutput("hist")
    )
  )

