## This script creates the plot #2 and saves it in a PNG file called "plot2.png"

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
png(filename = "plot2.png",width = 480, height = 480, units = "px", bg = "transparent", pointsize=12,
	type = "cairo-png")

## sets the language to have week-days names in English
Sys.setlocale("LC_TIME", "en_US.UTF-8")

## prepares the plotting area
par(pin=c(4.8,4.8)) ## sets the plotting area to a square of 4.8"x4.8"
par(ps=12) ## sets the font size
par(mar=c(5,4,4,2))
par(mgp=c(3,1,0)) ## sets the default margins line for the axis title, axis labels and lines

## produces the objects of class POSIXct associated to Date and Time, to use as x-coordinate
x_coord<-as.POSIXct(strptime(paste(consumptions$Date, consumptions$Time),"%d/%m/%Y %H:%M:%S"))

## prints the graph on the active device
plot(x_coord, consumptions$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## closes the graphics device png
dev.off()