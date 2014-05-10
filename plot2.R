# plot1.R
# reads in part of household_power_consumption.txt and generates a plot of the variable Global_active_power by time

# this codefile assumes that the household_power_consumption file is downloaded, unzipped, and in the working directory
# if household_power_consumption.txt is not downloaded and in the working directory uncomment the following lines

# UN-COMMENT IF SOURCE FILE NEEDS TO BE DOWNLOADED
# if(!file.exists("./data")){dir.create("./data")}
# fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download.file(fileURL, destfile = "./data/household_power_consumption.zip", method = "curl")
# unzip("./data/household_power_consumption.zip")  # this will unzip the txt into the working directory
# END DOWNLOAD / UNZIP CODE

# Read in only enough rows to include all data for 2007-02-01 and 2007-02-02
# To estimate the number of rows to read, read in the date column, convert to factor and summarize
# From the summary, it is evident that each date has 1440 observations.
# The file starts at 2006-12-16. Estimate 50 days to include all data for 2007-02-01 and 2007-02-02
# Thus read in 50 x 1440 = 72000 rows.
# dateOnly = c("character", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL")
# initial <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = dateOnly)
# head(summary(factor(initial[,1])))

colClass <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
myData <- read.table("household_power_consumption.txt", header = TRUE, nrows = 72000, sep = ";", na.strings = "?", colClasses = colClass)

# tidy up the variable names a bit and create a variable of date and time and convert to POSIXlt
names(myData) <- tolower(names(myData))
myData$datetime <- paste(myData$date, myData$time, sep = " ")
myData$datetime <- strptime(myData$datetime, "%d/%m/%Y %H:%M:%S")

# Subset to just the observations of intereste: 2007-02-01 and 2007-02-02
pData <- myData[(as.Date(myData$datetime) == as.Date("2007-02-01") |as.Date(myData$datetime) == as.Date("2007-02-02")) , ]

# Create the plot as a png file in the current working directory

png(file = "plot2.png")
with(pData, plot(datetime, global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
