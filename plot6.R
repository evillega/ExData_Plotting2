## Coursera Exploratory Data Analysis
## Assignment Project 2
## ExData_Plotting2
## 2014-10-19
## plot6.R
#==========================================================================================
# Assignment instructions:
# The overall goal of this assignment is to explore the National Emissions Inventory 
# database and see what it say about fine particulate matter pollution in the United 
# States over the 10-year period 1999–2008. You may use any R package you want to support 
# your analysis.
#==========================================================================================


#==========================================================================================
# i. Prepare directory and load any required packages
#==========================================================================================
# check working directory
getwd()

# if wrong working directory then set directory
# insert file path between the ""
setwd("~/Desktop/Coursera/Data Science/4-Exploratory Data Analysis/4-Project_2/ExData_Plotting2")

# Clean up workspace
rm(list = ls())

# Check if "data" directory already exists.
# If not, then it creates "data" directory, where all data pertaining to this code
# are stored.  
if(!file.exists("data")) {
     dir.create("data")
}

library(ggplot2)
library(plyr)
#==========================================================================================
# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
#==========================================================================================
# Download RDF files into the following vectors
NEI <- readRDS("./data/summarySCC_PM25.rds")
SSC <- readRDS("./data/Source_Classification_Code.rds")

# Explore datasets
dim(NEI)  # 6497651       6
colnames(NEI)
# [1] "fips"      "SCC"       "Pollutant" "Emissions" "type"      "year" 

dim(SSC)  # 11717    15
colnames(SSC)
# [1] "SCC"                 "Data.Category"       "Short.Name"         
# [4] "EI.Sector"           "Option.Group"        "Option.Set"         
# [7] "SCC.Level.One"       "SCC.Level.Two"       "SCC.Level.Three"    
# [10] "SCC.Level.Four"      "Map.To"              "Last.Inventory.Year"
# [13] "Created_Date"        "Revised_Date"        "Usage.Notes" 


# Select values from vehicle emissions within Baltimore City (fips == "24510")
# and Los Angeles (fips == "06037").
Baltimore_LA <- subset(NEI, fips == "24510" | fips == "06037")
Vehicles <- SSC[grepl("vehicles", SSC$SCC.Level.Two, ignore.case = TRUE), ]
LABalt_vehicles <- merge( x = Baltimore_LA, y = Vehicles, by = "SCC")
LABalt_vehicles <- LABalt_vehicles[ , c(2, 4, 6)]
LABalt_emissions <- ddply(LABalt_vehicles, .(year, fips), summarize, Total_Emissions = sum(Emissions) )
LABalt_emissions$city[LABalt_emissions$fips=="24510"]<-"Baltimore"
LABalt_emissions$city[LABalt_emissions$fips=="06037"]<-"LA"


# plot Emissions, by year using ggplot2
png(filename = "plot6.png", width = 480, height = 480)
plot <- ggplot(LABalt_emissions,aes(year,Total_Emissions))
plot + geom_line(aes(color = city)) + 
                    labs( title = "PM2.5 Emission from Motor Vehicle Sources",
                                              y = "Total PM2.5 Emission (tons)")
dev.off()
