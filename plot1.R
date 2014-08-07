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

# create the histogram
png(filename="plot1.png", height=480, width=480)
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
