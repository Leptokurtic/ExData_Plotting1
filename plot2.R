---
title: "plot2.R"
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


#make Plot 2
plot(power_con$Global_active_power~power_con$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")


#create png file of "plot2"
dev.copy (png, "plot2.png")
dev.off()

