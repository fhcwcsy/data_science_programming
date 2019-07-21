library(dplyr)

setwd("/home/fhcwcsy/Documents/summerproj/data_science_programming/week_2/day2")
#read downloaded csv file
rawPlaces = read.csv( file = "./town.csv", head = TRUE )

#combine county names and town names into a vector
nameOfPlaces = c( levels(rawPlaces[,1]), levels(rawPlaces[,2]) )

#add the names without suffixes as new elements 
nameOfPlaces = c(nameOfPlaces, gsub("鄉", "", nameOfPlaces), gsub("鎮", "", nameOfPlaces), gsub("市", "", nameOfPlaces), gsub("縣", "", nameOfPlaces), gsub("區", "", nameOfPlaces) )

#character variations
nameOfPlaces = c( nameOfPlaces, gsub("臺", "台", nameOfPlaces))

#remove redundancy
nameOfPlaces = levels( factor( nameOfPlaces))

#result
head(nameOfPlaces, 20)

#write result
write.csv( nameOfPlaces, file = "./name_of_places.csv" )
