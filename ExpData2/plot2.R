## Coursera: Exploratory Data Analysis, Project 2
## Data sourced from the U.S. EPA National Emissions Inventory website
## http://www.epa.gov/ttn/chief/eiinformation.html

## Read in the NEI data (working directory must be set prior to running the script)
nei <- readRDS("summarySCC_PM25.rds")

## Subset the data for Baltimore City, fips == "24510"
neiBC <- subset(nei, fips=="24510")

## Find the total emissions by year
total <- tapply(neiBC$Emissions, neiBC$year, sum)

## Plot the result in a PNG file
png(filename="plot2.png")
barplot(total, 
        col="green", 
        main="Total PM2.5 Emissions in Baltimore City by Year", 
        xlab="Year", 
        ylab="Total Emissions (tons)")
dev.off()