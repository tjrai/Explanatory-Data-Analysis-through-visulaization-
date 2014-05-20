

## Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# read in the input files:
  # No need to read if already done in plot1
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sqldf package
library(sqldf)

# Read total Emissions for each year for all sources
Em_Md <- sqldf('select year "Year",fips "Baltimore",sum(Emissions) "Total" from NEI where fips="24510" group by year,fips')


# Set the margin size
par(mar=c(4,4,2,4))

png(filename="plot2.png",width=480,height=480)

# set the year interval by 3
at<-seq(from=1999,to=max(Em_Md$Year),by=3)
# set y axis range 
yrange <- c(min(Em_Md$Total),max(Em_Md$Total))
ticks <- pretty(yrange)
labels <- format(ticks,scientific=F)

# plot the graph without axis values
with(Em_Md,plot(Year,Total,type="l",xaxt="n",yaxt="n",ylim=yrange,ylab="",xlab=""))
# set the x axis (year) at the interval of 3 
axis(side=1,at=at,las=1,cex.axis = 0.8)
mtext("Year",1)
# set the y axis (PM25) with above label
axis(2,at=ticks,labels=labels,las=1,cex.axis=0.6)
mtext(expression("PM"[25]),2,cex=0.8)
# add title with Quesion 1 
title("Have total emissions from PM2.5 decreased in the Baltimore city from 1999 to 2008?",cex.main=0.6)

dev.off()