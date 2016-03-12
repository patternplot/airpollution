if(!exists("NEI")){
NEI <- readRDS("summarySCC_PM25.rds")
}

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

yearpol <- tapply(NEI$Emissions, NEI$year, sum)

png(filename="plot1.png",width=800,height=600)

barplot(yearpol, xlab="Year",
        ylab ="Total Emission Levels",
        main ="Changes in Total Emission Levels between 1999 and 2008",
        col=yearpol, ylim=c(0,max(yearpol)))
dev.off()