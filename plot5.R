setwd("~/workspace/eda-course-project/")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$year <- as.factor(nei$year)
nei$type <- as.factor(nei$type)

# making the assumption that motor vehicle sources are of type ON-ROAD
nei_motor_baltimore <- nei[nei$type == "ON-ROAD" & nei$fips=="24510", ]

library("ggplot2")
png("plot5.png")

total_emissions <- aggregate(nei_motor_baltimore$Emissions,
                        by=list(nei_motor_baltimore$year), FUN=sum)
names(total_emissions) <- c("year", "total.pm")
ggplot(total_emissions, aes(x=year, y=total.pm, group=1)) +
    geom_bar(stat="identity", fill="blue", width=0.5) +
    geom_line(colour="red", size=1) +
    geom_point(colour="red", size=3) +
    theme_bw() +
    xlab("Years") +
    ylab("PM2.5 emitted (tons)") +
    ggtitle("Total emissions from PM2.5 generated
            from motor vehicle sources by Year
            in Baltimore City, Maryland")

dev.off()
