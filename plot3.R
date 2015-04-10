## We check if the "householder_power_consumption.txt" files exist
##If it doesnt exist we download the data 

if(!file.exists("household_power_consumption.txt"))
{
        
        ## First we download the data
        
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./dataproject1.zip")
        
        ## Second we extract the file
        
        unzip("dataproject1.zip",files="household_power_consumption.txt")
}

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

Sys.setlocale("LC_ALL","C") ##To avoid language problems

##Now We create the graphic

png(file="plot3.png") ##We create it first

par(mar=c(5,5,4,2)) ##Better position
##First the plot without the data
plot(datasub$Date_Time,datasub$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
## Now each of the lines
lines(datasub$Date_Time,datasub$Sub_metering_1,col="black")
lines(datasub$Date_Time,datasub$Sub_metering_2,col="red")
lines(datasub$Date_Time,datasub$Sub_metering_3,col="blue")
##We add the legend
legend("topright",lty=1,cex=0.7,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()