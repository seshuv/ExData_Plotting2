NEI <- readRDS("proj_data/summarySCC_PM25.rds")
SCC <- readRDS("proj_data/Source_Classification_Code.rds")

# baltimore data and set the years
baltimoreData.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

#Subset data per year
baltimoreData$year <- factor(baltimoreData$year, levels = c('1999', '2002', '2005', '2008'))

# Aggregates
baltimoreData.df <- aggregate(baltimoreData.onroad[, 'Emissions'], by = list(baltimoreData.onroad$year), sum)
colnames(baltimoreData.df) <- c('year', 'Emissions')

png('plot5.png')
g <- ggplot(data = baltimoreData.df, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year), stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))
print(g)
dev.off()

