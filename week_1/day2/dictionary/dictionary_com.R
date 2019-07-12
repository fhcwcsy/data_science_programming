library(dplyr)
library(rvest)

#load input wordlist
word = read.csv("~/Documents/summerproj/data_science_programming/week_1/day2/dictionary/sampletext.csv", header = FALSE)
word$exNum = 0
for(i in 1:NROW(word))
{
  dictionaryPage = 
    tryCatch(read_html(paste("https://www.dictionary.com/browse/", word[i, 1], sep = "")),
             error = function(e){
               word[i, 3] <<- -1
             }
    )
  if(word[i, 3] != -1)
  {
    exampleUnderDefinitions = html_nodes(dictionaryPage, ".luna-example") 
    exampleInExampleSection = html_nodes(dictionaryPage, ".e15kc6du7") 
    exampleCount = NROW(exampleUnderDefinitions) + NROW(exampleInExampleSection)
    word[i, 3] = exampleCount
  }
  print(paste(i,NROW(word), sep = "/"))
}
write.csv(word, file = "~/Documents/summerproj/data_science_programming/week_1/day2/dictionary/dictionary_com_output.csv")