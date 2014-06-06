if (!exists("aa")) {
    setClass("myDate")
    setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
    allData <- read.csv("household_power_consumption.txt",sep=";", na.strings="?", as.is=TRUE)
    bb <- complete.cases(allData)
    allData <- allData[bb,]
    aa <- subset(allData, Date=="2/2/2007" | Date=="1/2/2007")
}

gap = aa$Global_active_power
dates = aa$Date
times = aa$Time
epochT = rep(NA, length(dates))

for (i in seq_len(length(dates))) {
    cc <- as.POSIXct(paste(dates[i], times[i]), format="%d/%m/%Y %H:%M:%S")
    epochT[i] = as.integer(cc)
}
png("plot2.png")
plot(epochT, gap, type="l", axes=FALSE)
axis(side=1, at=c(min(epochT), median(epochT), max(epochT)), labels=c("Thu","Fri", "Sat"))
axis(side=2, at=c(0,2,4,6))
dev.off()