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
## Subset the nei data for Baltimore City
sccMV <- subset(scc, grepl("Vehicle", scc$SCC.Level.Two))
neiBC <- subset(nei, fips == "24510")

## Merge the scc and nei datasets using the motor vehicle-related subset
Motor <- merge(sccMV, neiBC, by="SCC")

## Group the data by year;
## Summarize to get the total emissions by the applied grouping
group <- group_by(Motor, year)
total <- summarize(group, Total_Emissions = sum(Emissions))

## Plot the result in a PNG file
g <- ggplot(total, aes(year, Total_Emissions)) +
        geom_point() +
        geom_smooth(method = "lm", se = FALSE) +
        labs(title = "Total Motor Vehicle-related PM2.5 Emissions \n in Baltimore City by Year (tons)") +
        theme(plot.title = element_text(size = 10), axis.title = element_text(size=8), 
              axis.text = element_text(size = 8))
ggsave(filename="plot5.png", plot=g, width=4, height=4, dpi=120)