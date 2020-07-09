# Clean and summarise the FY2019 Boopsie data
Boopsie2019 <- clean_names(read_excel(AllVisits.files.local["Boopsie2019"])) %>% 
  mutate(Month = getMonth(date), Year = getYear(date)) %>% 
  group_by(Month, Year) %>% 
  summarise(Metric = sum(daily_unique_users), .groups = "drop")

# Clean and summarise the FY2020 Boopsie data
Boopsie2020 <- sapply(getFileLocations("Boopsie2020"), read_excel, simplify=FALSE) %>% 
  bind_rows(.id = "id") %>% 
  clean_names() %>% 
  filter(is.na(x1) & !is.na(date)) %>% 
  mutate(
    Month = format(excel_numeric_to_date(as.numeric(date)), "%b"),
    Year = format(excel_numeric_to_date(as.numeric(date)), "%Y"),
    daily_unique_users = as.numeric(daily_unique_users)
    ) %>% 
  group_by(Month, Year) %>% 
  summarise(Metric = sum(daily_unique_users), .groups = "drop")