## Question 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

#read in the input files
# No need to read if already done in other plots
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# read the total emissions for Baltimore City by Source type, year 
library(sqldf)
bal_yr <- sqldf('select type,year "Year",fips "Baltimore",sum(Emissions) "Total" from NEI where fips="24510" group by type,year,fips order by type,year')

#plot the data using ggplot2
library(ggplot2)
g <- ggplot(bal_yr,aes(Year,Total))
g + geom_point() +facet_grid(type~.) + labs(title="Emissions of Source Types from 1999–2008") + labs(y=expression(PM[2.5]))+geom_smooth(linetype=3,method="lm",se=F,size=1)+ theme_bw(base_family="Times")

