#land use
# http://nlftp.mlit.go.jp/ksj-e/index.html
# The World Geodetic System (WGS) is a standard for use in cartography, geodesy, and navigation including GPS. 
#It comprises a standard coordinate system for the Earth, a standard spheroidal reference surface 
#(the datum or reference ellipsoid) for raw altitude data, and a gravitational equipotential surface 
# (the geoid) that defines the nominal sea level.

library(Rcmdr)
attach(mtcars)
scatter3d(wt, disp, mpg)
install.packages("Rcmdr")
library(rgl)
install.packages("rgl")
