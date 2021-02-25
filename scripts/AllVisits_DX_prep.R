# Filter DX data by service and remove extraneous columns
service_assignment <- function(service) {
  DX %>% filter(Metric_source == service) %>% 
    select(-c(3:4))
}

# Get the DX data
DX <- read_csv(list.files("data/raw/DX", full.names = TRUE), col_names = T, col_types = "ccccd")

# Assign each service to its relevant variable
community_outreach <- service_assignment("Community Libraries' outreach")
mobile_outreach <- service_assignment("Mobile and Access outreach")
research_outreach <- service_assignment("Research and Heritage outreach")
