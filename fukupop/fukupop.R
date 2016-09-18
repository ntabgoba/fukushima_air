setwd("/Users/ntabgoba/Desktop/fukushima_air/fukupop")
list.files()
fukpop <- read.table("tblT000609H56400.txt",sep = ",")
fukpop <- fukpop[-2,]
View(fukpop)
summary(fukpop)
fukpop$V2[fukpop$V2 == "T000609001"] <- "totalpop"
fukupop <- setNames(fukpop,c("gridcode","totalpop","male","female","household"))
View(fukupop)
fukupop <- fukupop[-1,]
