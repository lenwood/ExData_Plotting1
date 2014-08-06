# 2,075,259 * 9 * 8 = 149,418,684 bytes
# 142.5 MB

classes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=classes, skip=66636, nrows=2880)
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

dateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data["dateTime"] <- NA
data$dateTime <- dateTime
rm(classes, dateTime)

data$Date <- NULL
data$Time <- NULL
data <- data[c("dateTime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

