# *****************************************************************************
# Setup ----

#install.packages("needs")
library(needs)
needs(tidyverse, readxl, janitor, lubridate, reshape2, busdater, plyr, grr)

setwd("H:/Documents/R/AllVisits")
remove(list = ls())

source("functions.R")

# *****************************************************************************


# *****************************************************************************
# Load and prep data ---- 

# List files and refresh local copies
source("listFiles.R")
source("AllVisits_copy_files.R")

# Point to raw data files in project folder
AllVisits.files.local <- gsub("^(.*[/])", "data/raw/", AllVisits.files)

# Run the data prep scripts
prep.files = (list.files(pattern = "\\_prep.R$"))
sapply(prep.files, source)

#temporary subDBs fix for new process
SubDBs <- as.data.frame(read_excel("data/raw/SubDBs_Apr2020.xlsx"))
Subscriptions.aggregate2 <- aggregate(list(Metric=SubDBs$Sessions), by=list(Month=SubDBs$Month, Year=SubDBs$Year), FUN=sum) %>% filter(Metric > 50)
merge(x = Subscriptions.aggregate2, y = Subscriptions.aggregate, by=c("Year", "Month")) %>% mutate(diff = Metric.x-Metric.y)


#assign labels to metrics
source("definitions.R")


# *****************************************************************************


# *****************************************************************************
# Finishing touches and export ---- 

#Merge all data frames together
AllVisits1.2 <- rbind(
  KuraHeritageManuscripts.aggregate,
  Boopsie2019.aggregate,
  Boopsie2020.aggregate,
  RegionalSocial2019.aggregate,
  RegionalSocial.aggregate,
  Overdrive.aggregate,
  HeritageSocial2019,
  HeritageSocial.metric,
  Subscriptions.aggregate2,
  DX,
  AandR_enquiries,
  AandR_sessions,
  LibraryConnect.aggregate
  )

#add a column for months as ordinals based on FY
i = 1
while (i <= nrow(AllVisits1.2)) {
  if(match(AllVisits1.2$Month[i], month.abb) > 6) {
    AllVisits1.2$Month_number[i] <- match(AllVisits1.2$Month[i], month.abb)-6
  } else {
    AllVisits1.2$Month_number[i] <- match(AllVisits1.2$Month[i], month.abb)+6
  }
  i = i+1
}

#Get FY, remove the current month (as it'll be incomplete), get a date from the month and year
AllVisits1.2$FY <- as.character(get_fy(date = as.Date(paste("01", AllVisits1.2$Month, AllVisits1.2$Year, sep="-"), "%d-%b-%Y")))
AllVisits1.2 <- filter(AllVisits1.2, paste(AllVisits1.2$Month, AllVisits1.2$Year) != paste(format(Sys.Date(), "%b"), format(Sys.Date(), "%Y")))
AllVisits1.2$Date <- as.Date(paste(AllVisits1.2$Month, "01", AllVisits1.2$Year, sep="/"), format="%b/%d/%Y")

#Calculate the change (# and %) compared to the same point the previous FY
AllVisits1.3 <- arrange(AllVisits1.2, Metric_source, Month_number, FY) %>%
  group_by(Metric_source, Month) %>%
  dplyr::mutate(Change_num = Metric - lag(Metric, default = first(Metric)),
                Change_perc = Change_num/lag(Metric, default = first(Metric)))

#Calculate the change (# and %) compared to the previous month
AllVisits1.4 <- arrange(AllVisits1.3, Metric_source, FY, Month_number) %>%
  group_by(Metric_source) %>%
  dplyr::mutate(Change_month_num = Metric - lag(Metric, default = first(Metric)),
                Change_month_perc = Change_month_num/lag(Metric, default = first(Metric)))

#Calculate the FYTD
AllVisits1.5 <- arrange(AllVisits1.4, Metric_source, FY, Month_number) %>%
  group_by(Metric_source, FY) %>%
  dplyr::mutate(FYTD = cumsum(Metric))

#Calculate the change (# and %) compared to the previous FYTD
AllVisits1.6 <- arrange(AllVisits1.5, Metric_source, Month_number, FY) %>%
  group_by(Metric_source, Month) %>%
  dplyr::mutate(Change_FYTD_num = FYTD - lag(FYTD, default = first(FYTD)),
                Change_FYTD_perc = Change_FYTD_num/lag(FYTD, default = first(FYTD)))

#Archive the old data output and export the new data frame to a .csv file
file.rename("data/processed/AllVisits.csv", paste("data/processed/archived/AllVisits_", as.Date(file.info("data/processed/AllVisits.csv")$ctime), ".csv", sep=""))
write.csv(AllVisits1.6, "data/processed/AllVisits.csv", na="")

# *****************************************************************************


# *****************************************************************************
# Checks and summaries ---- 

source("AllVisits_DataValidation.R")
Latest
FY19_total

# *****************************************************************************