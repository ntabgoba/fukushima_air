#Choreplat

install.packages(c("choroplethr", "choroplethrAdmin1"))
library(choroplethr)
library(choroplethrAdmin1)
data(admin1.map)
admin_map(japan)
admin1_choropleth("japan"）
ggplot(admin1.map, aes(long, lat, group=group)) +
        geom_polygon()

df_japan_census$value = $pop_density_km2_2010
admin1_choropleth("japan", df_japan_census)
data(df_japan_census)
head(df_japan_census)
