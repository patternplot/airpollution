require(ggplot2)

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
 

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?


# Subset to "Baltimore" and "LA" data
NEISubset <-  subset(NEI, fips %in% c("24510" ,"06037") & type == "ON-ROAD")

aggrYearCity <- aggregate(Emissions ~ year+fips, NEISubset, sum)

aggrYearCity$fips = gsub("24510", "Balitmore", aggrYearCity$fips)
aggrYearCity$fips = gsub("06037", "Los Angeles", aggrYearCity$fips)

png(filename="plot6.png",width=800,height=600)

plotpng <- ggplot(data=aggrYearCity, aes(x=as.factor(year), y=Emissions)) +
    geom_bar(stat="identity", aes(fill=as.factor(year))) +
    guides(fill=F) + 
    ggtitle('Total Emissions from Motor Vehicle Sources in Baltimore & LA') + 
    ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
    facet_grid(. ~ fips) +
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2)) +
    scale_fill_brewer(palette = "Set1")


print(plotpng)

dev.off()