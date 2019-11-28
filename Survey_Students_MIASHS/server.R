#### Baco-Mahadali Youssouf, Abdou Anlimou, Taha Elkarafli

# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
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

data <- read.csv2("C:/Users/halim/OneDrive/Documents/Cours/M2/visu/Projet/Visu_Information/results-survey111545.csv", sep = ";", header = TRUE)
data <- data[ , c(1:2,8:24, 26,38:42,46)] 
length(names(data))
names(data)[1]<-"ID_Reponse"
row.names(data)=data$ID_Reponse
data_Nettoyer<-data[,-1]
names(data_Nettoyer) <- c("PROMOTION", "SEXE", "AGE", "LIEU_NAISSANCE", "VILLE_OBTENTION_BAC", "VILLE_OBTENTION_LICENCE", "VILLE_ALTERNANCE", "BAC", "ANNEE_BAC","EXPERIENCE_PRO_AVANT_MASTER",
                          "RAISON_INSCRIPTION_INTERET-DISCIPLINE","RAISON_INSCRIPTION_PROJET-PRECIS" , "RAISON_INSCRIPTION_PROJET-PROFESSIONNEL" , "RAISON_INSCRIPTION_DEBOUCHES",
                          "RAISON_INSCRIPTION_PROXIMITE-ETABLISSEMENT","SECTEUR_ACTIVITE", "TRANCHE_EFFECTIF_ENTREPRISE","APPARENCE_POSTE_OCCUPE","ROLE_ENTREPRISE","CHANCE_INSERTION_PROFESSIONNELLE_REGION-OCCITANIE")

lat=function(x){ if(typeof(x) == "character") { as.numeric(sub(";.*","",x))  } else {0}   }
long=function(x){ if(typeof(x)=="character") { as.numeric(sub(".*;","",x))  } else{0}}

data_Nettoyer$BAC_LONG= apply(data_Nettoyer,1,FUN=function(x){ long(x["VILLE_OBTENTION_BAC"] )})
data_Nettoyer$BAC_LAT= apply(data_Nettoyer,1,FUN=function(x){ lat(x["VILLE_OBTENTION_BAC"] )})

data_Nettoyer$LICENCE_LONG= apply(data_Nettoyer,1,FUN=function(x){ long(x["VILLE_OBTENTION_LICENCE"] )})
data_Nettoyer$LICENCE_LAT= apply(data_Nettoyer,1,FUN=function(x){ lat(x["VILLE_OBTENTION_LICENCE"] )})

data_Nettoyer$ALTERNANCE_LONG= apply(data_Nettoyer,1,FUN=function(x){ long(x["VILLE_ALTERNANCE"] )})
data_Nettoyer$ALTERNANCE_LAT= apply(data_Nettoyer,1,FUN=function(x){  lat(x["VILLE_ALTERNANCE"] )})


leaflet(data = data_Nettoyer) %>% addTiles() %>%
  addMarkers(~ALTERNANCE_LONG, ~ALTERNANCE_LAT)

corpus <- Corpus(VectorSource(data_Nettoyer$"RAISON_INSCRIPTION_PROJET-PRECIS"))

corpus <- tm_map(corpus, removePunctuation)

tdm <-TermDocumentMatrix(corpus, control=list(wordLengths=c(1,Inf)))
freq <- slam::row_sums(tdm)
words <- names(freq)    

##wordcloud(words, freq, min.freq=1)

# Define server logic required to draw a histogram


shinyServer(function(input, output) {
  
  data <- reactive({rnorm(input$num)})
  
                 
  
  output$hist <- renderPlot({
    ggplot(data_Nettoyer, 
           aes(
             x= switch(
             input$col,
             "Sexe" = SEXE,
             "Promotion" = PROMOTION
             )
             )
           )+
      geom_bar()+
      xlab(input$col)
      })
  
  output$carte <- renderLeaflet({
    leaflet(data = data_Nettoyer) %>%
      addTiles() %>%
      setView(lng = 3.876716, lat = 43.610769, zoom = 1) %>% 
      addAwesomeMarkers(~BAC_LONG, ~BAC_LAT,
                 clusterOptions = markerClusterOptions())
  })
  
  #output$stats <- renderPrint({
    #summary( rnorm( data() ) )
   # })
    
  }
)

