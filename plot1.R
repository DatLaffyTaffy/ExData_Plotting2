# Ensure data is in your working directory

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Generate total emissions per year
total_emissions <- aggregate(NEI$Emissions ~ NEI$year, NEI, sum)

# Open PNG graphics device
png("plot1.png", width = 480, height = 480)

# Generate plot
plot(total_emissions$`NEI$year`, total_emissions$`NEI$Emissions`, type = "l", main = "Emissions per Year", ylab = "Emissions (PM25)", xlab = "Year", xaxt = "n")
axis(1, at = total_emissions$`NEI$year`)

#Close PNG device
dev.off()
