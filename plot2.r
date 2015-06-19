#read in files and create merged dataset

NEI <- readRDS("pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("pm2.5/Source_Classification_Code.rds")
data <- merge(NEI, SCC, by.x = "SCC")

data$year <- as.factor(data$year)
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
subsettedData <- subset(data, fips == "24510")
baltimoreEmissions <- tapply(data$Emissions, data$year, sum)
library(ggplot2)
png("plot2.png", height = 480, width = 480)
barplot(baltimoreEmissions, xlab = "Year", ylab = "Emissions", main = "Total Baltimore Emissions per Year", col = "blue")
dev.off()
