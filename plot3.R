## This script creates the plot #3 and saves it in a PNG file called "plot3.png"

## It first loads the package "data.table" containing the very fast fread() function.
library(data.table)

## Then with fread() it reads the content of the input file present in the working directory
## fread() allows to use as input a shell command that preprocesses the file (see ?fread), so
## only the lines that match the "^[12]\\/2\\/2007" regex are loaded into the data.frame

dataFile<-"household_power_consumption.txt"
consumptions <- fread(paste("grep ^[12]/2/2007", dataFile), na.strings = c("?", ""))

## it reads the names from the first line of the file and associates them to the data.table columns
setnames(consumptions, colnames(fread(dataFile, nrows=0)))

## opens the graphics device of png type
png(filename = "plot3.png",width = 480, height = 480, units = "px", bg = "transparent", pointsize=12,
	type = "cairo-png")

## prepares the plotting area
par(pin=c(4.8,4.8)) ## sets the plotting area to a square of 4.8"x4.8"
par(ps=12) ## sets the font size
par(mar=c(5,4,4,2))
par(mgp=c(3,1,0)) ## sets the default margins line for the axis title, axis labels and lines
Sys.setenv(LANG = "en_US.UTF-8")  ## sets the language to have week-days names in English

## produces the objects of class POSIXct associated to Date and Time, to use as x-coordinate
x_coord<-as.POSIXct(strptime(paste(consumptions$Date, consumptions$Time),"%d/%m/%Y %H:%M:%S"))

## prints the graph on the active device
plot(x_coord, consumptions$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(x_coord, consumptions$Sub_metering_2, col="red")
lines(x_coord, consumptions$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch="_" ,lwd=3, col=c("black", "red", "blue"))

## closes the graphics device png
dev.off()