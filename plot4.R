require (sqldf)
require (dplyr)
require (lubridate)
message("loading data...")
df <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date ='1/2/2007' or Date ='2/2/2007'", eol = "\n", sep = ";")
df <- df %>% mutate(Date = dmy_hms(paste(Date, Time, sep=" ")), Global_active_power = as.numeric(Global_active_power), Global_reactive_power = as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage), Global_intensity = as.numeric(Global_intensity), Sub_metering_1 = as.numeric(Sub_metering_1),Sub_metering_2 = as.numeric(Sub_metering_2),Sub_metering_3 = as.numeric(Sub_metering_3))
message("create and saving png plot...")
png(file="plot4.png",width=480,height=480)
max_y = max(c(max(df$Sub_metering_1), max(df$Sub_metering_2), max(df$Sub_metering_3)))

# plot 1:
par(mfrow=c(2,2))

plot(df$Date, df$Global_active_power, type="n", main ="",xlab="", ylab = "Global Active Power")
lines(df$Date, df$Global_active_power, type="l", col="black")

#plot 2:
plot(df$Date, df$Voltage, type="n", main ="",xlab="datetime", ylab = "Voltage")
lines(df$Date, df$Voltage, type="l", col="black")

#plot 3:
plot(df$Date, df$Sub_metering_1 ,type='n', ylim=c(0,max_y), 
     main ="",xlab="", ylab = "Energy sub metering")
lines(df$Date, df$Sub_metering_1, type="l", col="black")
lines(df$Date, df$Sub_metering_2, type="l", col="red")
lines(df$Date, df$Sub_metering_3, type="l", col="blue")
# add a legend 
legend("topright", 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       cex=0.8, 
       col=c("black","red","blue"),
       lty=c(1,1,1), bty = "n")

#plot 4:
plot(df$Date, df$Global_reactive_power, type="n", main ="",xlab="datetime", ylab = "Global_Reactive_Power")
lines(df$Date, df$Global_reactive_power, type="l", col="black")


dev.off()
message("Done!")