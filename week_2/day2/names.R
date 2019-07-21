library(dplyr)
library(rvest)

setwd("/home/fhcwcsy/Documents/summerproj/data_science_programming/week_2/day2")
name = c()
for (i in c(1:20)) {
	newName = paste0("https://dailyview.tw/top100/topic/9?volumn=1&page=", i) %>%
		read_html %>%
		html_nodes("#volume_rank .text-left") %>%
		html_text
	name = c( name, newName)
}

head( name, n = 20)
write.csv( name, file = "./name.csv" )
