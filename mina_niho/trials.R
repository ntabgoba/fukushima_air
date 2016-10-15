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
