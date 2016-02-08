# Be sure to have .txt in working directory
file <- "household_power_consumption.txt"

# Reads the text file
data= read.csv(file , header=TRUE, sep=";", stringsAsFactors=FALSE, 
		na.strings="?", colClasses=c("character", "character", "numeric",
                         "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Create subset of the data for the correct dates
data$timestamp = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S", tz="UTC")

start = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
end = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
data = data[data$timestamp >= start & data$timestamp <= end, ]

# Initialize the plot
png("Plot4.png")

# Set the number of canvas to 4
par(mfcol=c(2,2))

# Plot 1
plot(data$timestamp, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#Plot 2
plot(data$timestamp, data$Sub_metering_1, type="l", xlab="", ylab="Energy Sub metering")

# Add 2nd and 3rd metering as lines after initial plot is created
lines(data$timestamp, data$Sub_metering_2, col="red")
lines(data$timestamp, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), lwd=par("lwd"))

# Plot 3
plot(data$timestamp, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 4
plot(data$timestamp, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()