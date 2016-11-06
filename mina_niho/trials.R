# learn merge
data1 <- data.frame(a = c(23,24,25), b = c(11,14,13))
data2 <- data.frame(a = c(2112,3112,23,4112,25), b = c(5312,11,14,136312,7312))

newd <- Reduce(rbind, list(data1,data2))
View(newd)
data3$c <- gsub('.{1}$', '', data3$c)

data4 <- data.frame(a = c(111222333,444555666,777888999), b = c("jo","ho","wo"))
View(data4)                   
length(grep("^[0-9]{4}", data4$a))
grep("^[0-9]2",data4$a)
h <- grep      

gio <- c("5539_3287_27","5539_3287_37","5539_3287_47")
substr(gio,11,12)

#trials
library(mapproj)

ggplot() +
        geom_point(data = popAir1, 
                     aes(x = SW_eLong, y = SW_nLat,  fill = dose_quants), size = 0.8) + 
        coord_map()

jp <- map_data("japan")
?map_data
ggplot(jp, aes(long, lat, group = group)) +
        geom_polygon(fill = "white", colour = "black")

ggplot(jp, aes(long, lat, group = group)) +
        geom_polygon(fill = "white", colour = "black") +
        coord_quickmap()