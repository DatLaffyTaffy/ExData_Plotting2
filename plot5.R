# Ensure data is in your working directory

# Load packages
library(tidyr)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset SCC for codes containing "motor vehicle"
SCC_Vehicle <- SCC[grepl("motor vehicle", SCC$Short.Name, ignore.case = TRUE), ]

# Merge SCC_Vehicle with NEI to get only values with "motor vehicle"
merged_NEI_SCC_Vehicle <- merge(NEI, SCC_Vehicle, by = "SCC")

# Take a subset for Baltimore City, Maryland (fips == "24510")
baltimore_merged <- merged_NEI_SCC_Vehicle[merged_NEI_SCC_Vehicle$fips == "24510",]

# Generate total emissions per year
total_emissions <- aggregate(baltimore_merged$Emissions ~ baltimore_merged$year, baltimore_merged, sum)

# Open PNG graphics device
png("plot5.png", width = 480, height = 480)

# Generate plot
plot(total_emissions$`baltimore_merged$year`, total_emissions$`baltimore_merged$Emissions`, type = "l", main = "Emissions per Year - Motor Vehicles - Baltimore", ylab = "Emissions (PM25)", xlab = "Year", xaxt = "n")
axis(1, at = total_emissions$`baltimore_merged$year`)

#Close PNG device
dev.off()