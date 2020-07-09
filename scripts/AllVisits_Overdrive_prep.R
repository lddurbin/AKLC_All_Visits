# Load and clean the Overdrive data
Overdrive <- excel_sheets(AllVisits.files.local["Overdrive"]) %>%
  set_names() %>%
  discard(. %in% c("Source", "Since inception", "2015", "2016", "2017")) %>% 
  map(read_excel, path = AllVisits.files.local["Overdrive"]) %>% 
  bind_rows() %>% 
  clean_names() %>% 
  mutate(Month = getMonth(date), Year = getYear(date)) %>% 
  group_by(Month, Year) %>% 
  summarise(Metric = sum(active_visits), .groups = "drop")