NEI <- readRDS("proj_data/summarySCC_PM25.rds")
SCC <- readRDS("proj_data/Source_Classification_Code.rds")


# Coal data
cc <- SCC[grep("*Comb(.)*Coal*", SCC$Short.Name,ignore.case=TRUE),1]
# Filter all the rows include only coal combustion   
fcc <- NEI[NEI$SCC %in% cc,]

pm0 <- with(fcc, tapply(fcc$Emissions,fcc$year,sum)) 

df <- data.frame(emission=as.numeric(pm0),year=as.numeric(names(pm0)))

png(filename = 'plot4.png')
par(mar=c(4,4,2,2),las=1)

plot(df$year,df$emission,
     xlab="Year", type="b",
     ylab=expression('Total PM'[2.5]*' emission in '~bold("kilo")~' tons'),
     main=expression('PM'[2.5]*' emission from Coal Combustions sources per year'),
     xaxt="n",yaxt="n")

axis(1,at=df$year)
axis(2,at=df$emission)        


dev.off()

