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

for (i in seq_len(length(dates))) {
    cc <- as.POSIXct(paste(dates[i], times[i]), format="%d/%m/%Y %H:%M:%S")
    epochT[i] = as.integer(cc)
}
png("plot3.png")

plot(epochT, s1, ylab="", xlab="", ylim=c(0,40),type="l", xaxt='n', yaxt='n')
par(new=TRUE)
plot(epochT, s3, ylab="", xlab="", ylim=c(0,40), type="l", xaxt='n', yaxt='n', col='blue')
par(new=TRUE)
plot(epochT, s2, ylab="Energy sub metering", xlab="", ylim=c(0,40), type="l", yaxt='n', xaxt='n', col='red')
par(new=TRUE)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c('black', 'red', 'blue'))

axis(side=1, at=c(min(epochT), median(epochT), max(epochT)), labels=c("Thu","Fri", "Sat"))
axis(side=2, at=c(0,10,20,30))
dev.off()