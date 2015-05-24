#NEI <- readRDS("proj_data/summarySCC_PM25.rds")

#SCC <- readRDS("proj_data/Source_Classification_Code.rds")

Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
Emissions$PM <- round(Emissions[, 2] / 1000, 2)

png(filename = "plot1.png")
barplot(Emissions$PM, names.arg = Emissions$Group.1, main = 'Total Emission of PM2.5', xlab = 'Year', ylab ='PM2.5 in Kilotons')
dev.off()

