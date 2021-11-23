if (!file.exists("dataset.zip")) {
#download data set 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "dataset.zip")
}
  
#install package "utils" to unzip data set
install.packages("utils")
library(utils)

#unzip data set and load data to df1 data frame
unzip("dataset.zip")
df1<-read.csv("household_power_consumption.txt",sep=";")

#convert Date column to date class
df1$Date<-as.Date(df1$Date,"%d/%m/%Y")

#filter only required dates
library(dplyr)
df1<-filter(df1, Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

#convert all variables except Date and Time to numeric class
for (i in 3:9) {
  df1[,i]<-as.numeric(df1[,i])
}

#add datetime variable
df1$datetime<-paste(df1$Date,df1$Time)

#create datetime2 variable by converting datetime to POSIXct
df1$datetime2<-as.POSIXct(df1$datetime)

#shut down graphic devices in case any is running
dev.off()

#open png device and plot dateime2 vs Globa_active_power to plot2.png
png(filename="plot2.png",width=480,height=480)
plot(df1$datetime2,df1$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()