#get the sub DBs data
Subscriptions <- read_excel(AllVisits.files.local["Subscriptions"], sheet="Data", skip=7) %>% remove_empty()

#Clean and summarise subscriptions data
Subscriptions.trimmed <- Subscriptions %>% dplyr::select(1, contains("sessions")) %>% dplyr::select(1,starts_with("2018"), starts_with("2019"), starts_with("2020")) %>% melt()
Subscriptions.metric <- Subscriptions.trimmed %>% dplyr::filter(value != "NA")
Subscriptions.metric$Month <- month.abb[as.numeric(substr(Subscriptions.metric$variable, 5, 6))]
Subscriptions.metric$Year <- substr(Subscriptions.metric$variable, 1, 4)
Subscriptions_databases <-  dplyr::rename(Subscriptions.metric, "Sessions" = "value") %>% select(Database, Sessions, Month, Year)
Subscriptions.aggregate <- aggregate(list(Metric=as.numeric(Subscriptions.metric$'value')), by=list(Month=Subscriptions.metric$Month, Year=Subscriptions.metric$Year), FUN=sum)