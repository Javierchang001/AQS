##--------------------------------------------------------------------------------------------
## Title : Exploratory Data Analysis Course - Course Project 2
## Script: plot1.R
## Author: Javier Chang
##
## Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##             Using the base plotting system, make a plot showing the total PM2.5 emission from 
##             all sources for each of the years 1999, 2002, 2005, and 2008.
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

## STEP 2 CALCULATE TOTAL EMISSIONS FROM PM2.5 IN THE US FROM 1999 TO 2008
## -----------------------------------------------------------------------
tot_emissions <- tapply(NEI$Emissions, NEI$year, sum)

## STEP 3 PLOT TOTAL EMISSIONS FROM PM2.5 IN THE US FROM 1999 TO 2008
## -----------------------------------------------------------------------
png(file="plot1.png", width=350, height=350)
barplot(
     tot_emissions,
     xlab = "year",
     ylab = "PM2.5 emissions in tons",
     main = "Total PM2.5 emission from all sources"
)
dev.off()