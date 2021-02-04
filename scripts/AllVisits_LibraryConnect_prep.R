old_system_data <- getFileLocations("LibraryConnect") %>% as_tibble() %>% filter(str_sub(value, 10, 24) == "Libraries Calls") %>% pull()
new_system_data <- getFileLocations("LibraryConnect") %>% as_tibble() %>% filter(str_sub(value, 10, 24) != "Libraries Calls") %>% pull()

# Load and clean the LibraryConnect data
prep_data <- function(x, skip_rows) {
  x %>% read_excel(col_names = T, skip = skip_rows) %>% 
    select(date = 1, Metric = "Answered") %>% 
    replace_na(list(Metric = 0)) %>% 
    slice(1:n()-1) %>% 
    mutate(date = convert_to_date(date), Month = month(date, label = TRUE, abbr = TRUE), Year = year(date)) %>% 
    group_by(Month, Year) %>% 
    summarise(Metric = sum(Metric), .groups = "drop")
}

LibrariesConnect_old <- map(old_system_data, prep_data, skip_rows = 3)
LibrariesConnect_new <- map(new_system_data, prep_data, skip_rows = 0)

LibraryConnect <- bind_rows(LibrariesConnect_old, LibrariesConnect_new)
