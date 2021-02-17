# List files
source("scripts/listFiles.R")

#check that all files exist (get the AllVisits.files index of those that don't)
FileMissing <- matches(FALSE, file.exists(AllVisits.files), all.y=FALSE)

#store backups of each data source, conditional on all files existing
  if (is.na(FileMissing["y"])) { #do all the files exist?
    unlink("data/raw/archived/*") #clear the archive
    file.copy(Sys.glob("data/raw/*"), "data/raw/archived") #copy existing files into the archive
    unlink("data/raw/*") #clear the files we just copied
    data_dirs <- paste0("data/raw/", str_remove(names(AllVisits.files), "\\..*")) %>% unique()
    map(data_dirs, dir.create) #create directories to hold new files
    map2(AllVisits.files, names(AllVisits.files), copyFile) #copy the files into their directories
  } else { #list the missing file paths in a .txt file for checking, flash a message to the user
    writeLines(AllVisits.files[unlist(FileMissing["y"])], paste("data/missing_files_",Sys.Date(),  ".txt", sep=""))
    winDialog("ok", "Missing data file(s). Please check missing_files.txt for details.")
  }