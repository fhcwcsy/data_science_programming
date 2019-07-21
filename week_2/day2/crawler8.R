library(bitops)
library(httr)
library(RCurl)
library(XML)
library(bitops)
library(tm)
library(NLP)
library(tmcn)
library(jiebaRD)
library(jiebaR)
library(dplyr)

#crawler to grab the links
setwd("/home/fhcwcsy/Documents/summerproj/data_science_programming/week_2/day2")
prefix = "https://www.ptt.cc/bbs/HatePolitics/index"
link = list()
for (id in c(3501:4000)) {
	url = paste0( prefix, as.character(id), ".html" )
 	html = htmlParse( GET(url) )
 	url.list = xpathSApply( html, "//div[@class='title']/a[@href]", xmlAttrs )
 	link = rbind( link, as.matrix(paste('https://www.ptt.cc', url.list, sep='')) )
}
link <- unlist(link)
head(link)
# write.csv( data, file = "./link.csv" )

# crawler to get the actual text
getdoc = function(url)
{
	html = GET( url ) %>%
		htmlParse()
	doc = xpathSApply( html, "//div[@id='main-content']", xmlValue )
	time = xpathSApply( html, "//*[@id='main-content']/div[4]/span[2]", xmlValue )
	temp = gsub( "  ", " 0", time )
	try({
	part = strsplit( temp, split=" ", fixed=T )[[1]]
	# month = part[[1]][2]
	# day = as.numeric(part[[1]][3])
	year = part[5]
	fileName <- paste0('./data/', year, ".txt")
	write(doc, fileName, append = TRUE)
	})
}

sapply(link, getdoc)


