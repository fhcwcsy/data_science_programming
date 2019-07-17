library(dplyr)
library(rvest)

#load input wordlist
word = read.csv("~/Documents/summerproj/data_science_programming/week_1/day2/dictionary/output_stackoverflow_20000.csv", header = TRUE)
word$exNum = 0
time = c(Sys.time(), Sys.time(), Sys.time(), Sys.time(), Sys.time(), Sys.time() )
for(i in 1:NROW(word))
{
  t_i = Sys.time()
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
  if( i %% 200 == 0 )
  {
	write.csv(word, file = "~/Documents/summerproj/data_science_programming/week_1/day2/dictionary/dictionary_com_output_stackoverflow.csv")
  	cat("File written at ", i, "/", NROW(word), "\n")
  }

}
