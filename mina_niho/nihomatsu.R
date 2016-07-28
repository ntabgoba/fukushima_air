#Nihomatsu vs Mimanisoma City Average Air Dose Rate Analysis

#Part I: Nihomatsu City,70km to Fukushima Daichi
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
write_csv(niho_q, path = "niho_q.csv")
#Color function
iro <- colorFactor(
        palette = "YlOrRd",
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
ggplot(niho_q, aes(daichi_distance,AvgAirDoseRate)) +
        geom_point() +
        geom_smooth(se = FALSE)+
        ggtitle("AvgAirDose against Distance to Daichi Plant")


# Repeat above visualization from a different view 
ggplot(data = niho_q) +
        geom_bar(mapping = aes(x = daichi_distance, fill = dose_quants), width = 1)+
        ggtitle("AvgAirDose Measured Counts against Daichi Distance")










#PART II: Minamisoma City, 30km to Fukushima Daichi
mina <- read_csv("niho.csv")
dim(mina)
View(mina)

#Select Minamisoma City only
mina$city[mina$city == "Minamisoma city"] <- "minamisoma"

#filter nihomatsu dataset
mina <- subset(mina, city == "minamisoma")
dim(mina)
class(mina)
summary(mina$AvgAirDoseRate)
#plot(mina$AvgAirDoseRate)

# Create air dose quantiles that are plot-able,6 categorical variables.
mina_q <- mina %>%
        mutate(mina_quants = cut2(mina$AvgAirDoseRate,cuts=seq(0.2,20,2.2),levels.mean=TRUE))
View(mina_q)
mina_q <- na.omit(mina_q)
write_csv(mina_q, path = "mina_q.csv")
#Color function
iro <- colorFactor(
        palette = "BuPu",
        domain = mina_q$mina_quants
)
# Link of Daichi
fukulink <- paste(sep = "<br/>",
                  "<br><a href='http://www.tepco.co.jp/en/decommision/index-e.html'>Fukushima Daichi</a></b>",
                  "Source of radiations"
)

#Zoom area
min(mina_q$NE_nLat)
max(mina_q$SE_eLong)
#Nihomatsu Average Air Dose Rate Plot
mina_plot <- leaflet() %>%
        addTiles()%>%
        addRectangles(data = mina_q,lng1 = ~SW_eLong, lat1 = ~SW_nLat,lng2 = ~NE_eLong, lat2 = ~NE_nLat,
                      color = ~iro(mina_q$mina_quants))%>%
        addLegend("bottomright", pal = iro, values = mina_q$mina_quants,
                  title = "AvgAirDoseRates",
                  labFormat = labelFormat(prefix = "µSv/h "),
                  opacity = 1)%>%
        addPopups(lat = 37.4211, lng = 141.0328,popup = fukulink,
                  options = popupOptions(closeButton = TRUE)) 
mina_plot
