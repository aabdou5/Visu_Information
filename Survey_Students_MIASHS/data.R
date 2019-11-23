data <- read.csv2("results-survey111545.csv", sep = ";", header = TRUE)
data <- data[ , c(1:2,8:24, 26,38:42,46)] 
length(names(data))
names(data)[1]<-"ID_Reponse"
row.names(data)=data$ID_Reponse
data_Nettoyer<-data[,-1]
names(data_Nettoyer) <- c("PROMOTION", "SEXE", "AGE", "LIEU_NAISSANCE", "VILLE_OBTENTION_BAC", "VILLE_OBTENTION_LICENCE", "VILLE_ALTERNANCE", "BAC", "ANNEE_BAC","EXPERIENCE_PRO_AVANT_MASTER",
                          "RAISON_INSCRIPTION_INTERET-DISCIPLINE","RAISON_INSCRIPTION_PROJET-PRECIS" , "RAISON_INSCRIPTION_PROJET-PROFESSIONNEL" , "RAISON_INSCRIPTION_DEBOUCHES",
                          "RAISON_INSCRIPTION_PROXIMITE-ETABLISSEMENT","SECTEUR_ACTIVITE", "TRANCHE_EFFECTIF_ENTREPRISE","APPARENCE_POSTE_OCCUPE","ROLE_ENTREPRISE","CHANCE_INSERTION_PROFESSIONNELLE_REGION-OCCITANIE")
head(data_Nettoyer)
edit(data_Nettoyer)
