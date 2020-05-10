##--------------------------------------------------------------------------------------------
## Title : Exploratory Data Analysis Course - Course Project 2
## Script: plot3.R
## Author: Javier Chang
##
## Question 3: Of the four types of sources indicated by the type 
##             (point, nonpoint, onroad, nonroad) variable, which of these four sources have 
##             seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen 
##             increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
##             a plot answer this question.
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

## STEP 2 CALCULATE TOTAL EMISSIONS FROM PM2.5 IN BALTIMORE CITY, MARYLAND FROM 1999 TO 2008 BY TYPE
## -------------------------------------------------------------------------------------------------
baltimorecity <- subset(NEI, fips=="24510")
tot_emissions <- baltimorecity %>%
     group_by(year, type) %>%
     summarise(Emissions=sum(Emissions))

## STEP 3 PLOT TOTAL EMISSIONS FROM PM2.5 IN BALTIMORE CITY, MARYLAND FROM 1999 TO 2008 BY TYPE
## -------------------------------------------------------------------------------------------
png(file="plot3.png", width=500, height=350)
ggplot(tot_emissions, aes(year, Emissions)) + 
     geom_line(aes(color = type)) +
##     scale_x_discrete("year", labels=tot_emissions$year)+
     ggtitle("PM2.5 Emissions Baltimore City, Maryland") +
     theme(plot.title = element_text(hjust = 0.5))+
     labs(x="years", y="PM2.5 emissions in tons")
dev.off()