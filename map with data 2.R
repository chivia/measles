# data map
#
library(maps) # to draw the map
library(plotrix) # to color the map
map("usa")
data(votes.repub) # contains names of states

tax <- c(5.0, NA,4.5,7.0,12.3,4.6,6.7,6.8,NA,6.0,11.0,7.4,5.0,
      3.4,9.0,4.9,6.0,6.0,8.0,5.8,5.3,4.3,7.9,5.0,6.0,6.9,
      6.8,NA,NA,9.0,4.9,8.8,7.8,4.0,5.9,5.3,9.9,3.1,6.0,7.0,
      NA,NA,NA,5.0,9.0,5.8,NA,6.5,7.8,NA)

temp <- cbind(votes.repub, tax)

#now drop all the other columns and just leave the tax data

data <- temp[,c(32)]

# match the statenames

state.to.map <- match.map("state", state.name, exact=F)

# store the result in x

x <- data[state.to.map]

# plot
# set the colors

state.col <- color.scale(x,c(0,300),35,50,color.spec="hcl")
#background color
par(bg="cornsilk")
# plot the map with colors
map("state",fill=TRUE,col=state.col)
# add title and subtitle
title(main="2013 State Income Tax Map", sub="Zero income tax states not colored")
# add legend
legend(x="bottomleft",inset=-.0, bty="n", cex=0.75,text.col="darkred",
       c("Low","Low to medium","Mid","High"),fill=state.col)



