#Choreplat
library(choroplethr)
library(choroplethrAdmin1)
library(mapproj)
library(maps)
library(mapdata)
library(maptools)
library(scales)
data(df_japan_census)
install.packages("gpclib")
library(gpclib)
#tohoku region pop data
df_japan_census$value = df_japan_census$pop_2010
tohok = c("fukushima", "tochigi","ibaraki", "miyagi","yamagata","niigata","gunma")
admin1_choropleth(country.name = "japan", 
                  df           = df_japan_census, 
                  title        = "2010 Japan Population Estimates - Tohoku Region", 
                  legend       = "Population", 
                  num_colors   = 1, 
                  zoom         = tohok)
head(df_japan_census)
#list of all the countries
unique(admin1.regions$country)
# ggplot of japan
jp <- map_data("world",region=c("Japan"))
jpmap <- ggplot(jp, aes(x = long, y = lat, group = group)) +
        geom_polygon(fill = "white", colour = "black")+
        geom_
jpmap + geom_point(data = popAir,aes(colour = popAir$dose_quants, size = popAir$pop_quants))

## plotting population on to the map
ggplot(NULL) + 
        geom_polygon(data = jp, aes(x = long, y = lat, group = group), fill = "blue") +
        geom_point(data = pp_grp,aes(x = long, y = lat, group = group), shape=21, fill= pp_grp$totalpop)


#pointData$group <- 1 # ggplot needs a group to work with
pp_grp <- select(popAir, lat, long, totalpop) 
pp_grp$group <- 1
# group by gridecode and compare pop and total popn
a1 <- select(popAir, gridcode, daichi_distance, AvgAirDoseRate, totalpop)
?map_data
#####

map("worldHires", "Japan",
    xlim = c(-118.4, -86.7),
    ylim = c(14.5321, 32.71865),
    col = "blue", fill = TRUE)



