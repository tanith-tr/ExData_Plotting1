# Exploratory Data Analysis Course Project 1 - Plot 4

# This assignment uses “Individual household electric power consumption Data Set” data from 
# the UC Irvine Machine Learning Repository.

# The dataset can be downloaded from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# The data file must be placed in the working directory.

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 


# Set locale time to English if your local language is different
Sys.setlocale("LC_TIME", "English") 

# Read the data 
dataAll <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".", 
                      stringsAsFactors = FALSE, na.strings = "?", 
                      colClasses = c(rep("character",2), rep("numeric",7)))

# Subset the data of the dates 2007-02-01 and 2007-02-02 and clear dataAll from workspace
dataSub <- subset(dataAll, Date == c("1/2/2007") | Date == c("2/2/2007"))
rm(dataAll)

# Create DateTime variable
dataSub$DateTime <- paste(dataSub$Date, dataSub$Time, sep = " ")

#Convert date and time variables
dataSub$Date <- as.Date(dataSub$Date, "%d/%m/%Y")
dataSub$DateTime <- strptime(dataSub$DateTime, "%d/%m/%Y %H:%M:%S")

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfcol=c(2,2))
with(dataSub, {
        plot(DateTime, Global_active_power, xlab ="", ylab = "Global Active Power", type ="l")
        plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
        lines(DateTime, Sub_metering_1, col = "black")
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
        legend("topright", col = c("black","red","blue"), lty = 1,  
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
        plot(DateTime, Voltage, xlab= "datetime", ylab = "Voltage", type = "l")
        plot(DateTime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
})
dev.off()
