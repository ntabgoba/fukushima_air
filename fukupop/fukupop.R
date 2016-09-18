setwd("/Users/ntabgoba/Desktop/fukupop/")
list.files()
fukpop <- read.table("tblT000609H56400.txt",sep = ",")
fukpop <- fukpop[-2,]
View(fukpop)
summary(fukpop)
