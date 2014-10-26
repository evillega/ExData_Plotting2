## Coursera Exploratory Data Analysis
## Assignment Project 2
## ExData_Plotting2
## 2014-10-26
## plot4.R
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

#==========================================================================================
# 4. Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?
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


# Merge NEI and SSC data set togehter then 
# Subset merged data to only contain Coal emissions in the US
Coal <- SSC[grepl("coal", SSC$Short.Name, ignore.case = TRUE), ]
NEI_Coal <- merge(x = NEI, y = Coal, by = "SCC")
# names(NEI_Coal)
# [1] "SCC"                 "fips"                "Pollutant"          
# [4] "Emissions"           "type"                "year"               
# [7] "Data.Category"       "Short.Name"          "EI.Sector"          
# [10] "Option.Group"        "Option.Set"          "SCC.Level.One"      
# [13] "SCC.Level.Two"       "SCC.Level.Three"     "SCC.Level.Four"     
# [16] "Map.To"              "Last.Inventory.Year" "Created_Date"       
# [19] "Revised_Date"        "Usage.Notes"  

NEI_Coal <- NEI_Coal[ , c(4, 6)]
NEI_Coal_Sum <-aggregate(NEI_Coal, by=list(Year = NEI_Coal$year), FUN=sum, na.rm=TRUE)

# plot total Coal emissions in the US using Base R graphing program
png(filename = "plot4.png", width = 480, height = 480)
plot(NEI_Coal_Sum$Year, NEI_Coal_Sum$Emissions, ylab="Total PM2.5 Emission (tons)", 
     xlab="Year", type="l", 
     main = "Total PM2.5 Emissions from Coal Combustion-Related Sources")

dev.off()