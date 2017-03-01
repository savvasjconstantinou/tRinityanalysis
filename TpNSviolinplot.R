#script to create violin plot for normal segmentation in Thamnocephalus platyurus. Want to visualize the differences
# in engrailed number by age and demonstrate the number of points collected.

#load required libraries
library(data.table)
library(ggplot2)

#read in data
TpNS<- fread("C:/Users/Savvas Constantinou/Downloads/TpNS.csv")

#check data to make sure it has correct no. columns and rows
TpNS

#convert age to a factor variable and check
TpNS$Age <- as.factor((TpNS$Age))
str(TpNS$Age)

#Generate basic violin plot
p <- ggplot(TpNS, aes(x=Age, y=EN)) +
geom_violin()
p
