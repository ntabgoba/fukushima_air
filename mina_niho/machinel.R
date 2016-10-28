#Machine learning
fit2 <- lm(AvgAirDoseRate~daichi_distance + totalpop, data = popAir)
summary(fit2)
confint(fit2)
