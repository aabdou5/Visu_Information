#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#library(rsconnect)
#rsconnect::deployApp('C:/Users/halim/OneDrive/Documents/Cours/M2/visu/Projet/Visu_Information/Survey_Students_MIASHS/rsconnect/shinyapps.io/visupromomiash')
library(tm)
library(wordcloud)
library(SnowballC)
library(RColorBrewer)
library(ggplot2)
library(leaflet)
library(r2d3)
library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Projet Visualisation"),
  # Sidebar with a slider input for number of bins 
  
  sliderInput( inputId = "num",
                 label = "Choose a number" ,
                 value = 25,
                 min = 1,
                 max = 100
                ),
  
  h3("La répartition des sexes selon les promotions"),
  
  selectInput(inputId="col", 
              label = "Choose a variable to display",
              choices = c("Sexe", "Promotion"
                          ),
              selected = "Promotion"
              ),
  
  
  #textInput(inputId = "txt",
   #         label ="Write a title"),  
  
  plotOutput("hist", width = 400, height = 400),
  
  h3("Où vont les MIASHS vont en période d'alternance ?"),
  
  leafletOutput("carte", width = 400, height = 400)
  
  #verbatimTextOutput("stat")
    )
  )

