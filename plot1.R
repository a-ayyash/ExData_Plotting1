if (!exists("aa")) {
    setClass("myDate")
    setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
    allData <- read.csv("household_power_consumption.txt",sep=";", na.strings="?")
    bb <- complete.cases(allData)
    allData <- allData[bb,]
    aa <- subset(allData, Date=="2/2/2007" | Date=="1/2/2007")
}
png("plot1.png")
x = aa$Global_active_power
hist(x, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
#axis(side=1, at=c(0,2,4,6))
#axis(side=2, at=c(0, 200, 400, 600, 800, 1000))

dev.off()