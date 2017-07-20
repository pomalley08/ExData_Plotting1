################################################################################
# Course: Exploratory Data Analysis
# Title:  Week 1 Programming Assignment - Create plot2.png
# Author: Patrick O'Malley
# Date:   7/20/17
################################################################################

# load package
library(dplyr)
library(lubridate)

# read in data -----------------------------------------------------------------
house_power <- read.csv2("household_power_consumption.txt", na.strings = "?", 
                         stringsAsFactors = FALSE)

# convert to correct classes ---------------------------------------------------
str(house_power)

house_power$date_time <- paste(house_power$Date, house_power$Time)
house_power$date_time <- dmy_hms(house_power$date_time)

house_power <- select(house_power, -c(Date, Time))
house_power$Global_active_power <- as.numeric(house_power$Global_active_power)
house_power$Global_reactive_power <- as.numeric(house_power$Global_reactive_power)
house_power$Voltage <- as.numeric(house_power$Voltage)
house_power$Global_intensity <- as.numeric(house_power$Global_intensity)
house_power$Sub_metering_1 <- as.numeric(house_power$Sub_metering_1)
house_power$Sub_metering_2 <- as.numeric(house_power$Sub_metering_2)
house_power$Sub_metering_3 <- as.numeric(house_power$Sub_metering_3)
str(house_power)

# Filter to dates of interest --------------------------------------------------
house_power$Date <- as.Date(house_power$date_time)
feb_power <- filter(house_power, Date == "2007-02-01" | Date == "2007-02-02")
feb_power <- arrange(feb_power, date_time)
summary(feb_power$date_time)
rm(house_power)

# Create plot ------------------------------------------------------------------
colors()

png("plot2.png", width = 480, height = 480)
with(feb_power, plot(date_time, Global_active_power, type = "l", xaxt = "n", 
                     xlab = "", ylab = "Global Active Power (kilowatts)"))

with(feb_power, axis(side = 1, at = c(min(date_time), median(date_time), max(date_time)), 
                     labels = c("Thu", "Fri", "Sat")))

dev.off()
