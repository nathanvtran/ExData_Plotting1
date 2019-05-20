plot1 <- function(){
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
    
    ## reformats the 'Date' column of the data set
    newDT <- DT %>% 
                mutate(Date = dmy(Date))
    
    ## subsets the data set to desired dates
    dateDT <- subset(newDT, newDT$Date == "2007-02-01" | newDT$Date == "2007-02-02")
    
    ## creates histogram and saves as PNG
    plot1 <- hist(as.numeric(dateDT$Global_active_power), 
                  col = "red", 
                  xlab = "Global Active Power (kilowatts",
                  main = "Global Active Power"
                  )
    dev.copy(png, "plot1.png", height = 480, width = 480)
    dev.off()
}