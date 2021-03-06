#Choreplat
library(choroplethr)
library(choroplethrAdmin1)
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


