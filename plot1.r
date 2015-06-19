#read in files and create merged dataset

NEI <- readRDS("pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("pm2.5/Source_Classification_Code.rds")
data <- merge(NEI, SCC, by.x = "SCC")

data$year <- as.factor(data$year)
#Have total emssions from PM2.5 decreased in the US from 1999 to 2008?
totalEmissions <- tapply(data$Emissions,data$year, sum)
png("plot1.png",height = 480, width = 480)
barplot(totalEmissions, xlab = "Year", ylab = "Emissions", main = "Total Emissions Per Year", col = "red ")
dev.off
