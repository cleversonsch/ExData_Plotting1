#Unzip File 
  unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
#Read Household Power Consumption File
  myframe<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
#Transform Date column in "date" type
  myframe$Date<-as.Date(myframe$Date,"%d/%m/%Y")
#Subsetting file for required dates
  myframe<-subset(myframe,Date == "2007-02-01" | Date == "2007-02-02")
#Merge Date and Time columns
  myframe$Date<- with(myframe, paste(Date,Time))
#Transform merged column to date and time format
  myframe$Date<-strptime(myframe$Date, format="%Y-%m-%d %H:%M:%S")
#Remove Time column  
  myframe<-myframe[,-2]
#Transform Global_active_power to numeric format
  myframe$Global_active_power<-as.numeric(as.character(myframe$Global_active_power))
  myframe$Sub_metering_1<-as.numeric(as.character(myframe$Sub_metering_1))
  myframe$Sub_metering_2<-as.numeric(as.character(myframe$Sub_metering_2))
  myframe$Sub_metering_3<-as.numeric(as.character(myframe$Sub_metering_3))
#Create the plot
  with(myframe, plot(Date,Sub_metering_1, type = "n", xlab="", ylab ="Energy sub metering"))
  with(myframe, lines(Date, Sub_metering_1, col = "black"))
  with(myframe, lines(Date, Sub_metering_2, col = "red"))
  with(myframe, lines(Date, Sub_metering_3, col = "blue"))
  legend("topright", lty = 1, cex=0.75, col = c("black","red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Copy to png file
  dev.copy(png, file = "plot3.png")
#Close png device
  dev.off()