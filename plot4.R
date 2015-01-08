## This script creates the plot #4 and saves it in a PNG file called "plot4.png"

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
png(filename = "plot4.png",width = 480, height = 480, units = "px", bg = "transparent", pointsize=12,
	type = "cairo-png")

## sets the language to have week-days names in English
Sys.setlocale("LC_TIME", "en_US.UTF-8")

## prepares the plotting area
par(mfrow=c(2,2)) ## sets the 2x2 schema for the 4 plots

## produces the objects of class POSIXct associated to Date and Time, to use as x-coordinate
x_coord<-as.POSIXct(strptime(paste(consumptions$Date, consumptions$Time),"%d/%m/%Y %H:%M:%S"))

## draws the first plot in position (1,1)
plot(x_coord, consumptions$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## draws the second plot in position (1,2)
plot(x_coord, consumptions$Voltage, type="l", xlab="datetime", ylab="Voltage")

## draws the third plot in position (2,1)
plot(x_coord, consumptions$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(x_coord, consumptions$Sub_metering_2, col="red")
lines(x_coord, consumptions$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch="_",
       lwd=2, col=c("black", "red", "blue"), bty="n")

## draws the fourth plot in position (2,2)
plot(x_coord, consumptions$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## closes the graphics device png
dev.off()
