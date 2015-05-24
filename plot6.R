NEI <- readRDS("proj_data/summarySCC_PM25.rds")
SCC <- readRDS("proj_data/Source_Classification_Code.rds")

x = SCC[grepl("motor", SCC$Short.Name, ignore.case=TRUE),]
NEI.subset <- NEI[(NEI$SCC %in% x$SCC) & (NEI$fips == "24510"), ]
NEI.subset <- NEI.subset[, c(4, 6)]
NEI.aggdata <-aggregate(NEI.subset, by=list(year = NEI.subset$year), FUN=sum, na.rm=TRUE)
NEI.aggdata.Baltimore <- NEI.aggdata[, c(1, 2)]

NEI.subset <- NEI[(NEI$SCC %in% x$SCC) & (NEI$fips == "06037"), ]
NEI.subset <- NEI.subset[, c(4, 6)]
NEI.aggdata <-aggregate(NEI.subset, by=list(year = NEI.subset$year), FUN=sum, na.rm=TRUE)
NEI.aggdata.LosAngles <- NEI.aggdata[, c(1, 2)]

png('plot6.png')
g <- ggplot() + 
  geom_line(data = NEI.aggdata.Baltimore, aes(x = year, y = Emissions, color = "Baltimore")) +
  geom_line(data = NEI.aggdata.LosAngles, aes(x = year, y = Emissions, color = "Los Angeles County"))  +
  xlab('year') +
  ylab('emissions') +
  labs(color="Legend")

print(g)
dev.off()

