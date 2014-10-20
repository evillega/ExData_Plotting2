## Coursera Exploratory Data Analysis
## Assignment Project 2
## ExData_Plotting2
## 2014-10-19
## plot2.R
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
# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.  
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

# Total PM2.5 emissions for Baltimore City (fips == "24510").
NEI_Baltimore <- NEI[NEI$fips == "24510", ]
dim(NEI_Baltimore)
# [1] 2096    6
NEI_sum <- aggregate(NEI_Baltimore$Emissions, by = list(NEI_Baltimore$year), FUN = sum)
head(NEI_sum)
# Group.1       x
# 1    1999 3274.180
# 2    2002 2453.916
# 3    2005 3091.354
# 4    2008 1862.282

# plot Emissions, by year using base R plotting
png(filename = "plot2.png", width = 480, height = 480)
plot(NEI_sum$Group.1, NEI_sum$x, type = "l", 
     ylab = "Total PM2.5 Emission", xlab = "Year", 
     main = "Total PM2.5 Emissions in Baltimore City")
dev.off()

