## Assignment PLOT 2 ~ D. Werner

## download the dataset and unzup
if(!file.exists("exdata_data_household_power_consumption.zip")){
        dataURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(
                url = dataURL,
                destfile = "exdata_data_household_power_consumption.zip",
                method = "libcurl")
        unzip("exdata_data_household_power_consumption.zip")}




##read in the data into a dataframe called "df"
df <- read.table(file = "household_power_consumption.txt", header = TRUE, nrows = 2075259, sep = ";", 
                 col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                               "Voltage","Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
df$Date <- as.Date(df$Date, format ="%d/%m/%Y")
df$Global_active_power <- as.numeric(df$Global_active_power)

##create subset of dates 2007-02-01 - 2007-02-02.
df_subset <- subset(df, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

##create a date time column 
library(dplyr) ## load dplyr package 
df_subset <- df_subset %>% 
        mutate(datetime = paste(df_subset$Date, df_subset$Time, sep = " "))
df_subset$datetime <- as.POSIXlt(df_subset$datetime, format = "%Y-%m-%d %H:%M:%S")

##create plot 2
png(file = "plot2.png", width = 480, height = 480) ## open PNG device; creates "plot2.png" in working directory.
plot(df_subset$datetime, df_subset$Global_active_power, type = "l", ylab ="Global Active Power (kilowatts)", xlab = "")
dev.off() ## Close the png file device. 
