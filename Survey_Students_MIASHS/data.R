library(leaflet)

data <- read.csv2("C:/Users/halim/OneDrive/Documents/Cours/M2/visu/Projet/Visu_Information/results-survey111545.csv", sep = ";", header = TRUE)
data <- data[ , c(1:2,8:24, 26,38:42,46)] 
length(names(data))
names(data)[1]<-"ID_Reponse"
row.names(data)=data$ID_Reponse
data_Nettoyer<-data[,-1]
names(data_Nettoyer) <- c("PROMOTION", "SEXE", "AGE", "LIEU_NAISSANCE", "VILLE_OBTENTION_BAC", "VILLE_OBTENTION_LICENCE", "VILLE_ALTERNANCE", "BAC", "ANNEE_BAC","EXPERIENCE_PRO_AVANT_MASTER",
                          "RAISON_INSCRIPTION_INTERET-DISCIPLINE","RAISON_INSCRIPTION_PROJET-PRECIS" , "RAISON_INSCRIPTION_PROJET-PROFESSIONNEL" , "RAISON_INSCRIPTION_DEBOUCHES",
                          "RAISON_INSCRIPTION_PROXIMITE-ETABLISSEMENT","SECTEUR_ACTIVITE", "TRANCHE_EFFECTIF_ENTREPRISE","APPARENCE_POSTE_OCCUPE","ROLE_ENTREPRISE","CHANCE_INSERTION_PROFESSIONNELLE_REGION-OCCITANIE")
head(data_Nettoyer)


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


# make some fake data
df <- data.frame(
  'level1'=c('a', 'a', 'a', 'a', 'b', 'b', 'c', 'c', 'c'), 
  'level2'=c('a1', 'a2', 'a3', 'a4', 'b1', 'b2', 'c1', 'c2', 'c3'), 
  'value'=c(.025, .05, .027, .005, .012, .014, .1, .03, .18))

# sunburst plot
ggplot(df, aes(y=value)) +
  geom_bar(aes(fill=level1, x=0), width=.5, stat='identity') + 
  geom_bar(aes(fill=level2, x=.25), width=.25, stat='identity') + 
  coord_polar(theta='y')

