# convert Fukushima Airdose from 10 codes to 9codes
# Dose is 100m2 i.e third order mesh/10x10, Popn is 500m2 i.e third order mesh/4(SW,SE,NW,NE)
fuk2013dose <- read.csv("fuk2013dose.csv")
View(fuk2013dose)
class(fuk2013dose$gridcode)
fuk2013dose$gridcode <- as.character(fuk2013dose$gridcode)
fuk2013dose$gridcode <- gsub("_","",fuk2013_q$gridcode)

dose_mesh500 <- function (gridecode)
{
        a <- as.numeric(substr(gridecode, 11,11))
        b <- as.numeric(substr(gridecode,12,12))
        if((a - 6)  *  (10 - a) > 0 & (b <= 5)){
                gridecode <- paste(gridcode,3)
        }
        if (gridelt1 > 5 & gridelt1 < 9 ) { 
                mesh12 <- as.numeric(substring(mesh, 1, 2))
                mesh34 <- as.numeric(substring(mesh, 3, 4))
                lat_width  <- 2 / 3;
                long_width <- 1;
        }
}
?grep
?paste
gi <- fuk2013dose$gridcode[1:5]
gridelt1 <- substr(fuk2013dose$gridcode, 11,11)
gridelt1
gridelt2 <- substr(fuk2013dose$gridcode,12,12)
gridelt2

is.between <- function(x, a, b) {
        x > a & x < b
}
gridelt2 <- as.numeric(gridelt2)
gridelt1 <- as.numeric(gridelt1)
for (i in 1:length(gridelt1)){
        for (j in 1:length(gridelt2)){
                if((gridelt1[i] - 6)  *  (10 - gridelt1[i]) > 0 & (gridelt2[j] <= 5)){
                        paste(gi,3)
                }
        }
}
gridekode 
warnings()
