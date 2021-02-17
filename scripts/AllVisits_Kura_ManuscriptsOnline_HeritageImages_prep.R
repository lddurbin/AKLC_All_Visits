# Prepare Google Analytics data
wrangle_data <- function(x) {
  sapply(list.files(paste0("data/raw/", x), full.names = TRUE), read_excel, sheet=2, simplify=FALSE) %>%
    bind_rows() %>% 
    clean_names() %>% 
    mutate(Month = getMonth(day_index), Year = getYear(day_index), Metric_type = "Sessions") %>% 
    filter(!is.na(day_index)) %>% 
    group_by_if(is.character) %>% 
    summarise(Metric = sum(sessions), .groups = "drop")
}

# Load and clean the Kura data
Kura <- wrangle_data("Kura")

# Load and clean the Heritage Images data
HeritageImages <- wrangle_data("HeritageImages")

# Load and clean the Manuscripts Online data
ManuscriptsOnline <- wrangle_data("Manuscripts")