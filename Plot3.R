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

# Create the Plot and close the png device
png("Plot3.png")
plot(data$timestamp, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
# Add 2nd and 3rd metering as lines after initial plot is created
lines(data$timestamp, data$Sub_metering_2, col="red")
lines(data$timestamp, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), lwd=par("lwd"))
dev.off()