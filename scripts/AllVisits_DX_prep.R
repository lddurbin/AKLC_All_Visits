# Get the DX data
DX_column_types = list(col_character(), col_double(), col_character(), col_character(), col_double())
DX <- read_csv(AllVisits.files.local["DX"], col_names = T, col_types = DX_column_types)