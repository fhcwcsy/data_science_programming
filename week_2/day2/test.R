library(dplyr)

setwd("/home/fhcwcsy/Documents/summerproj/data_science_programming/week_2/day2")
a = rbind(read.csv("./name_of_places.csv", skip = 1, header = FALSE), read.csv("./name.csv", skip = 1, header = FALSE) )
a[,2] %>%
	levels %>%
	class
