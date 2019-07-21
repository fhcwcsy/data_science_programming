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
library(knitr)

setwd("/home/fhcwcsy/Documents/summerproj/data_science_programming/week_2/day2")
tdm_raw = read.csv( file = "./tdm.csv", header = TRUE )
tdm = tdm_raw
n = length(tdm)
print(n)
tf = apply(as.matrix(tdm[,3:n]), 2, sum) #total number of words in every documents
idfCal = function(doc)
{
	log2( (length(doc) ) / Matrix::nnzero(doc) )
}
idf = apply(as.matrix(tdm[,3:n]), 1, idfCal)

tfidfMat = as.matrix(tdm[,2:n])
tfidfCal1 = function(col)
{
  as.numeric(col) * idf
}
tfidfCal2 = function(row)
{
  row / tf
}
wordscol = tfidfMat[, 1]
tfidfMat = apply(tfidfMat[, 2:ncol(tfidfMat)], 2, tfidfCal1)
tfidfMat = apply(tfidfMat, 1, tfidfCal2)
tfidfMat = t(tfidfMat)
rownames( tfidfMat) = wordscol
head(tfidfMat)
# remove trash words  
stopLine = rowSums(tfidfMat)
delId = which(stopLine == 0)
tdm = tdm[-delId,]
tfidfMat = tfidfMat[-delId,]
colnames(tfidfMat) = gsub("X", "", colnames(tfidfMat))
colnames(tdm) = gsub("X", "", colnames(tdm))

# rank
rank = function(col) {rownames(tfidfMat)[order(-col)][1:30]}
rank = apply( tfidfMat, 2, rank )
rank

write.csv(rank, file = "./rank.csv")
write.csv(tdm, file = "./tdm_new.csv")
write.csv(tfidfMat, file = "./tfidf.csv")


