# Reading the data
powertable = read.table("household_power_consumption.txt", header = T, sep= ";")
powerdate <- as.Date(powertable[,1], format = "%d/%m/%Y")

# Subsetting
DT <- subset(powertable, as.Date(powertable[,1], format = "%d/%m/%Y") == '2007-02-01' | as.Date(powertable[,1], format= "%d/%m/%Y") =='2007-02-02')

# Removing original data from memory
rm(powertable)
rm(powerdate)

# converting from factor to numeric
GAP <- DT$Global_active_power
nuGAP <- as.numeric(levels(GAP) [GAP])
DT$nuGAP <- nuGAP

# Making plot
png(file = "plot1.png", width = 480, height = 480, res = 72)
hist(DT$nuGAP, col="red", main = "Global Active Power", xlab = ("Global Active Power(kilowatts)"))
dev.off()


