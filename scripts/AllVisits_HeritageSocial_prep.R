#get the heritage social media data for FY2019 and FY2020
HeritageSocial2020 <- read_excel(AllVisits.files.local["HeritageSocial2020"]) %>% remove_empty()
HeritageSocial2019 <- read_excel(AllVisits.files.local["HeritageSocial2019"])

#Clean Heritage social media data
HeritageSocial.reshaped <- melt(HeritageSocial2020[1:(length(HeritageSocial2020)-1)])
HeritageSocial.reshaped$Month <- getMonth(excel_numeric_to_date(as.numeric(as.character.factor(HeritageSocial.reshaped$variable))))
HeritageSocial.reshaped$Year <- getYear(excel_numeric_to_date(as.numeric(as.character.factor(HeritageSocial.reshaped$variable))))
HeritageSocial.metric <- HeritageSocial.reshaped %>% dplyr::filter(str_detect(...1, "Facebook engagement")) %>% dplyr::select(Metric=value, Month, Year)