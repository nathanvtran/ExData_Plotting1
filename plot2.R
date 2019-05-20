plot2 <- function(){
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
    
    ## combines date and time
    dateDT$dt <- as.POSIXct(paste(dateDT$Date, dateDT$Time))
    
    ## creates histogram
    plot(dateDT$dt, dateDT$Global_active_power, 
         type = "l",
         ylab = "Global Active Power (kilowatts)",
         xlab = "")
    dev.copy(png, "plot2.png", height = 480, width = 480)
    dev.off()
}