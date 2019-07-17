library(dplyr)
library(rvest)

#load input wordlist
word = read.csv("~/Documents/summerproj/data_science_programming/week_1/day2/dictionary/dictionary_com_output_english_4000.csv", header = TRUE)
word$exNum = 0
time = c(Sys.time(), Sys.time(), Sys.time(), Sys.time(), Sys.time(), Sys.time() )
for(i in 4000:97000)
{
  t_i = Sys.time()
  dictionaryPage = 
    tryCatch(read_html(paste("https://www.dictionary.com/browse/", word[i, 2], sep = "")),
             error = function(e){
               word[i, 4] <<- -1
             }
    )
  if(word[i, 4] != -1)
  {
    exampleUnderDefinitions = html_nodes(dictionaryPage, ".luna-example") 
    exampleInExampleSection = html_nodes(dictionaryPage, ".e15kc6du7") 
    exampleCount = NROW(exampleUnderDefinitions) + NROW(exampleInExampleSection)
    word[i, 4] = exampleCount
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
    cat(i, "/", NROW(word), "    ", as.character(word[i, 2]), "  freq: ", word[i, 3], "    ex = ", word[i, 4], "   ETA:", (time[6] - time[1]) / 5 * ( NROW(word) - i ) , "s \n")
  }
  else{
    cat(i, "/", NROW(word), "    ", as.character(word[i, 2]), "  freq: ", word[i, 3], "    ex = ", word[i, 4], "\n")
  }
  if( i %% 1000 == 0 )
  {
	write.csv(word, file = "~/Documents/summerproj/data_science_programming/week_1/day2/dictionary/dictionary_com_output_english.csv")
  }

}
