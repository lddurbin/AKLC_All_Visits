HeritageSocialPrep <- function(x) {
  x %>% read_excel() %>%
    remove_empty(which = c("rows", "cols")) %>% 
    select(metric_name = 1, everything(), -length(.)) %>% 
    pivot_longer(-1, names_to = "date", names_transform = list(date = as.integer), values_to = "Metric") %>% 
    mutate(Data_source = x, Month = getMonth(excel_numeric_to_date(date)), Year = getYear(excel_numeric_to_date(date))) %>% 
    filter(str_detect(metric_name, "Facebook engagement")) %>% 
    select(Data_source, Month, Year, Metric)
}

# Load the FY19 regional social data file
HeritageSocial_historic <- list.files("data/raw/HistoricHeritageSocial", full.names = TRUE) %>%
  read_excel(col_type = c("text", "text", "numeric")) %>% 
  mutate(Data_source = list.files("data/raw/HistoricHeritageSocial"))

# Load and clean all post-FY19 regional social data files
HeritageSocial_recent <- lapply(list.files(c("data/raw/HeritageSocial2020", "data/raw/HeritageSocial2021"), full.names = TRUE), HeritageSocialPrep) %>% bind_rows()

# Combine the FY19 and post-FY19 data
HeritageSocial <- bind_rows(HeritageSocial_recent, HeritageSocial_historic)
