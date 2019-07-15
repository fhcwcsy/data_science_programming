library(SportsAnalytics)
nba1516 = fetch_NBAPlayerStatistics("15-16")
library(ggplot2)
qplot(FieldGoalsAttempted, TotalPoints, data = nba1516)
