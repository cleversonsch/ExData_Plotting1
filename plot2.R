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
#Create the plot
  with(myframe,plot(Date,Global_active_power, type="l", xlab="", ylab="Global Active Power (kilolwatts)"))
#Copy to png file
  dev.copy(png, file = "plot2.png")
#Close png device
  dev.off()