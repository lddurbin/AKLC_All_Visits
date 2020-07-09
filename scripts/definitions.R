#ARCHIVES AND RECORDS ENQUIRIES
AandR_enquiries$Metric_type <- "Enquiries"
AandR_enquiries$Metric_source <- "Records and Archives (email)"
AandR_enquiries$Metric_group <- "Phone and email enquiries"
#ARCHIVES AND RECORDS WEBSITES
AandR_sessions$Metric_type <- "Sessions"
AandR_sessions$Metric_source <- "Records and Archives (website)"
AandR_sessions$Metric_group <- "Online visits/interactions"

#BOOPSIE2019
Boopsie2019$Metric_source <- "Boopsie"
Boopsie2019$Metric_type <- "Daily unique users"
Boopsie2019$Data_source <- AllVisits.files.local["Boopsie2019"]
Boopsie2019$Metric_group <- "Online visits/interactions"

#BOOPSIE2020
Boopsie2020$Metric_source <- "Boopsie"
Boopsie2020$Data_source <- "//aklc.govt.nz/Shared/COO/Libraries and Information/Content and Access/Team Documents/Insights and Analysis/Data Store/Boopsie"
Boopsie2020$Metric_type <- "Daily unique users"
Boopsie2020$Metric_group <- "Online visits/interactions"

#DX
DX$Data_source <- AllVisits.files["DX"]
DX$Metric_group <- case_when(
  DX$Metric_type == "Participation" ~ "Outreach participation",
  DX$Metric_type == "Sessions" ~ "Online visits/interactions",
  DX$Metric_type == "Door counts" ~ "In Library facilities visits"
)

#HERTIAGE2020
HeritageSocial2020$Metric_group <- "Online visits/interactions"
HeritageSocial2020$Metric_source <- "Research and Heritage (Facebook)"
HeritageSocial2020$Data_source <- AllVisits.files.local["HeritageSocial2020"]
HeritageSocial2020$Metric_type <- "Engagement"

#HERITAGE2019
HeritageSocial2019$Metric_group <- "Online visits/interactions"
HeritageSocial2019$Metric_type <- "Engagement"
HeritageSocial2019$Metric_source <- "Research and Heritage (Facebook)"

#KURA
Kura$Data_source <- "//aklc.govt.nz/Shared/COO/Libraries and Information/Content and Access/Team Documents/Insights and Analysis/Libraries Metrics/Other metrics/ALL visits/Kura"
Kura$Metric_source <- "Kura"
Kura$Metric_group <- "Online visits/interactions"

#HERITAGE IMAGES
HeritageImages$Data_source <- "//aklc.govt.nz/Shared/COO/Libraries and Information/Content and Access/Team Documents/Insights and Analysis/Libraries Metrics/Other metrics/ALL visits/Research & Heritage/Heritage Images and Manuscripts Online.xlsx"
HeritageImages$Metric_source <- "Heritage Images"
HeritageImages$Metric_group <- "Online visits/interactions"

#KURA/HERITAGE IMAGES
ManuscriptsOnline$Data_source <- "//aklc.govt.nz/Shared/COO/Libraries and Information/Content and Access/Team Documents/Insights and Analysis/Libraries Metrics/Other metrics/ALL visits/Research & Heritage/Heritage Images and Manuscripts Online.xlsx"
ManuscriptsOnline$Metric_source <- "Manuscripts Online"
ManuscriptsOnline$Metric_group <- "Online visits/interactions"

#LIBRARYCONNECT
LibraryConnect$Metric_type <- "Calls answered"
LibraryConnect$Metric_source <- "Library Connect"
LibraryConnect$Data_source <- "//aklc.govt.nz/Shared/COO/Libraries and Information/Content and Access/Team Documents/Insights and Analysis/Libraries Metrics/Other metrics/ALL visits/LibraryConnect/LibraryConnect calls"
LibraryConnect$Metric_group <- "Phone and email enquiries"

#OVERDRIVE
Overdrive$Metric_source <- "Overdrive"
Overdrive$Data_source <- AllVisits.files.local["Overdrive"]
Overdrive$Metric_type <- "Active visits"
Overdrive$Metric_group <- "Online visits/interactions"

#REGIONALSOCIAL
RegionalSocial <- RegionalSocial %>% mutate(Metric_type = case_when(
  .$Metric_source == "Regional social media Facebook, Twitter, Instagram" ~ "Engagement",
  .$Metric_source == "Regional social media blog page" ~ "Views",
  .$Metric_source == "Regional social media YouTube" ~ "Views",
  .$Metric_source == "Regional social media Sound Cloud podcast" ~ "Listens"
))
RegionalSocial$Metric_group <- "Online visits/interactions"

#SUBSCRIPTION DATABASES
Subscriptions$Metric_source <- "Subscription databases"
Subscriptions$Data_source <- AllVisits.files.local["Subscriptions"]
Subscriptions$Metric_type <- "Sessions"
Subscriptions$Metric_group <- "Online visits/interactions"