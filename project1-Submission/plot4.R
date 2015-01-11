# Reading data
powertable = read.table("household_power_consumption.txt", header = T, sep= ";")
powerdate <- as.Date(powertable[,1], format = "%d/%m/%Y")

# Subsetting
DT <- subset(powertable, as.Date(powertable[,1], format = "%d/%m/%Y") == '2007-02-01' | as.Date(powertable[,1], format= "%d/%m/%Y") =='2007-02-02')

# Removing original data
rm(powertable)
rm(powerdate)

# Converting factor to Time and Date
daytime <- as.POSIXlt(paste(DT$Date, DT$Time), format= "%d/%m/%Y %H:%M:%S")
DT$daytime <- daytime

GAP <- DT$Global_active_power
nuGAP <- as.numeric(levels(GAP) [GAP])
DT$nuGAP <- nuGAP

DT$Volt <- as.numeric(levels(DT$Voltage) [DT$Voltage])

DT$SM1 <- as.numeric(levels(DT$Sub_metering_1) [DT$Sub_metering_1])
DT$SM2 <- as.numeric(levels(DT$Sub_metering_2) [DT$Sub_metering_2])

DT$GRP <- as.numeric(levels(DT$Global_reactive_power) [DT$Global_reactive_power])

# function for plotting multiple data on same plot
f <- function(x, y1, y2, y3){
  plot(x, y1, type = "l", main = "", xlab = "", ylab = ("Energy Sub Metering"))
  lines(x, y2, col = "red")
  lines(x, y3, col = "blue")
  }

# Make plots
png(file = "plot4.png", width = 480, height = 480, res = 72)
par(mfrow= c(2,2), pty = "m", cex = .7)
plot(DT$daytime, DT$nuGAP, type = "l",main = "", xlab = "", ylab = ("Global Active Power(kilowatts)"), cex = 0.5)
plot(DT$daytime, DT$Volt, type = "l", main = "", xlab = "datetime", ylab = ("Voltage"))
f(DT$daytime, DT$SM1, DT$SM2, goodpowertable$Sub_metering_3)
legend( x = "topright", c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), col = c("black", "red", "blue"), lty= 1, cex = 0.6, bty = "n" )
plot(DT$daytime, DT$GRP, type = "l",main = "", xlab = "", ylab = ("Global_Reactive_Power"))

