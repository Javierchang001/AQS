##--------------------------------------------------------------------------------------------
## Title : Exploratory Data Analysis Course - Course Project 2
## Script: plot2.R
## Author: Javier Chang
##
## Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##             (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? 
##             Use the base plotting system to make a plot answering this question.
##--------------------------------------------------------------------------------------------
## STEP 1 DOWNLOAD DATA AND READ IT
## ----------------------------------------------------------------------

## Download file
dfile <- "exdata.zip"
if (!file.exists(dfile)) {
     download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                   destfile = dfile)
     unzip(dfile, overwrite = TRUE)
}

# Read the files
if(!exists("NEI"))
     NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
     SCC <- readRDS("Source_Classification_Code.rds")

## STEP 2 CALCULATE TOTAL EMISSIONS FROM PM2.5 IN BALTIMORE CITY, MARYLAND FROM 1999 TO 2008
## -----------------------------------------------------------------------------------------
baltimorecity <- subset(NEI, fips=="24510")
tot_emissions <- tapply(baltimorecity$Emissions, baltimorecity$year, sum)

## STEP 3 PLOT TOTAL EMISSIONS FROM PM2.5 IN BALTIMORE CITY, MARYLAND FROM 1999 TO 2008
## ------------------------------------------------------------------------------------
png(file="plot2.png", width=350, height=350)
barplot(
     tot_emissions,
     xlab = "year",
     ylab = "PM2.5 emissions in tons",
     main = "Total PM2.5 emission Baltimore City, Maryland"
)
dev.off()