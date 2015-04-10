## First we download the data

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./dataproject1.zip")

## Second we extract the file

unzip("dataproject1.zip",files="household_power_consumption.txt")

## We read the data from the file

data<- read.table("household_power_consumption.txt",header=TRUE,sep=";", na.strings="?")

## We obtain just the data from 1/2/2007 and 2/2/2007

datasub1 <- data[data$Date=="1/2/2007",]
datasub2 <- data[data$Date=="2/2/2007",]
datasub <- rbind(datasub1,datasub2)

##Now we convert the Date and Time columns in one

datasub$Date_Time <- paste(datasub$Date, datasub$Time, sep=" ")
datasub$Date <-NULL
datasub$Time <-NULL

##And convert it to a Date class

datasub$Date_Time<-strptime(datasub$Date_Time, format='%d/%m/%Y %H:%M:%S')
datasub$Date_Time <- as.POSIXct(datasub$Date_Time)

##Now we create the Histogram (We move the margin for better position)

par(mar=c(5,5,4,2))
hist(datasub$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")

## And we copy it toa PNG File

dev.copy(png, file="plot1.png")
dev.off()

