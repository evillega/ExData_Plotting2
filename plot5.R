## Coursera Exploratory Data Analysis
## Assignment Project 2
## ExData_Plotting2
## 2014-10-26
## plot5.R
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
# 5. How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?
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


# Select values from vehicle emissions within Baltimore City(fips == "24510").
NEI_Baltimore <- NEI[NEI$fips == "24510", ]
Vehicles <- SSC[grepl("vehicles", SSC$SCC.Level.Two, ignore.case = TRUE), ]
Baltimore_Vehicles <- merge(x = NEI_Baltimore, y = Vehicles, by = "SCC")
Baltimore_Vehicles_Sum <- aggregate(Baltimore_Vehicles$Emissions, 
                                    by = list(Year = Baltimore_Vehicles$year), 
                                    FUN = sum)


# plot Emissions, by year using base R plotting
png(filename = "plot5.png", width = 600, height = 600)
plot(Baltimore_Vehicles_Sum$Year, Baltimore_Vehicles_Sum$x, ylab="Total PM2.5 Emission (tons)", 
     xlab="Year", type="l", 
     main = "Total PM2.5 Emissions from Motor Vehicle Emissions in Baltimore, MD")

dev.off()