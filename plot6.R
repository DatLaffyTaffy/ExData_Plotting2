# Ensure data is in your working directory

# Load packages
library(tidyr)
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Subset SCC for codes containing "motor vehicle"
SCC_Vehicle <- SCC[grepl("motor vehicle", SCC$Short.Name, ignore.case = TRUE), ]

### Merge SCC_Vehicle with NEI to get only values with "motor vehicle"
merged_NEI_SCC_Vehicle <- merge(NEI, SCC_Vehicle, by = "SCC")

# Take a subset for Baltimore City, Maryland (fips == "24510")
baltimore_merged <- merged_NEI_SCC_Vehicle[merged_NEI_SCC_Vehicle$fips == "24510",]

# Generate total emissions per year for Baltimore
total_emissions_baltimore <- aggregate(baltimore_merged$Emissions ~ baltimore_merged$year, baltimore_merged, sum)

# Rename column headers to enable smoother use in ggplot2
colnames(total_emissions_baltimore) <- c("x", "y")

# Take a subset for Los Angeles County, California (fips == "06037")
losangeles_merged <- merged_NEI_SCC_Vehicle[merged_NEI_SCC_Vehicle$fips == "06037",]

# Generate total emissions per year for Los Angeles
total_emissions_losangeles <- aggregate(losangeles_merged$Emissions ~ losangeles_merged$year, losangeles_merged, sum)

# Rename column headers to enable smoother use in ggplot2
colnames(total_emissions_losangeles) <- c("x", "y")

# Open PNG graphics device
png("plot6.png", width = 480, height = 480)

# Generate plot
plot <- ggplot() +
    geom_line(data = total_emissions_baltimore, aes(x = x, y = y, color = "Baltimore")) +
    geom_line(data = total_emissions_losangeles, aes(x = x, y = y, color = "Los Angeles")) +
    labs(title = "Emissions per Year - Motor Vehicles",
         x = "Year",
         y = "Emissions (PM25)",
         color = "Locations")
print(plot)

#Close PNG device
dev.off()