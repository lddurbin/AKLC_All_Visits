# Load and clean the subscription databases data
Subscriptions <- read_csv(list.files("data/raw/Subscriptions", full.names = TRUE), col_types = "ccncc") %>% 
  group_by(Month, Year = as.character(Year)) %>% 
  summarise(Metric = sum(Sessions, na.rm = T), .groups = "drop")
