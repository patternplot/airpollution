require(ggplot2)

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 

# Subset to "Baltimore" data
NEIBaltimore <-  subset(NEI, NEI$fips == "24510" )

# Sum by Year and Type
aggrYearType <- aggregate(Emissions ~ year+type, NEIBaltimore, sum)


png(filename="plot3.png",width=800,height=600)

plotpng <- ggplot(aggrYearType, aes(factor(year), Emissions, fill = type)) +
           geom_bar(stat="identity", position = "dodge") +
           scale_fill_brewer(palette = "Set1") +
           xlab("Year") + ylab("Total Emissions in Baltimore by Year") +
           ggtitle("Total Emissions in Baltimore by Type between 1999-2008") 

print(plotpng)
dev.off()