##--------------------------------------------------------------------------------------------
## Title : Exploratory Data Analysis Course - Course Project 2
## Script: plot5.R
## Author: Javier Chang
##
## Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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

## STEP 2 CALCULATES TOTAL EMISSIONS IN BALTIMORE CITY FOR ON-ROAD TYPE
## -----------------------------------------------------------------------------------------
baltimorecity <- subset(NEI, fips=="24510")
tot_emissions <- baltimorecity[baltimorecity$type=="ON-ROAD",] %>%
     group_by(year) %>%
     summarise(Emissions=sum(Emissions))

## STEP 3 PLOT THE GRAPH
## ------------------------------------------------------------------------------------
png(file="plot5.png", width=500, height=350)
ggplot(tot_emissions, aes(as.factor(year), Emissions)) + 
     geom_col() +
     ggtitle("PM2.5 Emissions Motor Vehicle sources (ON-ROAD)\nin Baltimore City, Maryland") +
     theme(plot.title = element_text(hjust = 0.5))+
     labs(x="years", y="PM2.5 emissions in tons")
dev.off()