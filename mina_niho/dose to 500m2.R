# convert Fukushima Airdose from 10 codes to 9codes
# Dose is 100m2 i.e third order mesh/10x10, Popn is 500m2 i.e third order mesh/4(SW,SE,NW,NE)
fuk2013dose <- read.csv("fuk2013dose.csv")
fuk_pll <- read.csv("fuk_pop.csv")
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
View(fuk2013dose)
# Check for compatibility with the Fuk Population data
length(unique(fuk2013dose$gridcode))  #16233
length(unique(fuk_pop$gridcode)) #10831

#pick unique grides available to both only.
unique.pop_gride <- unique(fuk_pll$gridcode) 
unique.air_gride <- unique(fuk2013dose$gridcode)
#measure length of the unique grides
length(intersect(fuk_pop$gridcode,fuk2013dose$gridcode)) #6232
length(setdiff(fuk_pop$gridcode,fuk2013dose$gridcode)) #4599
length(setdiff(as.character(unique.pop_gride),unique.air_gride)) # 4599
length(setequal(as.character(unique.pop_gride),unique.air_gride)) #1

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
View(unique.grides.air)
unique.air_gride

unique.pop_gride

