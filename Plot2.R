# Be sure to have .txt in working directory
file <- "household_power_consumption.txt"

# Reads the text file
data= read.csv(file , header=TRUE, sep=";", stringsAsFactors=FALSE, 
		na.strings="?",
            colClasses=c("character", "character", "numeric",
                         "numeric", "numeric", "numeric",
                         "numeric", "numeric", "numeric"))

# Create subset of the data for the correct dates
data$timestamp = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S", tz="UTC")

start = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
end = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
data = data[data$timestamp >= start & data$timestamp <= end, ]

# Create the Plot and close the png device
png("Plot2.png")
plot(data$timestamp, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()