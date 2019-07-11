library(dplyr)
library(rvest)
library(wordcloud)
full_page <- read_html("https://stackoverflow.com/questions?sort=frequent&page=1")
full_page
tag_nodes <- html_nodes(full_page, "#questions .post-tag")
head(tag_nodes)
tags <- html_text(tag_nodes)
head(tags)
page <- 10
all_tags <- character(0)
for(i in 1:page){
    tags <- paste0("https://stackoverflow.com/questions?sort=frequent&page=", i) %>%
        read_html %>%
        html_nodes("#questions .post-tag") %>%
        html_text
    all_tags <- c(all_tags, tags)
}   
head(all_tags, 40)
freq <- table(all_tags)
head(sort(freq, decreasing=T))
wordcloud(names(freq), freq, min.freq = 1, scale=c(4,.2), max.words=200, random.order=FALSE, colors=brewer.pal(5,"Dark2"))
