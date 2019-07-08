library (gapminder)
library (dplyr)

gapminder %>%
	filter (year == 1957) %>%
	arrange (desc(pop))
