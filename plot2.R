# Ensure data is in your working directory

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Take a subset for Baltimore City, Maryland (fips == "24510")
baltimore_NEI <- NEI[NEI$fips == "24510",]

# Generate total emissions per year
total_emissions <- aggregate(baltimore_NEI$Emissions ~ baltimore_NEI$year, baltimore_NEI, sum)

# Open PNG graphics device
png("plot2.png", width = 480, height = 480)

# Generate plot
plot(total_emissions$`baltimore_NEI$year`, total_emissions$`baltimore_NEI$Emissions`, type = "l", main = "Baltimore City, Maryland - Emissions per Year", ylab = "Emissions (PM25)", xlab = "Year", xaxt = "n")
axis(1, at = total_emissions$`baltimore_NEI$year`)

#Close PNG device
dev.off()
