##############################################################################
## File: plot4.R
##
## Description: Plotting Assignment 1 for Exploratory Data Analysis
## https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1
##
## This script contains the code to generate the plot4 of exercise:
## https://d396qusza40orc.cloudfront.net/exdata/CP1/ExDataCP1Plot4.png
##
##
## Author: Pedro A. Alonso Baigorri
##############################################################################

library(data.table)

rm(list=ls())
gc()

setwd("D://GIT_REPOSITORY//ExData_Plotting1")


# Getting the data
{
    if (!file.exists("./data/power_consumption.zip"))
    {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        if (!file.exists("./data")){dir.create("./data")}
        download.file(fileURL, "./data/power_consumption.zip")
    
        unzip("./data/power_consumption.zip", exdir = "./data")    
    }

}

# preparation of the data
{
    #reading the data
    pc <- fread("./data/household_power_consumption.txt", sep=";", dec = "." , header = TRUE)
    head(pc)
    dim(pc) #2075259 x 7
    
    pc <- as.data.frame(pc)
    
    ## subsetting dates
    pc <- subset(pc, Date == "1/2/2007"| Date == "2/2/2007" )
    dim(pc) #2880 x 7
    
    ## converting numeric data types
    pc$Global_active_power <- as.numeric(pc$Global_active_power)
    pc$Global_reactive_power <- as.numeric(pc$Global_reactive_power)
    pc$Voltage <- as.numeric(pc$Voltage)
    pc$Global_intensity <- as.numeric(pc$Global_intensity)
    pc$Sub_metering_1 <- as.numeric(pc$Sub_metering_1)
    pc$Sub_metering_2 <- as.numeric(pc$Sub_metering_2)
    pc$Sub_metering_3 <- as.numeric(pc$Sub_metering_3)
    
    
    ## creating the datatime
    pc$datetime <- paste(pc$Date, pc$Time, sep = " ")
    
    pc$datetime <- strptime(pc$datetime, "%d/%m/%Y %H:%M:%S")
    pc$Date <- as.Date(strptime(pc$Date, "%d/%m/%Y"))
    

    head(pc)
    

}



# drawing plot 4
{   
    
    png(file = "plot4.png", width=480, height=480)
    par(mfrow = c(2, 2))
    
    # draw 1
    plot(pc$datetime, pc$Global_active_power,  ylab = "Global Active Power (kilowatts)", xlab = "", main ="", type = "l")


    # draw 2
    plot(pc$datetime, pc$Voltage,  ylab = "Voltage", xlab = "datetime", main ="", type = "l")
    
    # draw 3
    plot(pc$datetime, pc$Sub_metering_1,  ylab = "Energy submeetering", xlab = "", main ="", type = "l")
    points(pc$datetime, pc$Sub_metering_2, type = "l", col = "red")
    points(pc$datetime, pc$Sub_metering_3, type = "l", col = "blue")
    legend("topright", bty= "n" , lwd = c(2.5, 2.5, 2.5), col = c("black", "red", "blue"), legend = c("Sub_meetering_1", "Sub_meetering_2", "Sub_meetering_3"))
    
    
    # draw 4
    plot(pc$datetime, pc$Global_reactive_power,  ylab = "Global_reactive_power", xlab = "datetime", main ="", type = "l")
    

    dev.off()

}
