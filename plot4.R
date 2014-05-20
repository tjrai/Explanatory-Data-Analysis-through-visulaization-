## Question 4 : 
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# read in input files
# No need to read if already done in other plots
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# read the Emissions for Coal Combustion sources by year
library(sqldf)
cc <- sqldf('select Sum(Emissions) "Sum", year from SCC,NEI where Short_Name like "%Coal%" and Short_Name like "%Comb%" and SCC.SCC = NEI.SCC group by year')

# Set the margin size
par(mar=c(4,4,2,4))

# Send the plot to ping device
png(filename="plot4.png",width=480,height=480)

# set the year interval by 3
at <- seq(from=1999,to=max(cc$year),by=3)
# set y axis range 
yrange <- c(min(cc$Sum),max(cc$Sum))
ticks <- pretty(yrange)
labels <- format(ticks,scientific=F)

# plot the graph without axis values
with(cc,plot(year,Sum,type="l",xaxt="n",yaxt="n",ylim=yrange,ylab="",xlab=""))
# set the x axis (year) at the interval of 3 
axis(side=1,at=at,las=1,cex.axis = 0.8)
mtext("Year",1)
# set the y axis (PM25) with above label
axis(2,at=ticks,labels=labels,las=1,cex.axis=0.6)
mtext(expression("PM"[25]),2,cex=0.8)
# add title with Quesion 1 
title("Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?",cex.main=0.6)

dev.off()