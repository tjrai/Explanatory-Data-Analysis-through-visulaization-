## Question 5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

# read in input files
# no need to read if already done in previous plots
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# read in Total Emissions by year for motor vehicle sources
library(sqldf)
MV <- sqldf('select Sum(Emissions) "Sum", year from SCC,NEI where upper(Short_Name) like "%VEHICLE%" and SCC.SCC = NEI.SCC and fips = "24510" group by year')

# Set the margin size
par(mar=c(4,4,2,4))

# open the PNG device
png(filename="plot5.png",width=480,height=480)

# set the year interval by 3
at <- seq(from=1999,to=max(MV$year),by=3)
# set y axis range 
yrange <- c(min(MV$Sum),max(MV$Sum))
ticks <- pretty(yrange)
labels <- format(ticks,scientific=F)

# plot the graph without axis values
with(MV,plot(year,Sum,type="l",xaxt="n",yaxt="n",ylim=yrange,ylab="",xlab=""))
# set the x axis (year) at the interval of 3 
axis(side=1,at=at,las=1,cex.axis = 0.8)
mtext("Year",1)
# set the y axis (PM25) with above label
axis(2,at=ticks,labels=labels,las=1,cex.axis=0.6)
mtext(expression("PM"[25]),2,cex=0.8)
# add title with Quesion 1 
title("How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?",cex.main=0.6)

# close the PNG device
dev.off()