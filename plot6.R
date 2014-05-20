## Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# read in the input data
# no need to read if already done in other plots
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# read the total Emissions for Los Angeles and Baltimore Cities by year
library(sqldf)
Ba_La <- sqldf('select Emissions, year,fips from SCC join NEI USING(SCC) where upper(EI_Sector) like "%VEHICLE%" and fips in ("06037","24510") order by fips,year')
BL <- sqldf('select year,sum(Emissions) "Sum",fips from Ba_La group by year,fips order by fips,year')  

# Set the margin size
par(mar=c(4,4,2,4))

# plot the data in ggplot2
library(ggplot2)
gg <- ggplot(BL, aes(year,Sum))
gg + geom_point(aes(color=fips),size=3,alpha=1/2) + facet_grid(. ~ fips) + labs(title="Emissions from motor vehicle sources in Los Angeles and Baltimore cities") + labs(y=expression(PM[2.5]))+geom_smooth(size =2,linetype=3,method="lm",se=F) + theme_bw()


