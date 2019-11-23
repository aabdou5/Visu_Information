data <- read.csv2("results-survey111545.csv", sep = ";", header = TRUE)
data <- data[ , c(1:2,8:24, 26,37:39, 42:47)] 
length(names(data))
names(data)[1]<-"ID_Reponse"
row.names(data)=data$ID_Reponse
data_Nettoyer<-data[,-1]
head(data_Nettoyer)
edit(data_Nettoyer)

