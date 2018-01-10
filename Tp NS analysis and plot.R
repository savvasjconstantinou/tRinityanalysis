#script to create  plot for normal segmentation in Thamnocephalus platyurus. Want to visualize the differences
# in engrailed number by age and demonstrate the number of points collected.

#load required libraries
library(data.table)
library(Hmisc)
library(extrafont)
loadfonts()

#read in data
TpNS<- fread("C:/Users/Savvas Constantinou/Downloads/Downloads/TpNS.csv", stringsAsFactors = F)

#check data to make sure it has correct no. columns and rows and they are both integers
str(TpNS)

#add "jitter" to the age and en amounts. This changes these whole numbers slightly, displacing them 
#around the true value and allows for better graphical visualization
jAge<-jitter(TpNS$Age, amount=0.1)
jEN<-jitter(TpNS$EN, amount=0.1)

#Add jitter columns to dataframe and check 
TpNS<-cbind(TpNS, jAge, jEN)
TpNS

#perform a linear regression on the raw data, pull out the adj R. squared
linreg<-lm(EN~Age, data=TpNS)
summary(linreg)
adjr2<-format(summary(linreg)$r.squared, digits=3)
adjr2

#save as pdf, output will be in working directory
pdf("TpNsJitterPlot.pdf", family="ArialMT")

#plot the "jitter-ed"data, remove x axis so we can specify ticks later
plot(TpNS$jAge, TpNS$jEN, bty="n", pch='°', xlab="Age post-hatching (hours)", 
     ylab="Number of EN stripes", ylim=c(0,18), yaxt="n", xaxt="n", cex.lab=2, mgp=c(2.3,0.25,0))
#add tick marks and axes
ticks<-c(-1:18)
ticksy<-seq(0, 18, 3)
axis(1, at=ticks, labels=ticks, lwd=3, pos=0, cex.axis=1.5)
axis(2, at=ticksy, labels=ticksy, lwd=3, pos=-0.8, cex.axis=1.5)

#add the linear regression line from the analysis, a line @4 hours to denote molt event, 
# a line @ ~12 hours to indicate the T/G transition and a line @ ~15 hours to indicate G/A
#transition, and a legend with R^2 value
abline(linreg, lwd=2)
abline(v=4, lty=2)
abline(v=12.3, lty=1)
abline(v=15.2, lty=1)
legend("top", bty="n", legend=expression(paste("R" ^"2","=0.974")), cex=2)

#close plotting environment and send to pdf
dev.off()
