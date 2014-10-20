## Coursera Exploratory Data Analysis
## Assignment Project 2
## ExData_Plotting2
## 2014-10-19
## plot1.R
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

#==========================================================================================
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#    Using the base plotting system, make a plot showing the total PM2.5 emission from all 
#    sources for each of the years 1999, 2002, 2005, and 2008.
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

# Total PM2.5 emissions in the US.  Total sum for each year.
NEI_sum <- aggregate(NEI$Emissions, by = list(NEI$year), FUN = sum)
head(NEI_sum)
# Group.1       x
#1    1999 7332967
#2    2002 5635780
#3    2005 5454703
#4    2008 3464206

# plot Emissions, by year using base R plotting
png(filename = "plot1.png", width = 480, height = 480)
plot(NEI_sum$Group.1, NEI_sum$x, type = "l", 
     ylab = "Total PM2.5 Emission", xlab = "Year", 
     main = "Total PM2.5 Emissions in the United States")
dev.off()

