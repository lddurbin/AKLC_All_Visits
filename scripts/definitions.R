#ARCHIVES AND RECORDS ENQUIRIES
AandR_enquiries$Metric_type <- "Enquiries"
AandR_enquiries$Metric_source <- "Records and Archives (email)"
AandR_enquiries$Metric_group <- "Phone and email enquiries"

#ARCHIVES AND RECORDS WEBSITES
AandR_sessions$Metric_type <- "Sessions"
AandR_sessions$Metric_source <- "Records and Archives (website)"
AandR_sessions$Metric_group <- "Online visits/interactions"

#BOOPSIE2019
Boopsie2019.aggregate$'Metric_source' <- "Boopsie"
Boopsie2019.aggregate$'Metric_type' <- "Daily unique users"
Boopsie2019.aggregate$'Data_source' <- AllVisits.files.local["Boopsie2019"]
Boopsie2019.aggregate$Metric_group <- "Online visits/interactions"

#BOOPSIE2020
Boopsie2020.aggregate$'Metric_source' <- "Boopsie"
Boopsie2020.aggregate$'Data_source' <- "//aklc.govt.nz/Shared/COO/Libraries and Information/Content and Access/Team Documents/Insights and Analysis/Data Store/Boopsie"
Boopsie2020.aggregate$'Metric_type' <- "Daily unique users"
Boopsie2020.aggregate$Metric_group <- "Online visits/interactions"

#DX
DX$Data_source <- AllVisits.files["DX"]
DX$Metric_group <- case_when(
  DX$Metric_type == "Participation" ~ "Outreach participation",
  DX$Metric_type == "Sessions" ~ "Online visits/interactions",
  DX$Metric_type == "Door counts" ~ "In Library facilities visits"
)

#HERTIAGE2020
HeritageSocial.metric$Metric_group <- "Online visits/interactions"
HeritageSocial.metric$Metric_source <- "Research and Heritage (Facebook)"
HeritageSocial.metric$Data_source <- AllVisits.files.local["HeritageSocial2020"]
HeritageSocial.metric$Metric_type <- "Engagement"

#HERITAGE2019
HeritageSocial2019$Metric_group <- "Online visits/interactions"
HeritageSocial2019$Metric_type <- "Engagement"
HeritageSocial2019$Metric_source <- "Research and Heritage (Facebook)"

#KURA/HERITAGE IMAGES
KuraHeritageManuscripts.aggregate$Metric_type <- "Sessions"
KuraHeritageManuscripts.aggregate$Metric_group <- "Online visits/interactions"

#LIBRARYCONNECT
LibraryConnect.aggregate$Metric_type <- "Calls answered"
LibraryConnect.aggregate$Metric_source <- "Library Connect"
LibraryConnect.aggregate$Data_source <- "//aklc.govt.nz/Shared/COO/Libraries and Information/Content and Access/Team Documents/Insights and Analysis/Libraries Metrics/Other metrics/ALL visits/LibraryConnect/LibraryConnect calls"
LibraryConnect.aggregate$Metric_group <- "Phone and email enquiries"

#OVERDRIVE
Overdrive.aggregate$Metric_source <- "Overdrive"
Overdrive.aggregate$Data_source <- AllVisits.files.local["Overdrive"]
Overdrive.aggregate$Metric_type <- "Active visits"
Overdrive.aggregate$Metric_group <- "Online visits/interactions"

#SUBSCRIPTION DATABASES
Subscriptions.aggregate$Metric_source <- "Subscription databases"
Subscriptions.aggregate$Data_source <- AllVisits.files.local["Subscriptions"]
Subscriptions.aggregate$Metric_type <- "Sessions"
Subscriptions.aggregate$Metric_group <- "Online visits/interactions"

#SUBSCRIPTION DATABASES - temporary fix
Subscriptions.aggregate2$Metric_source <- "Subscription databases"
Subscriptions.aggregate2$Data_source <- AllVisits.files.local["Subscriptions"]
Subscriptions.aggregate2$Metric_type <- "Sessions"
Subscriptions.aggregate2$Metric_group <- "Online visits/interactions"