#Question 1:
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.

# Read in the input files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sqldf package
library(sqldf)

# Read total Emissions for each year for all sources
Em_yr<- sqldf('select year,sum(Emissions) "Total" from NEI group by year')

# Set the margin size
 par(mar=c(4,4,2,4))
# Open PNG device, create "plot1.png" in the working directory
png(filename="plot11.png",width=480,height=480)

# set the year interval by 3
 at<-seq(from=1999,to=max(Em_yr$year),by=3)
# set y axis range 
yrange <- c(min(Em_yr$Total),max(Em_yr$Total))
 ticks <- pretty(yrange)
 labels <- format(ticks,scientific=F)

# plot the graph without axis values
with(Em_yr,plot(year,Total,type="l",xaxt="n",yaxt="n",ylim=yrange,ylab="",xlab=""))
# set the x axis (year) at the interval of 3 
axis(side=1,at=at,las=1,cex.axis = 0.8)
mtext("Year",1)
# set the y axis (PM25) with above label
axis(2,at=ticks,labels=labels,las=1,cex.axis=0.6)
mtext(expression("PM"[25]),2,cex=0.8)
# add title with Quesion 1 
title("Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?",cex.main=0.6)

# close the device
dev.off()