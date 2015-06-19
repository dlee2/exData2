#read in files and create merged dataset

NEI <- readRDS("pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("pm2.5/Source_Classification_Code.rds")
data <- merge(NEI, SCC, by.x = "SCC")

data$year <- as.factor(data$year)
#How many emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
motor <- grep("vehicle", data$SCC.Level.Two, ignore.case = TRUE)
motorData <- subset(data[motor,])
baltimoreMotor <- subset(motorData, fips == "24510")

library(ggplot2)
png("plot5.png", height = 480, width = 480)
g <- ggplot(baltimoreMotor, aes(x = year, y = Emissions))
g + geom_bar(stat = "identity", fill = "darkred") + labs(x = 'Year', title = "Baltimore Motor Emissions per Year")
dev.off()
