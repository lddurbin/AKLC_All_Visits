# Load and clean the LibraryConnect data
LibraryConnect <- sapply(getFileLocations("LibraryConnect"), read_excel, simplify=FALSE, col_names=T,  skip=3) %>% 
  bind_rows() %>% 
  clean_names() %>% 
  mutate(Year = getYear(as.Date(day, format="%Y-%m-%d")), Month = getMonth(as.Date(day, format="%Y-%m-%d"))) %>% 
  group_by(Month, Year) %>% 
  summarise(Metric = sum(as.numeric(answered)), .groups = "drop") %>%
  filter(!is.na(Month))