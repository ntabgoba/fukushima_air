# convert Fukushima Airdose from 10 codes to 9codes
# Dose is 100m2 i.e third order mesh/10x10, Popn is 500m2 i.e third order mesh/4(SW,SE,NW,NE)
fuk2013dose <- read.csv("fuk2013dose.csv")
View(fuk2013dose)
class(fuk2013dose$gridcode)
#Change to character
fuk2013dose$gridcode <- as.character(fuk2013dose$gridcode)
fuk2013dose$gridcode <- gsub("_","",fuk2013_q$gridcode)
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

class(mycode);length(mycode) 
mycode[1:50]
# create the new var
fuk2013dose$gridcode <- mycode


