NEI <- readRDS("proj_data/summarySCC_PM25.rds")
SCC <- readRDS("proj_data/Source_Classification_Code.rds")

# baltimore data
baltimoreData <- subset(NEI, fips == "24510")

png(filename = 'plot2.png')

# Total Emissions
total_emissions <- tapply(X = baltimoreData$Emissions, INDEX = baltimoreData$year, FUN = sum)
lines(stats::lowess(total_emissions))

plot(total_emissions, main = 'Total Emission in Baltimore City', xlab = 'Year', ylab = 'PM2.5')

dev.off()

