#Does Land Use and population density affect Fukushima Air Dose reduction ?
#Collect relevant data, explore and #Apply different models to test the hypothesis
library(dplyr)
library(readr)
library(ggplot2)
pas <- url("http://emdb.jaea.go.jp/emdb/assets/site_data/en/csv_utf8/10214700024/10214700024_00_201301.csv.zip")
# http://emdb.jaea.go.jp/emdb/assets/site_data/en/csv_utf8/10214700024/10214700024_00_201301.csv.zip
# http://emdb.jaea.go.jp/emdb/assets/site_data/en/csv_utf8/10214700024/10214700024_00_201302.csv.zip
# http://emdb.jaea.go.jp/emdb/assets/site_data/en/csv_utf8/10214700025/10214700025_00_201304.csv.zip
# http://emdb.jaea.go.jp/emdb/assets/site_data/en/csv_utf8/10214700026/10214700026_00_201404.csv.zip

url_2013 <- "http://emdb.jaea.go.jp/emdb/assets/site_data/en/csv_utf8/10214700024/10214700024_00_2013"
url_2014 <- "http://emdb.jaea.go.jp/emdb/assets/site_data/en/csv_utf8/10214700026/10214700026_00_2014"

# any(grepl("tidyr",installed.packages()))
# sum(file.info(list.files(".", all.files = TRUE, recursive = TRUE))$size) 

temp = list.files(pattern="*.csv")
myfiles = lapply(temp, read_csv)
myfile <- as.data.frame(myfiles)
class(temp)
class(myfiles)
View(myfiles)
air2 <- read_csv(file = "10200000002_07.csv")
air3 <- read_csv(file = "10200000003_07.csv")
air4 <- read_csv(file = "10200000004_07.csv")
air5 <- read_csv(file = "10200000005_07.csv")
air6 <- read_csv(file = "10200000006_07.csv")
dim(air2)
str(air2)
names(air2) <- c("gridcode","startdate","enddate","pref","city","no_samples",
                 "AvgAirDoseRate","NE_nLat","NE_eLong","NW_nLat","NW_eLong",
                 "SW_nLat","SW_eLong","SE_nLat","SE_eLong")
names(air2)
ggplot(data = air2,mapping = aes(x = enddate, y = AvgAirDoseRate) )+
        geom_point()
#Try other datasets, above only contain on day basis.
aug2011 <- read_csv("first_vehicle_aug2011.csv")
dim(aug2011)
View(aug2011)

# map the Air dose on to the Spatial Points
library(rgdal)
pal <- colorNumeric(
        palette = "Blues",
        domain = air2$AvgAirDoseRate
)
ji <- leaflet()%>%
        addTiles()%>%
        addPolygons(data = air2,lng = ~NE_eLong, lat = ~NE_nLat,stroke = FALSE, smoothFactor = 0.2, fillOpacity = 1)%>%
        addPopups(lat = 37.4211, lng = 141.0328,popup = fukulink,
                  options = popupOptions(closeButton = TRUE))
ji