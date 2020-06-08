#get the regional social FY2019 and FY2020 data
RegionalSocial2019 <- read_excel(AllVisits.files.local["RegionalSocial2019"])
RegionalSocial2020 <- read_excel(AllVisits.files.local["RegionalSocial2020"])

#Clean and summarise the FY2019 regional social media data
RegionalSocial2019.reshaped <- RegionalSocial2019[1:(length(RegionalSocial2019)-1)] %>% melt()
RegionalSocial2019.reshaped$Month <- getMonth(excel_numeric_to_date(as.numeric(as.character.factor(RegionalSocial2019.reshaped$variable))))
RegionalSocial2019.reshaped$Year <- getYear(excel_numeric_to_date(as.numeric(as.character.factor(RegionalSocial2019.reshaped$variable))))
RegionalSocial2019.metrics <- subset(RegionalSocial2019.reshaped, RegionalSocial2019.reshaped$...1 %in% c("Total social post engagement", "Blog page views", "Total video views (includes YouTube)", "Sound Cloud podcast listens"))
RegionalSocial2019.metrics$'Metric_source' <- paste("Regional social media", RegionalSocial2019.metrics$...1)
RegionalSocial2019.metrics$Metric_source <- mapvalues(RegionalSocial2019.metrics$Metric_source, c("Regional social media Blog page views (Libraries + Heritage et AL)", "Regional social media Total video views (includes YouTube)", "Regional social media Total social post engagement", "Regional social media Sound Cloud podcast listens", "Regional social media YouTube views", "Regional social media Blog page views"), c("Regional social media blog page", "Regional social media YouTube", "Regional social media Facebook, Twitter, Instagram", "Regional social media Sound Cloud podcast", "Regional social media YouTube", "Regional social media blog page"))
RegionalSocial2019.metrics$'Data_source' <- AllVisits.files.local["RegionalSocial2019"]
colnames(RegionalSocial2019.metrics)[1:3] <- c("Metric_type", "variable", "Metric")
RegionalSocial2019.metrics$Metric_type[RegionalSocial2019.metrics$Metric_source == "Regional social media Facebook, Twitter, Instagram"] <- "Engagement"
RegionalSocial2019.metrics$Metric_type[RegionalSocial2019.metrics$Metric_source == "Regional social media YouTube"] <- "Views"
RegionalSocial2019.metrics$Metric_type[RegionalSocial2019.metrics$Metric_source == "Regional social media blog page"] <- "Views"
RegionalSocial2019.metrics$Metric_type[RegionalSocial2019.metrics$Metric_source == "Regional social media Sound Cloud podcast"] <- "Listens"
RegionalSocial2019.aggregate <- RegionalSocial2019.metrics[,-2]
RegionalSocial2019.aggregate$Metric_group <- "Online visits/interactions"

#Clean and summarise the FY2020 regional social media data
RegionalSocial.trimmed <- RegionalSocial2020[, colSums(is.na(RegionalSocial2020)) < 10]
RegionalSocial.reshaped <- RegionalSocial.trimmed[1:(length(RegionalSocial.trimmed)-1)] %>% melt()
RegionalSocial.reshaped$Month <- format(excel_numeric_to_date(as.numeric(as.character.factor(RegionalSocial.reshaped$variable))), "%b")
RegionalSocial.reshaped$Year <- format(excel_numeric_to_date(as.numeric(as.character.factor(RegionalSocial.reshaped$variable))), "%Y")
RegionalSocial.metrics <- subset(RegionalSocial.reshaped, RegionalSocial.reshaped$...1 %in% c("Total social post engagement", "Blog page views (Libraries + Heritage et AL)", "Total video views (includes YouTube)", "Sound Cloud podcast listens"))
RegionalSocial.metrics$Metric_source <- paste("Regional social media", RegionalSocial.metrics$...1)
RegionalSocial.metrics$Metric_source <- mapvalues(RegionalSocial.metrics$Metric_source, c("Regional social media Blog page views (Libraries + Heritage et AL)", "Regional social media Total video views (includes YouTube)", "Regional social media Total social post engagement", "Regional social media Sound Cloud podcast listens", "Regional social media YouTube views"), c("Regional social media blog page", "Regional social media YouTube", "Regional social media Facebook, Twitter, Instagram", "Regional social media Sound Cloud podcast", "Regional social media YouTube"))
RegionalSocial.metrics$...1[RegionalSocial.metrics$Metric_source == "Regional social media Facebook, Twitter, Instagram"] <- "Engagement"
RegionalSocial.metrics$...1[RegionalSocial.metrics$Metric_source == "Regional social media YouTube"] <- "Views"
RegionalSocial.metrics$...1[RegionalSocial.metrics$Metric_source == "Regional social media blog page"] <- "Views"
RegionalSocial.metrics$...1[RegionalSocial.metrics$Metric_source == "Regional social media Sound Cloud podcast"] <- "Listens"
RegionalSocial.metrics$'Data_source' <- AllVisits.files.local["RegionalSocial2020"]
colnames(RegionalSocial.metrics)[1:3] <- c("Metric_type", "variable", "Metric")
RegionalSocial.aggregate <- RegionalSocial.metrics[,-2]
RegionalSocial.aggregate$Metric_group <- "Online visits/interactions"