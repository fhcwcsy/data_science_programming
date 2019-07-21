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


setwd("/home/fhcwcsy/Documents/summerproj/data_science_programming/week_2/day2")
#load word data by files into a list
d.corpus = Corpus( DirSource("./data") )
#remove punctuation and numbers
d.corpus = tm_map(d.corpus, removePunctuation)
d.corpus = tm_map(d.corpus, removeNumbers)
d.corpus = tm_map(d.corpus, function(word) 
{
	gsub("[A-Za-z0-9]", "", word)
})

#generate text matrix
cutter = worker()

myName = rbind(read.csv("./name_of_places.csv", skip = 1, header = FALSE), read.csv("./name.csv", skip = 1, header = FALSE) )
myName = myName[,2] %>%
	levels
new_user_word( cutter, myName )

#define custom cutter
jieba_tokenizer = function(d)
{
	unlist( segment( d[[1]], cutter ) )
}

#cut, return a list
seg = lapply(d.corpus, jieba_tokenizer)

#use `table` to count the words then transform it into a df
count_token = function(d)
{
	as.data.frame(table(d))
}
tokens = lapply( seg, count_token )

n = length(seg)
tdm = tokens[[1]]
colNames = names(seg)
colNames = gsub(".txt", "", colNames)

for( id in c(2:n) )
{
  # d: the words
  tdm = merge(tdm, tokens[[id]], by="d", all = TRUE)
  names(tdm) = c('d', colNames[1:id])
}
# use is.na to pick up NAs and assign value 0 to all NAs
tdm[is.na(tdm)] <- 0
library(knitr)
# result output
kable(tail(tdm))
kable(head(tdm))

write.csv(tdm, file = "./tdm.csv")

