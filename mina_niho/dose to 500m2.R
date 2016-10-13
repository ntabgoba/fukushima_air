# convert Fukushima Airdose from 10 codes to 9codes
# Dose is 100m2 i.e third order mesh/10x10, Popn is 500m2 i.e third order mesh/4(SW,SE,NW,NE)
fuk2013dose <- read.csv("fuk2013dose.csv")
View(fuk2013dose)
class(fuk2013dose$gridcode)
fuk2013dose$gridcode <- as.character(fuk2013dose$gridcode)
dose_mesh500 <- function (gride)
{
        mesh <- as.character(mesh)
        
        if (length(grep("^[0-9]{4}", mesh)) == 1) { 
                mesh12 <- as.numeric(substring(mesh, 1, 2))
                mesh34 <- as.numeric(substring(mesh, 3, 4))
                lat_width  <- 2 / 3;
                long_width <- 1;
        }
        else {
                return(NULL)
        }
        
        if (length(grep("^[0-9]{6}", mesh)) == 1) { 
                mesh5 <- as.numeric(substring(mesh, 5, 5))
                mesh6 <- as.numeric(substring(mesh, 6, 6))
                lat_width  <- lat_width / 8;
                long_width <- long_width / 8;
        }
}