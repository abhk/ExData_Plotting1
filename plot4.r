#Read data into dataframe
d <- read.csv("~/coursera/EDA/household_power_consumption.txt", sep=";", quote="", stringsAsFactors=FALSE)

#Create duplicate dataframe for formatting data 
d2<-d
#Replace ? with NA
d2[d2=="?"]<-NA
#Combine date and time into a new column DT
d2$DT<-paste(d$Date,d$Time)

#Convert all columns to correct classes
d2$Date<-as.Date(d$Date,"%d/%m/%Y")
d2$Global_active_power<-as.numeric(d2$Global_active_power)
d2$Global_reactive_power<-as.numeric(d2$Global_reactive_power)
d2$Voltage<-as.numeric(d2$Voltage)
d2$Global_intensity<-as.numeric(d2$Global_intensity)
d2$Sub_metering_1<-as.numeric(d2$Sub_metering_1)
d2$Sub_metering_2<-as.numeric(d2$Sub_metering_2)
d2$Sub_metering_3<-as.numeric(d2$Sub_metering_3)
d2$Time<-strptime(d2$DT,"%d/%m/%Y %H:%M:%S")

#Extract data for relevant period

#Datetime
inte<-d2$Time[d2$Date>"2007-01-31" & d2$Date<"2007-02-03"]
#Global Active Power
gap<-d2$Global_active_power[d2$Date>"2007-01-31" & d2$Date<"2007-02-03"]
#Sub metering 1,2,3
s1<-d2$Sub_metering_1[d2$Date>"2007-01-31" & d2$Date<"2007-02-03"]
s2<-d2$Sub_metering_2[d2$Date>"2007-01-31" & d2$Date<"2007-02-03"]
s3<-d2$Sub_metering_3[d2$Date>"2007-01-31" & d2$Date<"2007-02-03"]
#Voltage
v<-d2$Voltage[d2$Date>"2007-01-31" & d2$Date<"2007-02-03"]
#Global Reactive power
gar<-d2$Global_reactive_power[d2$Date>"2007-01-31" & d2$Date<"2007-02-03"]

#Open PNG graphics device 
png(filename = "~/coursera/EDA/plot4.png",width = 480, height = 480, units = "px")

par(mfrow=c(2,2))
#Top left plot
plot(inte,gap,type="l",xlab="",ylab="Global Active Power (kilowatts)")
#Top right plot
plot(inte,v,type="l",xlab="datetime",ylab="Voltage")
#Bottom left plot
plot(inte,s1,type="l", xlab="",ylab="Energy sub metering",ylim=c(0,40))
lines(inte,s2,col="red")
lines(inte,s3,col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
#Bottom right plot
plot(inte,gar,type="l",xlab="datetime",ylab="Global_reactive_power")
#Close device
dev.off()