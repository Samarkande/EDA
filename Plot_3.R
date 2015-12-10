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


png('Plot_3.png',width=480,height=480)

plot(x=date_time,y=mydata$Sub_metering_1,xlab='',ylab = 'Energy Submetering',type='l')
lines(x=date_time,y=mydata$Sub_metering_2,xlab='',type='l',col='red')
lines(x=date_time,y=mydata$Sub_metering_3,xlab='',type='l',col='blue')
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1,col=1:3,lwd=3)

dev.off()