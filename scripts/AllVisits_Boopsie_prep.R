#get the Boopsie2019 and Boopsie2020 data
Boopsie2019 <- read_excel(AllVisits.files.local["Boopsie2019"])
Boopsie2020 <- sapply(getFileLocations("Boopsie2020"), read_excel, simplify=FALSE) %>% 
  bind_rows(.id = "id")

#Clean and summarise the FY2019 Boopsie data
Boopsie2019$Month <- getMonth(Boopsie2019$Date)
Boopsie2019$Year <- getYear(Boopsie2019$Date)
Boopsie2019.aggregate <- aggregate(list(Metric=Boopsie2019$'Daily Unique Users'), by=list(Month=Boopsie2019$Month, Year=Boopsie2019$Year), FUN=sum)


#Clean and summarise the FY2020 Boopsie data
Boopsie2020.na_fixes <- Boopsie2020 %>% filter(is.na(...1) & !is.na(Date))
Boopsie2020.na_fixes$Month <- format(excel_numeric_to_date(as.numeric(Boopsie2020.na_fixes$Date)), "%b")
Boopsie2020.na_fixes$Year <- format(excel_numeric_to_date(as.numeric(Boopsie2020.na_fixes$Date)), "%Y")
Boopsie2020.na_fixes$`Daily Unique Users` <- as.numeric(Boopsie2020.na_fixes$`Daily Unique Users`)
Boopsie2020.aggregate <- aggregate(list(Metric=Boopsie2020.na_fixes$'Daily Unique Users'), by=list(Month=Boopsie2020.na_fixes$Month, Year=Boopsie2020.na_fixes$Year), FUN=sum)