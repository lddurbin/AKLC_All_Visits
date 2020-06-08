#get the list of data sources
data <- read_excel("data/AllVisits_data_sources.xlsx", sheet="Files")

#list files - singular
SingleFiles <- data$Path[data$`Multiple files?` == "N"]
names(SingleFiles) <- data$Name[data$`Multiple files?` == "N"]

#list files - multiples
MultipleFiles <- c(
  Boopsie2020.path = grep(list.files(path = data$Path[data$Name=="Boopsie2020"], pattern = "*.xlsx$", full.names = T), pattern='FY2019', inv=T, value=T),
  LibraryConnect.path = list.files(path = data$Path[data$Name=="LibraryConnect"], full.names = T),
  Kura.path = list.files(path = data$Path[data$Name=="Kura"], pattern = ".*.xlsx$", full.names = T)
)

#list all files
AllVisits.files <- c(SingleFiles, MultipleFiles)