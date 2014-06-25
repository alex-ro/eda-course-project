setwd("~/workspace/eda-course-project/")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$year <- as.factor(nei$year)

png("plot1.png")

total_emissions <- aggregate(nei$Emissions, by=list(nei$year), FUN=sum)
names(total_emissions) <- c("year", "total.pm")
barplot(total_emissions$total.pm,
        space=1.5, col="blue",
        names.arg=total_emissions$year,
        xlab="Years",
        ylab="PM2.5 emitted (tons)",
        main="Total emissions from PM2.5 by Year in US",
        axis.lty = 1)

dev.off()
