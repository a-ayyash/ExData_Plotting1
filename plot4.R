if (!exists("aa")) {
    setClass("myDate")
    setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
    allData <- read.csv("household_power_consumption.txt",sep=";", na.strings="?", as.is=TRUE)
    bb <- complete.cases(allData)
    allData <- allData[bb,]
    aa <- subset(allData, Date=="2/2/2007" | Date=="1/2/2007")
}


s1 = aa$Sub_metering_1
s2 = aa$Sub_metering_2
s3 = aa$Sub_metering_3
dates = aa$Date
times = aa$Time
epochT = rep(NA, length(dates))
voltage = aa$Voltage
gap = aa$Global_active_power
grp = aa$Global_reactive_power

for (i in seq_len(length(dates))) {
    cc <- as.POSIXct(paste(dates[i], times[i]), format="%d/%m/%Y %H:%M:%S")
    epochT[i] = as.integer(cc)
}
png("plot4.png")
par(mar=c(4.2,4.1,3,2))
par(mfrow=c(2,2))
plot(epochT, gap, type="l", xaxt='n', xlab="", ylab="Global Active Power")
axis(side=1, at=c(min(epochT), median(epochT), max(epochT)), labels=c("Thu","Fri", "Sat"))


plot(epochT, voltage, type="l", xaxt='n', xlab="datetime", ylab="voltage")
axis(side=1, at=c(min(epochT), median(epochT), max(epochT)), labels=c("Thu","Fri", "Sat"))


plot(epochT, s1, ylab="", xlab="", ylim=c(0,40),type="l", xaxt='n', yaxt='n')
par(new=TRUE)
plot(epochT, s3, ylab="", xlab="", ylim=c(0,40), type="l", xaxt='n', yaxt='n', col='blue')
par(new=TRUE)
plot(epochT, s2, ylab="Energy sub metering", xlab="", ylim=c(0,40), type="l", yaxt='n', xaxt='n', col='red')
par(new=TRUE)
legend("topright", bty='n', legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c('black', 'red', 'blue'))

axis(side=1, at=c(min(epochT), median(epochT), max(epochT)), labels=c("Thu","Fri", "Sat"))
axis(side=2, at=c(0,10,20,30))

plot(epochT, grp, type="l", xaxt='n', xlab="datetime", ylab="Global_reactive_power")
axis(side=1, at=c(min(epochT), median(epochT), max(epochT)), labels=c("Thu","Fri", "Sat"))

dev.off()