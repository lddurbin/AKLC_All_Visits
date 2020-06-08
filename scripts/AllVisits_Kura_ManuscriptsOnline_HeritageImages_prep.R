#get the Kura data
Kura <- sapply(getFileLocations("Kura"), read_excel, simplify=FALSE) %>% 
  bind_rows()

#get the Heritage Images and Manuscripts Online data
Heritage <- AllVisits.files.local["Heritage"] %>% 
  excel_sheets() %>% 
  set_names() %>% 
  map_df(~read_excel(path = AllVisits.files.local["Heritage"], sheet = .x), .id = "Source")

#Merge the Kura and Heritage data frames
Kura$Users <- NA
Kura$'Page Views' <- NA
Kura$Source <- "Kura"
Kura$Data_source <- "//aklc.govt.nz/Shared/COO/Libraries and Information/Content and Access/Team Documents/Insights and Analysis/Libraries Metrics/Other metrics/ALL visits/Kura"
Heritage$Data_source <- AllVisits.files.local["Heritage"]
KuraHeritageManuscripts <- rbind(Kura, Heritage)

#Clean the merged Kura and Heritage datasets, aggregate Metric, add new columns
KuraHeritageManuscripts.na_remove <- filter(KuraHeritageManuscripts, !is.na(KuraHeritageManuscripts$`Day Index`))
KuraHeritageManuscripts.na_remove$Month <- getMonth(KuraHeritageManuscripts.na_remove$`Day Index`)
KuraHeritageManuscripts.na_remove$Year <- getYear(KuraHeritageManuscripts.na_remove$`Day Index`)
KuraHeritageManuscripts.aggregate <- aggregate(list(Metric=KuraHeritageManuscripts.na_remove$Sessions), by=list(Data_source=KuraHeritageManuscripts.na_remove$Data_source, Metric_source=KuraHeritageManuscripts.na_remove$Source, Month=KuraHeritageManuscripts.na_remove$Month, Year=KuraHeritageManuscripts.na_remove$Year), FUN=sum)