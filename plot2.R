if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

# Subset to "Baltimore" data
NEIBaltimore <-  subset(NEI, NEI$fips == "24510" )

yearpol <- tapply(NEIBaltimore$Emissions, NEIBaltimore$year, sum)

png(filename="plot2.png",width=800,height=600)

barplot(yearpol, xlab="Year", ylab ="Total Emission Levels in Baltimore",
        main ="Changes in Total Emission Levels in BALTIMORE between 1999 and 2008",
        col=yearpol, ylim=c(0,max(yearpol)))
dev.off()