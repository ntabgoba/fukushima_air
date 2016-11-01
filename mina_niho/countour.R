# fukushima contours
# terminal: cp myfile.kmz myfile.zip,  unzip myfile.zip, cp doc.xml myfile.kml
library(maptools)
library(rgeos)
?getKMLcoordinates
fukContour <- getKMLcoordinates(fk,ignoreAltitude=TRUE)
str(fukContour)
fukContour[1:20]

fku <- readLines("contour/fukushima_contour.kml",skip = 48)
fku[1:50]
list.files()
str(fk)
fku[1:40]
