# Get Records and Archives email enquiries and website sessions
AandR_enquiries <- read_excel(list.files("data/raw/AandR_enquiries", full.names = TRUE))
AandR_sessions <- read_excel(list.files("data/raw/AandR_sessions", full.names = TRUE))