library(jiebaR)
library(rvest)
library(dplyr)
setwd("/home/fhcwcsy/Documents/summerproj/data_science_programming/week_2/day2")
cut = worker()
xibajang = c("亢龙有悔", "飞龙在天","见龙在田","鸿渐于陆","潜龙勿用","利涉大川","尺蠖之屈","尺蠖之屈","双龙取水","神龙摆尾","突如其来","时乘六龙","密云不雨","损则有孚","龙战于野","履霜冰至","羝羊触藩","震惊百里")
new_user_word(cut, xibajang)
cut$bylines = TRUE
rawCharSd = readChar("text/sd.txt", file.info("text/sd.txt")$size)
sdChap = strsplit( rawCharSd, "\r\n\r\n" )
sdChap = sdChap[[1]]
word = segment(sdChap, cut)
word %>% str
	
