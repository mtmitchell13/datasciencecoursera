## Coursera: Exploratory Data Analysis, Project 2
## Data sourced from the U.S. EPA National Emissions Inventory website
## http://www.epa.gov/ttn/chief/eiinformation.html

## Load the required libraries
library(ggplot2)
library(dplyr)

## Read in the NEI data (working directory must be set prior to running the script)
nei <- readRDS("summarySCC_PM25.rds")

## Subset the data for Baltimore City, fips == "24510"
neiBC <- subset(nei, fips=="24510")

## Group the data by type and year;
## Summarize to get the total emissions by the applied groupings
group <- group_by(neiBC, type, year)
total <- summarize(group, Total_Emissions = sum(Emissions))

## Plot the result in a PNG file
g <- ggplot(total, aes(year, Total_Emissions)) +
        geom_point() +
        facet_grid(type ~ ., scales = "free_y") +
        geom_smooth(method = "lm", se = FALSE) +
        labs(title = "Total PM2.5 Emissions in Baltimore City \n by Source and Year (tons)") +
        theme(plot.title = element_text(size = 10), axis.title = element_text(size=8),
              axis.text = element_text(size = 8), strip.text = element_text(size = 6))
ggsave(filename="plot3.png", plot=g, width=4, height=4, dpi=120)