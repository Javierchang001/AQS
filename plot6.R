##--------------------------------------------------------------------------------------------
## Title : Exploratory Data Analysis Course - Course Project 2
## Script: plot5.R
## Author: Javier Chang
##
## Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions 
##             from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##             Which city has seen greater changes over time in motor vehicle emissions?
##--------------------------------------------------------------------------------------------

## STEP 0 PREREQUISITES
## ----------------------------------------------------------------------
if (!require("ggplot2")) {
     install.packages("ggplot2", dependencies = TRUE)
     library(ggplot2)
}
if (!require("dplyr")) {
     install.packages("dplyr", dependencies = TRUE)
     library(dplyr)
}

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

## STEP 2 
## -----------------------------------------------------------------------------------------
bothcities <- subset(NEI, fips=="24510" | fips=="06037")
tot_emissions <- bothcities[bothcities$type=="ON-ROAD",] %>%
     group_by(year, fips) %>%
     summarise(Emissions=sum(Emissions))
tot_emissions$fipsname <-
     tot_emissions$fips %>% gsub("24510", "Baltimore City", .) %>%
     gsub("06037", "Los Angeles County", .)

## STEP 3 
## ------------------------------------------------------------------------------------
png(file="plot6.png", width=500, height=350)
ggplot(tot_emissions, aes(year, Emissions)) + 
     geom_line(aes(color = fipsname)) +
     ggtitle("PM2.5 Emissions Motor Vehicle sources (ON-ROAD)") +
     theme(plot.title = element_text(hjust = 0.5))+
     labs(x="years", y="PM2.5 emissions in tons")
dev.off()