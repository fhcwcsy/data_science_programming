library(ggplot2)
library(dplyr)

setwd("/home/fhcwcsy/Documents/summerproj/data_science_programming/week_2/day2")

tdm_raw = read.csv( file = "./tdm_new.csv")
rank_raw = read.csv( file = "./rank.csv")
tfidf_raw = read.csv( file = "./tfidf.csv")

#total amount of posts by year
year = gsub( "X", "", colnames(rank_raw)[2:(ncol(rank)+1)] )
fileName = paste0( "./data/", year, ".txt")
size_MB = sapply(fileName, file.size) /(1024^2)
sizedf = data.frame(year, size_MB)
ggplot(sizedf, aes(x = year, y = size_MB)) + geom_bar(stat="identity")

#find the trends of the top words this year
tdm = select(tdm_raw, 3:ncol(tdm_raw))
colnames(tdm) = c("word", year)
tdm = arrange(tdm, desc(tdm[,'2019'])) %>%
  filter( nchar(as.character(word)) != 1 & as.character(word) != "網址")
head(tdm)

normalize = function(row)
{
  row / size_MB * 1000
}
word_tmp = tdm[,1]
tdm_normalized = t(apply(tdm[,2:(ncol(tdm))], 1, normalize))
rownames(tdm_normalized) = word_tmp
head(tdm_normalized)

topten = tdm_normalized[1:10,]
kable(topten)
library(reshape2)
topten_melted = melt(t(topten))
colnames(topten_melted) = c("year", "word", "normalized_frequency")
head(topten_melted)

ggplot(topten_melted, aes( year, normalized_frequency)) + geom_line(aes(color = word))

