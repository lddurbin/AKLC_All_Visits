# Load and clean the Overdrive data
Overdrive <- excel_sheets(list.files("data/raw/Overdrive", full.names = TRUE)) %>%
  set_names() %>%
  as_tibble() %>% 
  filter(!value %in% c("Source", "Since inception", "2015", "2016", "2017")) %>% 
  pull() %>% 
  map(read_excel, path = list.files("data/raw/Overdrive", full.names = TRUE)) %>% 
  bind_rows() %>% 
  clean_names() %>% 
  mutate(Month = getMonth(date), Year = getYear(date)) %>% 
  group_by(Month, Year) %>% 
  summarise(Metric = sum(active_visits), .groups = "drop")
