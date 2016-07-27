#Minamisoma City Air Dose Analysis
library("leaflet")
library(readr)
library(dplyr)
library(RColorBrewer)
library(Hmisc)

list.files()
air03_2014 <- read_csv("marApril2014.csv")
View(air03_2014)
names(air03_2014) <- c("gridcode","startdate","enddate","pref","city","no_samples",
                       "AvgAirDoseRate","NE_nLat","NE_eLong","NW_nLat","NW_eLong",
                       "SW_nLat","SW_eLong","SE_nLat","SE_eLong")

airMar2014 <- air03_2014 %>%
        mutate(airdose_quant = cut2(air03_2014$AvgAirDoseRate,cuts=c(10,20,30,40,50,60,70,80,90),levels.mean=TRUE))

airMar2014 <- na.omit(airMar2014)

jio <- colorFactor(
        palette = "PuRd",
        domain = airMar2014$airdose_quant
)

mar2014_plot <- leaflet() %>%
        addTiles()%>%
        setView(lat = 37.4211, lng = 141.0328, zoom = 11) %>%
        addRectangles(data = airMar2014,lng1 = ~SW_eLong, lat1 = ~SW_nLat,lng2 = ~NE_eLong, lat2 = ~NE_nLat,
                      color = ~hahi(airMar2014$airdose_quant))%>%
        addLegend("bottomright", pal = jio, values = airMar2014$airdose_quant,
                  title = "AvgAirDoseRates",
                  labFormat = labelFormat(prefix = "µSv/h"),
                  opacity = 1)%>%
        addPopups(lat = 37.4211, lng = 141.0328,popup = fukulink,
                  options = popupOptions(closeButton = TRUE)) #adds popup
mar2014_plot

#MEXT evaluated the decrease in the air dose rates caused by the decay of cesium during the survey period and it was around 1%, 
# which was smaller than the errors of measuring instruments http://emdb.jaea.go.jp/emdb/en/portals/b131/