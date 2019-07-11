library(dplyr)

malaria_original = read.csv("~/Documents/summerproj/data_science_programming/week_1/day2/malaria.csv", skip = 1)

for(i in 2000:2017)
{
  malaria_tmp = cbind(select(malaria_original,1), year = i, select(malaria_original,(20-(i-1999))))
  names(malaria_tmp) = c("country", "year", "numberOfCases")
  if ( i == 2000)
  {
    malaria = malaria_tmp
  }
  else
  {
    malaria = rbind(malaria, malaria_tmp)
  }
}
head(malaria) #print a few lines to see the result
write.csv(malaria, file = "~/Documents/summerproj/data_science_programming/week_1/day2/malaria_rearranged.csv")