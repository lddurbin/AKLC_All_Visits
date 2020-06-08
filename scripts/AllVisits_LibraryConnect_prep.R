#get the LibraryConnect data
LibraryConnect <- sapply(getFileLocations("LibraryConnect"), read_excel, simplify=FALSE) %>% 
  bind_rows()

#Merge and clean Library Connect calls data
names(LibraryConnect) <- as.character(LibraryConnect[2,])
LibraryConnect.trimmed <- LibraryConnect[,c(2,5)] %>% filter(!is.na(LibraryConnect$Day)) %>% tail(-1)
LibraryConnect.trimmed$Year <- getYear(as.Date(LibraryConnect.trimmed$Day, format="%Y-%m-%d"))
LibraryConnect.trimmed$Month <- getMonth(as.Date(LibraryConnect.trimmed$Day, format="%Y-%m-%d"))
LibraryConnect.aggregate <- aggregate(list(Metric=as.numeric(LibraryConnect.trimmed$Answered)), by=list(Month=LibraryConnect.trimmed$Month, Year=LibraryConnect.trimmed$Year), FUN=sum)