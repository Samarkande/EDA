if(!dir.exists('Data')){
  dir.create('Data')
}

if(!file.exists('./Data/household_power_consumption.zip')){
  fileUrl<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(fileUrl,destfile = './Data/household_power_consumption.zip',mode='wb')
  unzip('./Data/household_power_consumption.zip')
}

mydata<-read.table('./household_power_consumption.txt', header = T, sep = ';', na.strings = '?',stringsAsFactors = F)
mydata<-mydata[mydata$Date %in% c("1/2/2007","2/2/2007"),]
date_time<-strptime(paste(mydata$Date,mydata$Time,sep=' '),'%d/%m/%Y %H:%M:%S')


png('Plot_4.png',width=480,height=480)

par(mfrow=c(2,2))

# Plot 1
plot(x=date_time,y=mydata$Global_active_power,xlab='',ylab = 'Global Active Power',type='l')
# Plot 2
plot(x=date_time,y=mydata$Voltage, type="l", xlab='datetime', ylab="Voltage")
# Plot 3
plot(x=date_time,y=mydata$Sub_metering_1,xlab='',ylab = 'Energy Submetering',type='l')
lines(x=date_time,y=mydata$Sub_metering_2,xlab='',type='l',col='red')
lines(x=date_time,y=mydata$Sub_metering_3,xlab='',type='l',col='blue')
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1,col=1:3,lwd=3)
# Plot 4
plot(x=date_time,y=mydata$Global_reactive_power, type="l", xlab='datetime', ylab="Global_reactive_power")

dev.off()