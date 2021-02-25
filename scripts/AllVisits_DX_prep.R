# Get the DX data
DX <- read_csv(list.files("data/raw/DX", full.names = TRUE), col_names = T, col_types = "ccccd") %>% select(-c(3:4))