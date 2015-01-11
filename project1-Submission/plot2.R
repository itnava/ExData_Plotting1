# Reading data
powertable = read.table("household_power_consumption.txt", header = T, sep= ";")
powerdate <- as.Date(powertable[,1], format = "%d/%m/%Y")

# Subsetting
DT <- subset(powertable, as.Date(powertable[,1], format = "%d/%m/%Y") == '2007-02-01' | as.Date(powertable[,1], format= "%d/%m/%Y") =='2007-02-02')

# Removing original data from memory
rm(powertable)
rm(powerdate)

# Converting factor to numeric
GAP <- DT$Global_active_power
nuGAP <- as.numeric(levels(GAP) [GAP])
DT$nuGAP <- nuGAP

# Converting factor data to Time and Date
daytime <- as.POSIXlt(paste(DT$Date, DT$Time), format= "%d/%m/%Y %H:%M:%S")
DT$daytime <- daytime

# Making plot
png(file = "plot2.png", width = 480, height = 480, res = 72)
plot(DT$daytime, DT$nuGAP, type = "l",main = "", xlab = "", ylab = ("Global Active Power(kilowatts)"))
dev.off()
