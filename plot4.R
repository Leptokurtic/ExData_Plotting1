---
title: "plot4.R"
author: "Leptokurtic"
date: "Sunday, June 07, 2015"

---


#download file and unzip as household_power_consumption
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
unzip("household_power_consumption.zip", overwrite=TRUE)



#read in as CSV with proper formating 
power_data<-read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", nrows=2075259, check.names=FALSE, stringsAsFactors=FALSE, comment.char="", quote='\"')

#Read date using as.Date
class(power_data$Date)
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
class(power_data$Date)


#Subset the required dates of interest
power_con<- subset(power_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#converting date and time
date.time<- paste(as.Date(power_con$Date), power_con$Time)
power_con$DateTime<- as.POSIXct(date.time)
head(power_con$DateTime)


#make Plot 4

par (mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with (power_con, {
  plot(Global_active_power~DateTime, type="l",
       ylab="Global Active Power", xlab="")
  
  plot(Voltage~DateTime, type="l", 
       ylab= "Voltage", xlab="datetime") 
  
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ DateTime, col="Red")
  lines (Sub_metering_3 ~ DateTime, col="Blue")
  legend("topright", col=c("Black", "Red", "Blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))   
        
  plot(Global_reactive_power~DateTime, type="l",
       ylab="Global_reactive_power", xlab="datetime")
})
              
#create png file of "plot4"
dev.copy (png, "plot4.png")
dev.off()


