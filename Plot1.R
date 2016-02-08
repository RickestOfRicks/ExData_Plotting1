# Be sure to have .txt in working directory
file <- "household_power_consumption.txt"

# Reads the text file
data= read.csv(file , header=TRUE, sep=";", stringsAsFactors=F, 
		na.strings="?",
            colClasses=c("character", "character", "numeric",
                         "numeric", "numeric", "numeric",
                         "numeric", "numeric", "numeric"))

# Create subset of the data for the correct dates
data$Date = as.Date(data$Date, format="%d/%m/%Y")
start = as.Date("01/02/2007", format="%d/%m/%Y")
end = as.Date("02/02/2007", format="%d/%m/%Y")
data= data[data$Date >= start & data$Date <= end, ]

# Create the Plot and close the png device
png("Plot1.png")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off() 