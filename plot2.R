setwd("~/workspace/eda-course-project/")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
nei$year <- as.factor(nei$year)
nei_baltimore <- nei[nei$fips=="24510", ] #subset by fips, Baltimore City

png("plot2.png")

total_emissions <- aggregate(nei_baltimore$Emissions, by=list(nei_baltimore$year), FUN=sum)
names(total_emissions) <- c("year", "total.pm")
barplot(total_emissions$total.pm,
        space=1.5, col="blue", 
        names.arg=total_emissions$year,
        xlab="Years",
        ylab="PM2.5 emitted (tons)",
        main="Total emissions from PM2.5 by Year in Baltimore City",
        axis.lty = 1)

dev.off()