## This script creates the plot #1 and saves it in a PNG file called "plot1.png"

## It defines and uses the function "read_select_data()" to read the data into
## a dataframe called "consumptions" and to select only those from 1/2/2007 to 2/2/2007

## The function read_select_data() goes through the following steps:
## 1. reads the data from the source file into a dataframe called "power.consumption"
##    directly transforming into NA's all the "?" that code the missing values
## 2. selects only the data whose Date equals "1/2/2207" or "2/2/2007"
## 3. returns the "power.consumption" dataframe with the selected data

read_select_data <- function(){
  file.nm="household_power_consumption.txt"
  ## step 1
  power.consumption<-read.table(file.nm, header=TRUE, stringsAsFactors=FALSE, sep=";",na.strings = "?")
  ## step 2
  power.consumption<-subset(power.consumption, (Date=="1/2/2007")|(Date=="2/2/2007"))
  ## step 3
  power.consumption
}

## data.frame construction
consumptions <- read_select_data()

## opens the graphics device of png type
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", bg = "transparent",pointsize=12,
    type = c("cairo", "cairo-png", "Xlib", "quartz"))

## prepares the plotting area
par(ps=12) ## sets the font size
par(pin=c(4.8,4.8)) ## sets the plotting area to a square of 4.8"x4.8"
par(mar=c(5,4,3,2)) ## sets the margins
par(mgp=c(3,1,0))   ## sets the margin line for the axis title, axis labe and axis line
## prints the histogram on the active device
with(consumptions, hist(Global_active_power, main="Global Active Power", col = "red", xlab="Global Active Power (kilowatts)"))
## closes the graphics device png
dev.off()
