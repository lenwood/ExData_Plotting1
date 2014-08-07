# read the data in
classes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=classes, skip=66636, nrows=2880)
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# convert date & time
dateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data["dateTime"] <- NA
data$dateTime <- dateTime

# clean up
rm(classes, dateTime)
data$Date <- NULL
data$Time <- NULL
data <- data[c("dateTime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

# create the chart
png(filename="plot4.png", height=480, width=480)
par(mfrow=c(2, 2))
par(mar=c(4, 4, 2, 2))

# plot 1
plot(data$dateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# plot 2
plot(data$dateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# plot 3
plot(data$dateTime, data$Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
lines(data$dateTime, data$Sub_metering_2, col="red", type="l")
lines(data$dateTime, data$Sub_metering_3, col="blue", type="l")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

# plot 4
plot(data$dateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
