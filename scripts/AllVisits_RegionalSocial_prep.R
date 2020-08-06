metrics <- c("total social post engagement", "blog page views", "blog page views (libraries + heritage et al)", "youtube views", "sound cloud podcast listens")

# Prepare regional social data, irrespective of the FY
RegionalSocialPrep <- function(x) {
  x %>% read_excel(range = cell_cols("A:N")) %>% 
    pivot_longer(2:(length(.)-1), values_to = "Metric", names_transform = list(name = as.integer)) %>% 
    filter(str_to_lower(...1) %in% metrics & (!is.na(Metric) & Metric > 0)) %>% 
    mutate(Month = getMonth(excel_numeric_to_date(name)), Year = getYear(excel_numeric_to_date(name)), Data_source = x, Metric_source = case_when(
      str_detect(str_to_lower(...1), "total social post engagement") ~ "Regional social media Facebook, Twitter, Instagram",
      str_detect(str_to_lower(...1), "blog page views") ~ "Regional social media blog page",
      str_detect(str_to_lower(...1), "youtube views") ~ "Regional social media YouTube",
      str_detect(str_to_lower(...1), "sound cloud podcast listens") ~ "Regional social media Sound Cloud podcast"
    )) %>% 
    select(-c(1:3))
}

# List all regional social data files
files <- AllVisits.files.local[grep("RegionalSocial*", names(AllVisits.files.local))]

# Load and clean all regional social data files
RegionalSocial <- lapply(files, RegionalSocialPrep) %>% 
  bind_rows()