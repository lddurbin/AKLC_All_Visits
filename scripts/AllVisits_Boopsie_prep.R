# Clean and summarise the FY2019 Boopsie data
Boopsie2019 <- read_excel(list.files("data/raw/Boopsie2019", full.names = TRUE)) %>% 
  clean_names() %>% 
  mutate(Month = getMonth(date), Year = getYear(date)) %>% 
  group_by(Month, Year) %>% 
  summarise(Metric = sum(daily_unique_users), .groups = "drop")

# Clean and summarise the FY2020 Boopsie data
Boopsie2020 <- map(list.files("data/raw/Boopsie2020", full.names = TRUE), read_excel, skip = 2, col_names = c("blank", "date", "daily_unique_users")) %>% 
  bind_rows() %>% 
  filter(is.na(blank), !is.na(across(.cols = 2:3))) %>% 
  mutate(
    Month = format(excel_numeric_to_date(as.numeric(date)), "%b"),
    Year = format(excel_numeric_to_date(as.numeric(date)), "%Y"),
    daily_unique_users = as.numeric(daily_unique_users)
    ) %>% 
  group_by(Month, Year) %>% 
  summarise(Metric = sum(daily_unique_users), .groups = "drop")