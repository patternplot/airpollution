require(ggplot2)

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}


## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Subset to "Baltimore" and "ON-ROAD" source data
NEIBaltimoreOnRoad <-  subset(NEI, fips == "24510" & type == "ON-ROAD")

NEIBaltimoreOnRoadAggr <- aggregate(NEIBaltimoreOnRoad[, 'Emissions'], by=list(NEIBaltimoreOnRoad$year), sum)
colnames(NEIBaltimoreOnRoadAggr) <- c('Year', 'Emissions')


png(filename="plot5.png",width=800,height=600)

plotpng <- ggplot(data=NEIBaltimoreOnRoadAggr, aes(x=as.factor(Year), y=Emissions)) +
    geom_bar(stat="identity", aes(fill=as.factor(Year))) +
    guides(fill=F) + 
    ggtitle('Total Emissions from Motor Vehicle Sources in Baltimore City, Maryland') + 
    ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2)) +
    scale_fill_brewer(palette = "Set1")


print(plotpng)

dev.off()