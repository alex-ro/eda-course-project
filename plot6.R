setwd("~/workspace/eda-course-project/")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$year <- as.factor(nei$year)
nei$type <- as.factor(nei$type)

# making the assumption that motor vehicle sources are of type ON-ROAD
nei_motor <- nei[nei$fips %in% c("24510", "06037") & nei$type == "ON-ROAD", ]

#install.packages("quantmod")
library(quantmod)
library("ggplot2")
png("plot6.png", width=600)

total_emissions <- aggregate(nei_motor$Emissions,
                             by=list(nei_motor$year, nei_motor$fips), FUN=sum)
names(total_emissions) <- c("year", "fips", "total.pm")
total_emissions$fips <- as.factor(total_emissions$fips)

# calculate the rate of change
total_emissions$change.rate[total_emissions$fips == "24510"] <- Delt(total_emissions$total.pm[total_emissions$fips == "24510"]) * 100
total_emissions$change.rate[total_emissions$fips == "06037"] <- Delt(total_emissions$total.pm[total_emissions$fips == "06037"]) * 100
total_emissions$change.rate[is.na(total_emissions$change.rate)] <- 0

ggplot(total_emissions, aes(x=year, y=change.rate, fill=fips)) +
    geom_bar(stat="identity", position="dodge") +
    theme_bw() +
    geom_text(aes(label=paste0(floor(change.rate), "%")), position=position_dodge(width=1), vjust=0.5) +
    xlab("Years") +
    ylab("Rate of change (%)") +
    labs(fill="Location") +
    scale_fill_discrete(labels=c("Los Angeles", "Baltimore City")) +
    ggtitle("PM2.5 Emission changes from motor vehicle sources;\ncomparison between Baltimore City and Los Angeles")

dev.off()