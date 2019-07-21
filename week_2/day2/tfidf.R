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
tf = apply(as.matrix(tdm[,3:n]), 2, sum) #total number of words in every documents
idfCal = function(doc) #calculate idf
{
	log2( (length(doc) ) / Matrix::nnzero(doc) )
}
idf = apply(as.matrix(tdm[,3:n]), 1, idfCal)

tfidfMat = as.matrix(tdm[,2:n])
# tf-idf = elements * idf / tf(it's value is now the total number of words in every documents)
# define functions to calculate tf-idf (two steps)
tfidfCal1 = function(col)
{
  as.numeric(col) * idf
}
tfidfCal2 = function(row)
{
  row / tf
}
# save the word column since they will be lost later
wordscol = tfidfMat[, 1]
# calculate with two applys
tfidfMat = apply(tfidfMat[, 2:ncol(tfidfMat)], 2, tfidfCal1)
tfidfMat = apply(tfidfMat, 1, tfidfCal2)
tfidfMat = t(tfidfMat)
# restore the words
rownames( tfidfMat) = wordscol
#step result
str(tfidfMat)
# remove trash words  
stopLine = rowSums(tfidfMat)
delId = which(stopLine == 0) # adjust the condition if the result is not satisfying
tdm = tdm[-delId,]
tfidfMat = tfidfMat[-delId,]
colnames(tfidfMat) = gsub("X", "", colnames(tfidfMat))
colnames(tdm) = gsub("X", "", colnames(tdm))

# rank
rank = function(col) {rownames(tfidfMat)[order(-col)][1:30]}
rank = apply( tfidfMat, 2, rank )
str(rank)

#save progress
write.csv(rank, file = "./rank.csv")
write.csv(tdm, file = "./tdm_new.csv")
write.csv(tfidfMat, file = "./tfidf.csv")


