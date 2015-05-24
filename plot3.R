require(ggplot2)
NEI <- readRDS("proj_data/summarySCC_PM25.rds")
SCC <- readRDS("proj_data/Source_Classification_Code.rds")


# baltimore data and set the years
baltimoreData <- subset(NEI, fips == "24510")

#Subset data per year
baltimoreData$year <- factor(baltimoreData$year, levels = c('1999', '2002', '2005', '2008'))

#subset data for types point,nonpoint,on-road,non-road
pt <- subset(baltimoreData, type=="POINT")
npt <- subset(baltimoreData, type=="NONPOINT")
rd <- subset(baltimoreData, type=="ON-ROAD")
nrd <- subset(baltimoreData, type="NON-ROAD")

#sum the total emission per year for each type 
ptpm <- with(pt, tapply(pt$Emissions,pt$year,sum))
nptpm <- with(npt, tapply(npt$Emissions,npt$year,sum))
rdpm <- with(rd, tapply(rd$Emissions,rd$year,sum))
nrdpm <- with(nrd, tapply(nrd$Emissions,nrd$year,sum))

#construct data frame with all emissions per year for each type
baltimoreDataFrame <- data.frame(emission=as.numeric(ptpm),year=as.numeric(names(ptpm)),type=rep(c("POINT"),each=4))
baltimoreDataFrame <- rbind(baltimoreDataFrame,data.frame(emission=as.numeric(nptpm),year=as.numeric(names(nptpm)),type=rep(c("NONPOINT"),each=4)))
baltimoreDataFrame <- rbind(baltimoreDataFrame,data.frame(emission=as.numeric(rdpm),year=as.numeric(names(rdpm)),type=rep(c("ON-ROAD"),each=4)))
baltimoreDataFrame <- rbind(baltimoreDataFrame,data.frame(emission=as.numeric(nrdpm),year=as.numeric(names(nrdpm)),type=rep(c("NON-ROAD"),each=4)))


#plot
g <- ggplot(baltimoreDataFrame, aes(x=year, y=emission)) + geom_line() + geom_point() 
g <- g + facet_grid(. ~ type) + scale_y_continuous(breaks=baltimoreDataFrame$emission)
g <- g + scale_x_continuous(breaks=baltimoreDataFrame$year) 
g <- g + labs(x="Year", y=expression('Total PM2.5 emission in tons'), 
              title=expression('Total PM2.5 mission per year for each type in Baltimore'))

png("plot3.png")
print(g)        
dev.off()


