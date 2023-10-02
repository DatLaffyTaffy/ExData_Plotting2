# Ensure data is in your working directory

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Load packages
library(tidyr)
library(ggplot2)

# Take a subset for Baltimore City, Maryland (fips == "24510")
baltimore_NEI <- NEI[NEI$fips == "24510",]

# Generate total emissions per year per type
total_emissions <- aggregate(baltimore_NEI$Emissions ~ baltimore_NEI$year + baltimore_NEI$type, baltimore_NEI, sum)

# Split each type into different columns
total_emissions_type <- pivot_wider(data = total_emissions, names_from = `baltimore_NEI$type`, values_from = `baltimore_NEI$Emissions`)

# Rename column headers to enable smoother use in ggplot2
colnames(total_emissions_type) <- c("year", "NON-ROAD", "NON-POINT", "ON-ROAD", "POINT")

# Open PNG graphics device
png("plot3.png", width = 480, height = 480)

# Generate ggplot 
my_plot <- total_emissions_type %>%
    gather(key = "variable", value = "value", -year) %>%
    ggplot(aes(x = year, y = value, color = variable)) +
    geom_line() +
    labs(title = "Baltimore City, Maryland - Emissions per Year per Type",
         x = "Year",
         y = "Emissions (PM25)",
         color = "Variables")
print(my_plot)

#Close PNG device
dev.off()
