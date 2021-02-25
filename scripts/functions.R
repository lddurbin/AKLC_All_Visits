#get the abbreviated month name from a date
getMonth <- function(x) {
  format(x, "%b")
}

#get the abbreviated month name from a date
getYear <- function(x) {
  format(x, "%Y")
}

copyFile <- function(file, directory) {
  file.copy(file, paste0("data/raw/", str_remove(directory, "\\..*")))
}
