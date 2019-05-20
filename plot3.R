plot3 <- function(){
    library(dplyr)
    library(lubridate)
    library(datasets)
    
    zip <- "exdata_data_household_power_consumption.zip"
    file <- "household_power_consumption.txt"
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    ## downloads zip file
    if(!file.exists(zip)){
        download.file(url, zip, method = "curl")
    }
    
    ## unzips zip file
    if(!file.exists(file)){
        unzip(zip)
    }
    
    DT <- data.table::fread(file)
    
    ## reformats date
    DT$Date <- as.Date(DT$Date, format = "%d/%m/%Y")
    
    ## subsets the data set to desired dates
    dateDT <- subset(DT, DT$Date == "2007-02-01" | DT$Date == "2007-02-02")
    
    ## creates histogram
    
    plot(dateDT$dt, dateDT$Sub_metering_1, 
         type = "l",
         col = "black",
         ylab = "Energy sub metering",
         xlab = "")
    lines(dateDT$dt, dateDT$Sub_metering_2, col = "red")
    lines(dateDT$dt, dateDT$Sub_metering_3, col = "blue")
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"),
           lty = 1,
           col = c("black", "red", "blue"),
           cex = 0.75)
    dev.copy(png, "plot3.png", height = 480, width = 480)
    dev.off()
}
    