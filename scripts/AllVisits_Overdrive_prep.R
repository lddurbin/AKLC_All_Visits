#get the Overdrive data
Overdrive.path.sheets <- AllVisits.files.local["Overdrive"] %>% excel_sheets()
Overdrive <- Overdrive.path.sheets[(length(Overdrive.path.sheets)-2):length(Overdrive.path.sheets)] %>% map_df(~ read_excel(path = AllVisits.files.local["Overdrive"], sheet = .x, col_types="text" ,range=cell_cols("A:B")), .id = "sheet")

#Clean and summarise Overdrive visits data
Overdrive$Month <- getMonth(excel_numeric_to_date(as.numeric(Overdrive$Date)))
Overdrive$Year <-getYear(excel_numeric_to_date(as.numeric(Overdrive$Date)))
Overdrive$Metric_source <- "Overdrive"
Overdrive$Data_source <- AllVisits.files.local["Overdrive"]
Overdrive$Metric_type <- "Active visits"
Overdrive.aggregate <- aggregate(list(Metric=as.numeric(Overdrive$'Active visits')), by=list(Data_source=Overdrive$'Data_source', Metric_source=Overdrive$'Metric_source', Metric_type=Overdrive$'Metric_type', Month=Overdrive$Month, Year=Overdrive$Year), FUN=sum)
Overdrive.aggregate$Metric_group <- "Online visits/interactions"