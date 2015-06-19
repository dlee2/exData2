#read in files and create merged dataset

NEI <- readRDS("pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("pm2.5/Source_Classification_Code.rds")
data <- merge(NEI, SCC, by.x = "SCC")

data$year <- as.factor(data$year)
#Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) variable, which of these
#four souces have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in
#emissions from 1999-2008? 
library(ggplot2)
subsettedData <- subset(data, fips == "24510")
png("plot3.png", height = 480, width = 480)
g <- ggplot(subsettedData, aes(x = year, y = Emissions))
g + geom_bar(fill = "orange", stat = "identity") + facet_grid(.~type) + labs(x = "Year", title = "Baltimore Emissions By Type")
dev.off()
