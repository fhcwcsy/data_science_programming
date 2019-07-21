library(dplyr)

setwd("/home/fhcwcsy/Documents/summerproj/data_science_programming/week_2/day2")
rawPlaces = read.csv( file = "./town.csv", head = TRUE )
nameOfPlaces = c( levels(rawPlaces[,1]), levels(rawPlaces[,2]) )
nameOfPlaces = c(nameOfPlaces, gsub("鄉", "", nameOfPlaces), gsub("鎮", "", nameOfPlaces), gsub("市", "", nameOfPlaces), gsub("縣", "", nameOfPlaces), gsub("區", "", nameOfPlaces) )
nameOfPlaces = c( nameOfPlaces, gsub("臺", "台", nameOfPlaces))
nameOfPlaces = levels( factor( nameOfPlaces))
write.csv( nameOfPlaces, file = "./name_of_places.csv" )
