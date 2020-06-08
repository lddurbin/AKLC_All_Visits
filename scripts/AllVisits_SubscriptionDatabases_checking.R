#prepare sub DBs for analysis in Power BI
AllSubscriptions <- Subscriptions %>% melt()
AllSubscriptions$Month <- month.abb[as.numeric(substr(AllSubscriptions$variable, 5, 6))]
AllSubscriptions$Year <- substr(AllSubscriptions$variable, 1, 4)
AllSubscriptions$Date <- as.Date(paste(AllSubscriptions$Year, AllSubscriptions$Month, "01", sep="-"), format="%Y-%b-%d")
AllSubscriptions$Metric_type <- gsub('[0-9]+', '', word(AllSubscriptions$variable, 2, sep="_"))

#rank the databases by the total number of sessions over the last 12 months, in order to sort the slicer in Power BI
latestRanking <- filter(AllSubscriptions, Date>=as.Date(format(Sys.Date(),"%Y-%m-01")) %m-% months(12) & Metric_type=="Sessions")
latestRanking <- aggregate(list(value=as.numeric(latestRanking$value)), by=list(Database=latestRanking$Database), FUN=sum, na.rm=T) %>%
  arrange(desc(value))
latestRanking$rank <- seq.int(nrow(latestRanking))

AllSubscriptions <- left_join(AllSubscriptions, latestRanking[,c(1,3)], by="Database")
AllSubscriptions %>% select(Database, Date, Metric_type, value, rank) %>% write_csv("data/processed/SubscriptionDatabases.csv", na="")