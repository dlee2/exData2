#read in files and create merged dataset

NEI <- readRDS("pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("pm2.5/Source_Classification_Code.rds")
data <- merge(NEI, SCC, by.x = "SCC")

data$year <- as.factor(data$year)
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in
#Los Angeles County. Which city has seen greater changes over time in emissions?
motor <- grep("vehicle", data$SCC.Level.Two, ignore.case = TRUE)
motorData <- subset(data[motor,])
Baltimore <- subset(motorData, fips == "24510")
Baltimore$city <- "Baltimore City"

la <- subset(motorData, fips == "06037")
la$city <- "Los Angeles"

laBaltimore <- rbind(Baltimore,la)

library(ggplot2)


png("plot6.png", height = 480, width = 480)
g <- ggplot(laBaltimore, aes(x = year, y = Emissions))
g + geom_bar(aes(fill = year), stat = "identity") + facet_grid(.~city) + labs(title = "Motor Vehicle Emissions in Baltimore and Los Angeles",x = "Year")
dev.off()
