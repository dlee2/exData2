#read in files and create merged dataset

NEI <- readRDS("pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("pm2.5/Source_Classification_Code.rds")
data <- merge(NEI, SCC, by.x = "SCC")

data$year <- as.factor(data$year)
#Across the United States, how many emissions from coal combustion-related sources changed from 
#1999-2008
library(ggplot2)
coalRelated <- grep("coal", data$Short.Name, ignore.case = TRUE)
coalData <- subset(data[coalRelated,])

png("plot4.png", height = 480, width = 480)
g <- ggplot(coalData, aes(x = year, y = Emissions))
g + geom_bar(stat = "identity", fill = "lightblue") + labs(x = "Year", y = expression('Total PM'[2.5]*" Emissions"), title = "Coal related Emissions")
dev.off()
