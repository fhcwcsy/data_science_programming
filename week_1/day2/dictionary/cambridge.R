library(dplyr)
library(rvest)

#load input wordlist
word = read.csv("~/Documents/summerproj/data_science_programming/week_1/day2/dictionary/output_600.csv", header = TRUE)
word$exNum = 0
time = c(Sys.time(), Sys.time(), Sys.time(), Sys.time(), Sys.time(), Sys.time() )
for(i in 1:NROW(word))
{
  dictionaryPage = 
    tryCatch(read_html(paste("https://dictionary.cambridge.org/dictionary/english/", word[i, 1], sep = "")),
    error = function(e){
      word[i, 3] <<- -1
    }
  )
  if(word[i, 3] != -1)
  {
    exampleCount = NROW(html_nodes(dictionaryPage, ".eg")) 
    word[i, 3] = exampleCount
  }
  if (i < 7)
  {
    time[i] = Sys.time()
  }
  else
  {
    for(k in 1:5)
    {
      time[k] = time [k+1]
    }
    time[6] = Sys.time()
  }
  if( i > 5 )
  {
    cat(i, "/", NROW(word), "    ", as.character(word[i, 1]), "  freq: ", word[i, 2], "    ex = ", word[i, 3], "   ETA:", (time[6] - time[1]) / 5 * ( NROW(word) - i ) , "s \n")
  }
  else{
    cat(i, "/", NROW(word), "    ", as.character(word[i, 1]), "  freq: ", word[i, 2], "    ex = ", word[i, 3], "\n")
  }
}
write.csv(word, file = "~/Documents/summerproj/data_science_programming/week_1/day2/dictionary/cambridge_output.csv")