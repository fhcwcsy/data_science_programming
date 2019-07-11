library(dplyr)
water_original = read.csv("~/Documents/summerproj/data_science_programming/week_1/day2/water.csv")
water_original = water_original[-c(1,2),]
for(i in c(2000:2015))
{
  for(k in c(1:6))
  {
    if( k == 1 || k == 4)
    {
      areaName = "rural"
    }
    if( k == 2 || k == 5)
    {
      areaName = "urban"
    }
    if( k == 3 || k == 6)
    {
      areaName = "total"
    }
    if( k == 1 || k == 2 || k == 3)
    {
      basicOrSafeName = "basic"
    }
    if( k == 4 || k == 5 || k == 6)
    {
      basicOrSafeName = "safe"
    }
    water_tmp = cbind(select(water_original, 1), year = i, area = areaName, basicOrSafe = basicOrSafeName, select(water_original,(98-(6*(i-1999))+k-1)))
    names(water_tmp) = c("country", "year", "area", "basicOrSafe", "percentage")
    if ( i == 2000 && k == 1)
    {
      water = water_tmp
    }
    else
    {
      water = rbind(water, water_tmp)
    }
  }
}
rownames(water) = NULL
head(water) #print a few lines to see the result
write.csv(water, file = "~/Documents/summerproj/data_science_programming/week_1/day2/water_rearranged.csv")