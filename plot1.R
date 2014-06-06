if (!exists("aa")) {
    allData <- read.csv("household_power_consumption.txt",sep=";", na.strings="?")
    bb <- complete.cases(allData)
    allData <- allData[bb,]
    aa <- subset(allData, Date=="2/2/2007" | Date=="1/2/2007")
}
png("plot1.png")
x = aa$Global_active_power
hist(x, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
