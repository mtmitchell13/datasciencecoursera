## Coursera: Exploratory Data Analysis, Project 2
## Data sourced from the U.S. EPA National Emissions Inventory website
## http://www.epa.gov/ttn/chief/eiinformation.html

## Load the required libraries
library(ggplot2)
library(dplyr)

## Read in the NEI data (working directory must be set prior to running the script)
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Subset scc for the Motor Vehicle-related sources;
## Subset the nei data for Baltimore City and Los Angeles County
sccMV <- subset(scc, grepl("Vehicle", scc$SCC.Level.Two))
neiBCLA <- subset(nei, fips == "24510" | fips == "06037")

## Merge the scc and nei datasets using the motor vehicle-related subset
Motor <- merge(sccMV, neiBCLA, by="SCC")

## Group the data by year and by county code (group);
## Summarize to get the total emissions by the applied groupings (total)
## Subset the total to show net change from 1999 to 2008 (totalsub)
group <- group_by(Motor, year, fips)
total <- summarize(group, Total_Emissions = sum(Emissions))
totalsub <- subset(total, year == 1999 | year == 2008)


## Plot the result in a PNG file
g <- ggplot(total, aes(year, Total_Emissions)) +
        geom_point() +
        facet_grid(fips ~ ., scales = "free_y") +
        geom_line(data = totalsub, color = "blue") +
        labs(title = "Change in Total Motor Vehicle-related PM2.5 Emissions \n Los Angeles County vs Baltimore City 1999-2008 (tons)") +
        theme(plot.title = element_text(size = 9), axis.title = element_text(size=8),
              axis.text = element_text(size = 8), strip.text = element_text(size = 6))
ggsave(filename="plot6.png", plot=g, width=4, height=4, dpi=120)