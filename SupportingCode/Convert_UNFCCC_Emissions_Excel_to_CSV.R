options(stringsAsFactors = FALSE)

library(openxlsx)
library(dplyr)
library(tidyr)
library(ggplot2)

df = read.xlsx('./data/ai_co2_wolulucf.xlsx', sheet=1, startRow=4)

df = df[c(1:44),]
df = df[,-2]
colnames(df)[1] = "Country"

# Year is the name of the new column we will create based on the column names
# Value is the name of the new column which will contains the values per year
# -Country means that we keep the column for Country
tmp = df %>% gather(key=Year, 
                    value=CO2_Mt, 
                    -Country) %>% 
  mutate(CO2_Mt = as.numeric(CO2_Mt)/1000, 
         Year = as.numeric(Year)) %>% 
  filter(!is.na(Year))

write.csv(tmp, file="UNFCCC_CO2_Emissions.csv", row.names=FALSE)
# Country %in% c("Germany", "Netherlands", "Belgium", "France")
# write.csv(tmp, file="UNFCCC_CO2_Emissions_DE_NL_BE_FR.csv", row.names=FALSE)