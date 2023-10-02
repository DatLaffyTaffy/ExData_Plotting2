# Ensure data is in your working directory

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset SCC for codes containing "coal"
SCC_Coal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merge SCC_Coal with NEI to get only values with "Coal"
merged_NEI_SCC_Coal <- merge(NEI, SCC_Coal, by = "SCC")

# Generate total emissions per year
total_emissions <- aggregate(merged_NEI_SCC_Coal$Emissions ~ merged_NEI_SCC_Coal$year, merged_NEI_SCC_Coal, sum)

# Open PNG graphics device
png("plot4.png", width = 480, height = 480)

# Generate plot
plot(total_emissions$`merged_NEI_SCC_Coal$year`, total_emissions$`merged_NEI_SCC_Coal$Emissions`, type = "l", main = "Emissions per Year - Coal", ylab = "Emissions (PM25)", xlab = "Year", xaxt = "n")
axis(1, at = total_emissions$`merged_NEI_SCC_Coal$year`)

#Close PNG device
dev.off()