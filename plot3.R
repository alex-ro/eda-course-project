setwd("~/workspace/eda-course-project/")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$year <- as.factor(nei$year)
nei$type <- as.factor(nei$type)
nei_baltimore <- nei[nei$fips=="24510", ]

library("ggplot2")
png("plot3.png", width=800)

total_emissions <- aggregate(nei_baltimore$Emissions, by=list(nei_baltimore$year, nei_baltimore$type), FUN=sum)
names(total_emissions) <- c("year", "type", "total.pm")

ggplot(total_emissions, aes(x=year, y=total.pm, group=1)) +
    geom_bar(stat="identity", fill="blue") +
    facet_grid(. ~ type) +
    geom_line(colour="red", size=1) +
    geom_point(colour="red", size=3) +
    theme_bw() +
    xlab("Years") +
    ylab("PM2.5 emitted (tons)") +
    ggtitle("Total emissions from PM2.5 by Year and Type of source\nBaltimore City, Maryland")
    
dev.off()
