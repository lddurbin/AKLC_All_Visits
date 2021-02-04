#get the abbreviated month name from a date
getMonth <- function(x) {
  format(x, "%b")
}

#get the abbreviated month name from a date
getYear <- function(x) {
  format(x, "%Y")
}

#select URLs to data files from the AllVisits.files.local vector
getFileLocations <- function(x) {
  stack(AllVisits.files.local)[grep(paste("^", x, sep=""), stack(AllVisits.files.local)$ind), ]$values
}

copyFile <- function(file, directory) {
  file.copy(file, paste0("data/raw/", str_remove(directory, "\\..*")))
}