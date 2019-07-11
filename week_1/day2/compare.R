library(dplyr)

malaria = read.csv("~/Documents/summerproj/data_science_programming/week_1/day2/malaria_rearranged.csv")
water = read.csv("~/Documents/summerproj/data_science_programming/week_1/day2/water_rearranged.csv")
mergedResult = merge(filter(water, area == "total" & basicOrSafe == "basic"), malaria, c("country", "year"))
head(mergedResult) #print a few lines to see the result
write.csv(arrange(mergedResult, desc(numberOfCases)), file = "~/Documents/summerproj/data_science_programming/week_1/day2/merged.csv")