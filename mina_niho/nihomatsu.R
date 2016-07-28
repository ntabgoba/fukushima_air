#Nihomatsu City Air Dose Analysis
library("leaflet")
library(readr)
library(dplyr)
library(RColorBrewer)
library(Hmisc)
##purposes of this vehicle survey were 
#(1) to ascertain the tendency and cause of time change of air dose rates by comparing past vehicle survey 
#data and survey meter data at the height of 1 m above ground as well as "walk survey" data, and 
# (2) to contribute to the establishment of radioactive substances distribution prediction model.

# Loading June 2011 Fukushima Data and selecting Nihomatsu's.
niho <- read_csv("jun_2011_fukushima.csv")
names(niho)
dim(niho)
head(niho)
class(niho)
#Change to machine readeable column names
names(niho) <- c("gridcode","pref","city","gridCenterNorthlat","gridCenterEastlng","gridCenterNorthlatDec",
                 "gridCenterEastlngDec","daichi_distance","no_samples","AvgAirDoseRate",
                       "NE_nLat","NE_eLong","NW_nLat","NW_eLong",
                       "SW_nLat","SW_eLong","SE_nLat","SE_eLong")
View(niho)
summary(niho$AvgAirDoseRate)
#Strip Nihommatsu city,
niho$city[niho$city == "Nihommatsu city"] <- "nihommatsu"

#filter nihomatsu dataset
nihom <- subset(niho, city == "nihommatsu")
dim(nihom)
class(nihom)
# Create air dose quantiles that are plot-able,6 categorical variables.
niho_q <- nihom %>%
        mutate(dose_quants = cut2(nihom$AvgAirDoseRate,cuts=c(0.1,0.5,1.0,1.5,2.0,2.5,3.0),levels.mean=TRUE))
View(niho_q)
niho_q <- na.omit(niho_q)
#Color function
iro <- colorFactor(
        palette = "RdPu",
        domain = niho_q$dose_quants
)
# Link of Daichi
fukulink <- paste(sep = "<br/>",
                  "<br><a href='http://www.tepco.co.jp/en/decommision/index-e.html'>Fukushima Daichi</a></b>",
                  "Source of radiations"
)
#Zoom area
min(niho_q$NE_nLat)
max(niho_q$SE_eLong)
#Nihomatsu Average Air Dose Rate Plot
niho_plot <- leaflet() %>%
        addTiles()%>%
        setView(lat = 37.4211, lng = 141.0328, zoom = 11) %>%
        addRectangles(data = niho_q,lng1 = ~SW_eLong, lat1 = ~SW_nLat,lng2 = ~NE_eLong, lat2 = ~NE_nLat,
                      color = ~iro(niho_q$dose_quants))%>%
        addLegend("bottomright", pal = iro, values = niho_q$dose_quants,
                  title = "AvgAirDoseRates",
                  labFormat = labelFormat(prefix = "µSv/h "),
                  opacity = 1)%>%
        addPopups(lat = 37.4211, lng = 141.0328,popup = fukulink,
                  options = popupOptions(closeButton = TRUE)) 
niho_plot

#MEXT evaluated the decrease in the air dose rates caused by the decay of cesium during the survey period and it was around 1%, 
# which was smaller than the errors of measuring instruments http://emdb.jaea.go.jp/emdb/en/portals/b131/

#plot Nihomatsu geo locations to Average Air Dose
ggplot(delay, aes(dist, delay)) +
        geom_point(aes(size = count), alpha = 1/3) +
        geom_smooth(se = FALSE)

#Capture discrepancies in variations of the dose
delays <- not_cancelled %>%
        group_by(tailnum) %>%
        summarise(
                delay = mean(arr_delay, na.rm = TRUE),
                n = n()
        )
ggplot(delays, aes(n, delay)) +
        geom_point()

# Do a ven diag 
ggplot(data = diamonds) +
        geom_bar(mapping = aes(x = cut, fill = cut), width = 1) +
        coord_polar()