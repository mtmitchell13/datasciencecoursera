## Coursera: Exploratory Data Analysis, Project 2
## Data sourced from the U.S. EPA National Emissions Inventory website
## http://www.epa.gov/ttn/chief/eiinformation.html

## Load the required libraries
library(ggplot2)
library(dplyr)

## Read in the NEI data (working directory must be set prior to running the script)
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Subset scc for the coal-related sources
sccCoal <- subset(scc, grepl("Coal", scc$EI.Sector))

## Merge the scc and nei datasets using the coal-related subset
Coal <- merge(sccCoal, nei, by="SCC")

## Group the data by year;
## Summarize to get the total emissions by the applied grouping
group <- group_by(Coal, year)
total <- summarize(group, Total_Emissions = sum(Emissions))

## Plot the result in a PNG file
g <- ggplot(total, aes(year, Total_Emissions)) +
        geom_point() +
        geom_smooth(method = "lm", se = FALSE) +
        labs(title = "Total Coal Combustion-related PM2.5 Emissions \n in the U.S. by Year (tons)") +
        theme(plot.title = element_text(size = 10), axis.title = element_text(size=8), 
              axis.text = element_text(size = 8))
ggsave(filename="plot4.png", plot=g, width=4, height=4, dpi=120)