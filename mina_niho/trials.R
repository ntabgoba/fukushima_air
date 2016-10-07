# learn merge
data1 <- data.frame(a = c("ji","hi","we"), b = c("jo","ho","wo"))
data2 <- data.frame(c = c(2112,3112,4112), d = c(5312,6312,7312))
data3 <- merge(data1,data2)
data3$c <- gsub('.{1}$', '', data3$c)
                    