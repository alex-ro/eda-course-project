setwd("~/workspace/eda-course-project/")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$year <- as.factor(nei$year)
scc$SCC <- as.character(scc$SCC)

# get the SCC ids coming from coal combustion-related sources
# making the assumption that coal combustion-related sources are fields from 
# scc$EI.Sector that contain the word 'Coal'
scc_coal <- scc[grepl("Coal", scc$EI.Sector), c("SCC")]
#subset nei with SCCs from coal (scc_coal)
nei_coal <- nei[nei$SCC %in% scc_coal, ]

library("ggplot2")
png("plot4.png")

total_emissions <- aggregate(nei_coal$Emissions, by=list(nei_coal$year), FUN=sum)
names(total_emissions) <- c("year", "total.pm")
ggplot(total_emissions, aes(x=year, y=total.pm, group=1)) +
    geom_bar(stat="identity", fill="blue", width=0.5) +
    geom_line(colour="red", size=1) +
    geom_point(colour="red", size=3) +
    theme_bw() +
    xlab("Years") +
    ylab("PM2.5 emitted (tons)") +
    ggtitle("Total emissions from PM2.5 generated from\ncoal combustion-related sources by Year in US")

dev.off()
