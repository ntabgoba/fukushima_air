#Choreplat

install.packages(c("choroplethr", "choroplethrAdmin1"))
library(choroplethr)
library(choroplethrAdmin1)
data(admin1.map)
admin_map(japan)
admin1_choropleth("japan"）+
                          
ggplot(admin1.map, aes(long, lat, group=group)) +
        geom_polygon()

popAir1$value = popAir1$pop_quants
admin1_choropleth("japan")
data(df_japan_census)
head(df_japan_census)

#tohoku region data pop
tohok = c("fukushima", "tochigi","ibaraki", "miyagi","yamagata","niigata","gunma")
admin1_choropleth(country.name = "japan", 
                  df           = df_japan_census, 
                  title        = "2010 Japan Population Estimates - Tohoku Region", 
                  legend       = "Population", 
                  num_colors   = 1, 
                  zoom         = tohok)
?get_admin1_regions("japan")


#us elections timeseries
data(df_president_ts)
# ?df_president_ts # time series of all US presidential elections 1789-2012
# create a list of choropleths of presidential election results for each year
choropleths = list()
for (i in 2:(ncol(df_president_ts))) {
        df = df_president_ts[, c(1, i)]
        colnames(df) = c("region", "value")
        title = paste0("Presidential Election Results: ", colnames(df_president_ts)[i]) 
        choropleths[[i-1]] = state_choropleth(df, title=title)
}
choroplethr_animate(choropleths)

