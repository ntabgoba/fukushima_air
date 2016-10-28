#Choreplat
library(choroplethr)
library(choroplethrAdmin1)
library(mapproj)
data(admin1.map)
admin_map(japan)
data(df_japan_census)
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
ggplot(jp, aes(x = long, y = lat, group = group)) +
        geom_polygon(fill = "white", colour = "black")
