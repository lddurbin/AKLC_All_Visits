# Load and clean the heritage social media data for FY2019 and FY2020
HeritageSocial2020 <- read_excel(AllVisits.files.local["HeritageSocial2020"]) %>%
  remove_empty() %>% 
  select(metric_name = 1, everything(), -length(.)) %>% 
  pivot_longer(-1, names_to = "date", names_transform = list(date = as.integer), values_to = "Metric") %>% 
  mutate(Month = getMonth(excel_numeric_to_date(date)), Year = getYear(excel_numeric_to_date(date))) %>% 
  filter(str_detect(metric_name, "Facebook engagement")) %>% 
  select(Month, Year, Metric)

HeritageSocial2019 <- read_excel(AllVisits.files.local["HeritageSocial2019"])