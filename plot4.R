require(ggplot2)

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
SCC <- readRDS("Source_Classification_Code.rds")
}

## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# First get the SCCs for Coal Sources
coalSCC <- SCC[grep("*coal*",SCC$Short.Name, ignore.case=TRUE),"SCC"]

# Subset to "Baltimore" data
NEICoal <-  subset(NEI, NEI$SCC %in% coalSCC)

NEICoalAggr <- aggregate(NEICoal[, 'Emissions'], by=list(NEICoal$year), sum)
colnames(NEICoalAggr) <- c('Year', 'Emissions')


png(filename="plot4.png",width=800,height=600)

plotpng <- ggplot(data=NEICoalAggr, aes(x=Year, y=Emissions/1000)) + 
    geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
    ggtitle(expression('Total Emissions of PM'[2.5])) + 
    ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
    geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
    theme(legend.position='none')
    

print(plotpng)

dev.off()