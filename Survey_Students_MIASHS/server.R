#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#library(rsconnect)
#rsconnect::deployApp('C:/Users/halim/OneDrive/Documents/Cours/M2/visu/Projet/Visu_Information/Survey_Students_MIASHS/rsconnect/shinyapps.io/visupromomiash')
library(ggplot2)
library(leaflet)
library(r2d3)
library(shiny)

data <- read.csv2("./../results-survey111545.csv", sep = ";", header = TRUE)
data <- data[ , c(1:2,8:24, 26,38:42,46)] 
length(names(data))
names(data)[1]<-"ID_Reponse"
row.names(data)=data$ID_Reponse
data_Nettoyer<-data[,-1]
names(data_Nettoyer) <- c("PROMOTION", "SEXE", "AGE", "LIEU_NAISSANCE", "VILLE_OBTENTION_BAC", "VILLE_OBTENTION_LICENCE", "VILLE_ALTERNANCE", "BAC", "ANNEE_BAC","EXPERIENCE_PRO_AVANT_MASTER",
                          "RAISON_INSCRIPTION_INTERET-DISCIPLINE","RAISON_INSCRIPTION_PROJET-PRECIS" , "RAISON_INSCRIPTION_PROJET-PROFESSIONNEL" , "RAISON_INSCRIPTION_DEBOUCHES",
                          "RAISON_INSCRIPTION_PROXIMITE-ETABLISSEMENT","SECTEUR_ACTIVITE", "TRANCHE_EFFECTIF_ENTREPRISE","APPARENCE_POSTE_OCCUPE","ROLE_ENTREPRISE","CHANCE_INSERTION_PROFESSIONNELLE_REGION-OCCITANIE")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  data <- reactive({rnorm(input$num)})
  
  output$hist <- renderPlot({
    ggplot(data_Nettoyer, aes(x=data_Nettoyer[,input$col]))+
      geom_bar()
      })
  
  output$stats <- renderPrint({
    summary( rnorm( data() ) )
    })
    
  }
)
