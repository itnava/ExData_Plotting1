# Reading data
powertable = read.table("household_power_consumption.txt", header = T, sep= ";")
powerdate <- as.Date(powertable[,1], format = "%d/%m/%Y")

# Subsetting data
DT <- subset(powertable, as.Date(powertable[,1], format = "%d/%m/%Y") == '2007-02-01' | as.Date(powertable[,1], format= "%d/%m/%Y") =='2007-02-02')

# Removing original data from memory
rm(powertable)
rm(powerdate)

# Converting factor to time and date
daytime <- as.POSIXlt(paste(DT$Date, DT$Time), format= "%d/%m/%Y %H:%M:%S")
DT$daytime <- daytime

# Converting factor to numeric
DT$SM1 <- as.numeric(levels(DT$Sub_metering_1) [DT$Sub_metering_1])
DT$SM2 <- as.numeric(levels(DT$Sub_metering_2) [DT$Sub_metering_2])

# Making plot
png(file = "plot3.png", width = 480, height = 480, res = 72)
plot(DT$daytime, DT$SM1, type = "l", main = "", xlab = "", ylab = ("Energy Sub Metering"))
lines(DT$daytime, DT$SM2, col = "red")
lines(DT$daytime, DT$Sub_metering_3, col = "blue")
# Adding legend
legend( x = "topright", c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), col = c("black", "red", "blue"), lty= 1, cex = 0.75)
dev.off()
