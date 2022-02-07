#Read in the data
power <- read.delim("household_power_consumption.txt", sep = ";")

#Create a combined date/time object and set the existing Date variable to a date class
power$datetime <- as.POSIXct(paste(power$Date, power$Time), format = "%e/%m/%Y %H:%M:%S")

power$Date <- strptime(power$Date, "%e/%m/%Y")
power$Date <- as.Date(power$Date)

#Extract the period of interest
feb <- subset(power, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#Set the numeric variables correctly
feb$Global_active_power <- as.numeric(feb$Global_active_power)
feb$Global_reactive_power <- as.numeric(feb$Global_reactive_power)
feb$Sub_metering_1 <- as.numeric(feb$Sub_metering_1)
feb$Sub_metering_2 <- as.numeric(feb$Sub_metering_2)
feb$Sub_metering_3 <- as.numeric(feb$Sub_metering_3)

#Create plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(feb$datetime, feb$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(feb$datetime, feb$Sub_metering_2, col = "red", type = "l")
lines(feb$datetime, feb$Sub_metering_3, col = "blue", type = "l")
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()