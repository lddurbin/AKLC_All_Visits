# Load and clean the subscription databases data
Subscriptions <- read_csv(AllVisits.files.local["Subscriptions"]) %>% 
  group_by(Month, Year = as.character(Year)) %>% 
  summarise(Metric = sum(Sessions, na.rm = T), .groups = "drop")