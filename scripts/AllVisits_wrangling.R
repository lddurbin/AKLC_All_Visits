# *****************************************************************************
# Setup ----

# Load libraries
library("tidyverse")
library("readxl")
library("janitor")
library("lubridate")
library("busdater")
library("grr")
#needs(tidyverse, readxl, janitor, lubridate, busdater, grr)

# Commonly-used functions
source("scripts/functions.R")

# List files
source("scripts/listFiles.R")

# Refresh local copy of files, archive existing set
source("scripts/AllVisits_copy_files.R")

# *****************************************************************************


# *****************************************************************************
# Load and prep data ---- 

# Point to raw data files in project folder
AllVisits.files.local <- gsub("^(.*[/])", "data/raw/", AllVisits.files)

# Run the data prep scripts
prep.files = list.files("scripts/", pattern = "\\_prep.R$")
sapply(paste("scripts", prep.files, sep="/"), source, simplify = F) %>% invisible()

#assign labels to metrics
source("scripts/definitions.R")

# *****************************************************************************


# *****************************************************************************
# Finishing touches and export ---- 

# Merge all data frames together, add various date fields, filter to relevant FYs, insert rows for missing data
AllVisits <- rbind(Kura, HeritageImages, ManuscriptsOnline, Boopsie2019, Boopsie2020, RegionalSocial, Overdrive, HeritageSocial, Subscriptions, DX, AandR_enquiries, AandR_sessions, LibraryConnect) %>% 
  mutate(Date = as.Date(paste(Month, "01", Year, sep="/"), format="%b/%d/%Y")) %>% 
  complete(Date, nesting(Metric_type, Metric_source, Metric_group), fill = list(Metric = 0)) %>% 
  mutate(Month = case_when(is.na(Month) ~ format(Date, "%b"), !is.na(Month) ~ Month),
         Year = case_when(is.na(Year) ~ format(Date, "%Y"), !is.na(Year) ~ Year),
         FY = as.character(get_fy(Date)),
         Month_num = match(Month, month.abb),
         Month_number = case_when(Month_num > 6 ~ (Month_num)-6, Month_num < 7 ~ (Month_num)+6)
         ) %>% 
  select(-Month_num) %>% 
  filter(Date != as.Date(format(Sys.Date(), paste("%Y-%m", "01", sep="-"))) & FY %in% c("2019", "2020", "2021"))

#Calculate the change (# and %) compared to the same point the previous FY
AllVisits <- arrange(AllVisits, Metric_source, Month_number, FY) %>%
  group_by(Metric_source, Month) %>%
  dplyr::mutate(Change_num = Metric - lag(Metric, default = first(Metric)),
                Change_perc = Change_num/lag(Metric, default = first(Metric))) %>% 
  ungroup()

#Calculate the change (# and %) compared to the previous month
AllVisits <- arrange(AllVisits, Metric_source, FY, Month_number) %>%
  group_by(Metric_source) %>%
  dplyr::mutate(Change_month_num = Metric - lag(Metric, default = first(Metric)),
                Change_month_perc = Change_month_num/lag(Metric, default = first(Metric))) %>% 
  ungroup()

#Calculate the FYTD
AllVisits <- arrange(AllVisits, Metric_source, FY, Month_number) %>%
  group_by(Metric_source, FY) %>%
  dplyr::mutate(FYTD = cumsum(Metric)) %>% 
  ungroup()

#Calculate the change (# and %) compared to the previous FYTD
AllVisits <- arrange(AllVisits, Metric_source, Month_number, FY) %>%
  group_by(Metric_source, Month) %>%
  dplyr::mutate(Change_FYTD_num = FYTD - lag(FYTD, default = first(FYTD)),
                Change_FYTD_perc = Change_FYTD_num/lag(FYTD, default = first(FYTD))) %>% 
  ungroup()

# Change infinite values to zero
AllVisits[AllVisits == Inf] <- 0

#Archive the old data output and export the new data frame to a .csv file
file.rename("data/processed/AllVisits.csv", paste("data/processed/archived/AllVisits_", as.Date(file.info("data/processed/AllVisits.csv")$ctime), ".csv", sep=""))
AllVisits %>%
  select(Data_source, Metric_source, Month, Year, Metric,	Metric_type,	Metric_group,	Month_number,	FY,	Date,	Change_num,	Change_perc, Change_month_num, Change_month_perc, FYTD, Change_FYTD_num, Change_FYTD_perc) %>%
  write.csv("data/processed/AllVisits.csv", na="")

# *****************************************************************************
