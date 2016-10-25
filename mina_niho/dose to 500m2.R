# convert Fukushima Airdose from 10 codes to 9codes
# Dose is 100m2 i.e third order mesh/10x10, Popn is 500m2 i.e third order mesh/4(SW,SE,NW,NE)
fuk2013dose <- read.csv("fuk2013dose.csv")
fuk_pll <- read.csv("fuk_pop.csv")
fuk_pll$gridcode <- as.character(fuk_pll$gridcode)
#length of each dataset
length(unique(fuk_pll$gridcode)); length(unique(fuk2013dose$gridcode))

#Change to character
fuk2013dose$gridcode <- as.character(fuk2013dose$gridcode)
# subset last 2 digits
gridelt1 <- substr(fuk2013dose$gridcode, 11,11)
gridelt2 <- substr(fuk2013dose$gridcode,12,12)
# change to numeric 
gridelt2 <- as.numeric(gridelt2)
gridelt1 <- as.numeric(gridelt1)
#subset first 10 digits
gridem <- substr(fuk2013dose$gridcode, 1,10)
#create a list for new var
mycode <- list()
for (i in 1:length(gridelt1)){
        if((gridelt1[i] >= 5) &  (gridelt1[i] <= 9) & (gridelt2[i] <= 5)){
                mycode[[i]] <- paste0(gridem[i],3)
        }
        if((gridelt1[i] >= 5) &  (gridelt1[i] <= 9) & (gridelt2[i] >= 5) &  (gridelt2[i] <= 9)){
                mycode[[i]] <- paste0(gridem[i],4)
        }
        if((gridelt1[i] <= 5) & (gridelt2[i] <= 5)){
                mycode[[i]] <- paste0(gridem[i],1)
        }
        if ((gridelt1[i] <= 5) &  (gridelt1[i] <= 9) & (gridelt2[i] >= 5) &  (gridelt2[i] <= 9)){
                mycode[[i]] <- paste0(gridem[i],2)
        }
}

# create the new var
fuk2013dose$gridcode <- mycode
fuk2013dose$gridcode <- gsub("_","",fuk2013dose$gridcode)

fukdose.unique <- fuk2013dose[!duplicated(fuk2013dose[, c("gridcode")]), ]

popAir_merge <- merge(x = fukdose.unique, y = fuk_pll, by.x = "gridcode", by.y = "gridcode")
View(popAir_merge)

# Check for compatibility with the Fuk Population data
length(unique(fuk2013dose$gridcode))  #16233  
length(unique(fuk_pop$gridcode)) #10831

#pick unique grides available to both only.
unique.pop_gride <- unique(fuk_pll$gridcode) 
unique.air_gride <- unique(fuk2013dose$gridcode)
#measure length of the unique grides
length(intersect(fuk_pop$gridcode,fuk2013dose$gridcode)) #6232
length(setdiff(as.character(unique.pop_gride),unique.air_gride)) # 4599
length(setequal(as.character(unique.pop_gride),unique.air_gride)) #1  #6232(merged dataset length)

gride.intersect <- intersect(fuk_pop$gridcode,fuk2013dose$gridcode)
class(gride.intersect); length(gride.intersect)
gride.intersect[1]


# gride_matcher function
meshes <- list()
gride_matcher <- function(mesh1,mesh2){
        mesh1 <- as.numeric(as.character(mesh2))
        for (i in 1:length(mesh1)){
                for (j in 1:length(mesh2)){
                        if (mesh1[i] == mesh2[j]){
                                meshes[[i]] <- mesh1[i]
                        }
                }
        }
}

matched_grides <- gride_matcher(mesh1=unique.pop_gride, mesh2 = unique.air_gride)
length(matched_grides); class(matched_grides)

#### create datasets for unique grides
library(dplyr)
unique.grides.pop <- filter(fuk_pll, gridcode == unique.pop_gride)
View(unique.grides.pop)
unique.grides.air <- mutate(fuk2013dose, unique.air_gride)

# relationship between 
library(Hmisc)
library(leaflet)
library(readr)
library(dplyr)
library(RColorBrewer)
library(ggplot2)

popAir_merged <- popAir_merge %>%
        mutate(pop_quants = (cut2(popAir_merge$totalpop,cuts=c(10,100,500,1000,1500,2000,2500,3000),levels.mean=TRUE,digits=0)))

write.csv(popAir_merged, file="popAir_merged.csv",row.names = FALSE)

### start 3:09pm 24th Oct 2016
list.files()
popAir <- read.csv("popAir_merged.csv")
View(popAir)
popAir1 <- select(popAir,"gridcode","pref", "city","gridCenterNorthlat","gridCenterEastlng","gridCenterNorthlatDec","gridCenterEastlngDec",
                  "daichi_distance","no_samples","AvgAirDoseRate","NE_nLat","NE_eLong","NW_eLong","SW_nLat","SW_eLong","SE_nLat","SE_eLong",
                  "dose_quants","totalpop","male","female","household","lat","long","pop_quants")

popAir1 <- select(popAir,gridcode,
                  daichi_distance,no_samples,AvgAirDoseRate,NE_nLat,NE_eLong,NW_eLong,SW_nLat,SW_eLong,SE_nLat,SE_eLong,
                  dose_quants,totalpop,male,female,lat,long,pop_quants)
popAirSmry <- group_by(popAir1, gridcode)
plot(popAirSmry$AvgAirDoseRate, popAirSmry$totalpop)

plot(x=popAirSmry$totalpop,type="l",col="red",ylab = "Avg Air Dose Rate",
     xlab = "Counts",main = "Compare AvgAirDoseRate and Popn per grid")
lines(popAirSmry$AvgAirDoseRate,col="green")
legend("topright", legend = c("AvgAirDoseRate","Popn"))
### End 24th Oct 2016
#plots
iro <- colorFactor(
        palette = "YlOrRd",
        domain = popAir_merged$pop_quants
)

fukulink <- paste(sep = "<br/>",
                  "<br><a href='http://www.tepco.co.jp
                  /en/decommision/index-e.html'>Fukushima Daichi</a></b>",
                  "Source of radiations")


popAir_plot <- leaflet() %>%
        addTiles()%>%
        addRectangles(data = popAir_merged,lng1 = ~SW_eLong, lat1 = ~SW_nLat,
                      lng2 = ~NE_eLong, lat2 = ~NE_nLat,
                      color = ~iro(popAir_merged$pop_quants))%>%
        addLegend("bottomright", pal = iro, values = popAir_merged$pop_quants,
                  title = "Population Dist",
                  labFormat = labelFormat(prefix = "no. of pple"),
                  opacity = 1)%>%
        addPopups(lat = 37.4211, lng = 141.0328,popup = fukulink,
                  options = popupOptions(closeButton = TRUE)) 
popAir_plot

# How far do people live from Daichi
ggplot(data = popAir_merged) +
        geom_bar(mapping = aes(x = daichi_distance, fill = pop_quants), width = 1)+
        ggtitle("Population dist with resp to Daichi Distance")

#

