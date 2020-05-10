##--------------------------------------------------------------------------------------------
## Title : Exploratory Data Analysis Course - Course Project 2
## Script: plot4.R
## Author: Javier Chang
##
## Question 4: Across the United States, how have emissions from coal combustion-related sources 
##             changed from 1999–2008?
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
coal <- grep("coal", tolower(SCC$Short.Name))
tot_emissions <- NEI[NEI$SCC %in% SCC[coal,"SCC"],] %>%
     group_by(year) %>%
     summarise(Emissions=sum(Emissions))

## STEP 3 
## ------------------------------------------------------------------------------------
png(file="plot4.png", width=500, height=350)
ggplot(tot_emissions, aes(as.factor(year), Emissions)) + 
     geom_col() +
     ggtitle("PM2.5 Emissions Coal combustion related") +
     theme(plot.title = element_text(hjust = 0.5))+
     labs(x="years", y="PM2.5 emissions in tons")
dev.off()