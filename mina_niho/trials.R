# learn merge
data1 <- data.frame(a = c("ji","hi","we"), b = c("jo","ho","wo"))
data2 <- data.frame(c = c(2112,3112,4112), d = c(5312,6312,7312))
data3 <- merge(data1,data2)
data3$c <- gsub('.{1}$', '', data3$c)

data4 <- data.frame(a = c(111222333,444555666,777888999), b = c("jo","ho","wo"))
View(data4)                   
length(grep("^[0-9]{4}", data4$a))
grep("^[0-9]2",data4$a)
h <- grep      

gio <- c("5539_3287_27","5539_3287_37","5539_3287_47")
substr(gio,11,12)

plot_ly(z = ~volcano, type = "surface")
?plotly

toplot <- as.matrix(x= popAir1$daichi_distance, y = popAir1$AvgAirDoseRate, z = popAir1$totalpop)
plot_ly(z = ~toplot, type = "surface") 
%>% add_surface()

#jap
g <- list(
        scope = 'japan',
        showland = T,
        landcolor = toRGB("gray90"),
        showcountries = F,
        subunitcolor = toRGB("white")
)

plot_geo(popAir1) %>%
        add_markers(data = popAir1,x = ~SW_eLong, y = ~SW_nLat, color = I("blue"), alpha = 0.5) %>%
        layout(geo = g)
?plot_geo


