## Coursera: Exploratory Data Analysis, Project 2
## Data sourced from the U.S. EPA National Emissions Inventory website
## http://www.epa.gov/ttn/chief/eiinformation.html

## Read in the NEI data (working directory must be set prior to running the script)
nei <- readRDS("summarySCC_PM25.rds")

## Find the total emissions by year
total <- tapply(nei$Emissions, nei$year, sum)

## Plot the result in a PNG file
png(filename="plot1.png")
barplot(total, 
        col="blue", 
        main="Total PM2.5 Emissions in the U.S. by Year", 
        xlab="Year", 
        ylab="Total Emissions (tons)")
dev.off()