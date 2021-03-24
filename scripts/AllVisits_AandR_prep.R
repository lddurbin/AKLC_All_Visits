# Prepare Archives and Records data
AandR_prep <- function(x) {
  read_excel(list.files(x, full.names = TRUE)) %>% 
    select(-c(Metric_source, Metric_type, Data_source)) %>% 
    mutate(across(c(1:2), as.character))
}

# Get Records and Archives email enquiries and website sessions
AandR_enquiries <- AandR_prep("data/raw/AandR_enquiries")
AandR_sessions <- AandR_prep("data/raw/AandR_sessions")
