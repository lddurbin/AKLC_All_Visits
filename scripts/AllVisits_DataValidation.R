# Check when we last got data for each metric
AllVisits1.3 <- aggregate(list(Metric=AllVisits1.2$Metric), by=list(Metric_name=paste(AllVisits1.2$Metric_source, tolower(AllVisits1.2$Metric_type), sep=" "), Month=AllVisits1.2$Month, Year=AllVisits1.2$Year, FY=AllVisits1.2$FY), FUN=sum)
AllVisits1.3$Date <- as.Date(paste("01", AllVisits1.3$Month, AllVisits1.3$Year, sep="-"), "%d-%b-%Y")
Latest <- aggregate(AllVisits1.3$Date, by=list(AllVisits1.3$Metric_name), FUN=max)
Latest <- Latest[order(Latest$x),]

# Get the FY2019 overall metric
AllVisits2019 <- filter(AllVisits1.2, AllVisits1.2$FY=="2019")
AllVisits2019.aggregate <- aggregate(list(Metric=AllVisits2019$Metric), by=list(Metric_name=paste(AllVisits2019$Metric_source, tolower(AllVisits2019$Metric_type), sep=" ")), FUN=sum, na.rm=T)
FY19_total <- (paste("FY19 total:", prettyNum(sum(AllVisits2019.aggregate$Metric, na.rm=T), big.mark = ",")))