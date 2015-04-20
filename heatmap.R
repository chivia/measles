
library(ggplot2)
library(maps) 
library(mapproj)
library(plyr) # For arrange() function
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
crimes

states_map <- map_data("state")

# Merge the data sets together
crime_map <- merge(states_map, crimes, by.x="region", by.y="state")
# After merging, the order has changed, which would lead to polygons drawn in
# the incorrect order. So, we sort the data.
head(crime_map)


# Sort by group, then order
crime_map <- arrange(crime_map, group, order)
head(crime_map)

ggplot(crime_map, aes(x=long, y=lat, group=group, fill=Assault)) +
  geom_polygon(colour="black") +
  coord_map("polyconic")

ggplot(crimes, aes(map_id = state, fill=Assault)) +
  geom_map(map = states_map, colour="black") +
  scale_fill_gradient2(low="#559999", mid="grey90", high="#BB650B",
                       midpoint=median(crimes$Assault)) +
  expand_limits(x = states_map$long, y = states_map$lat) +
  coord_map("polyconic")

# Find the quantile bounds
qa <- quantile(crimes$Assault, c(0, 0.2, 0.4, 0.6, 0.8, 1.0))
qa

# Add a column of the quantile category
crimes$Assault_q <- cut(crimes$Assault, qa,
                        labels=c("0-20%", "20-40%", "40-60%", "60-80%", "80-100%"),
                        include.lowest=TRUE)
crimes

# Generate a discrete color palette with 5 values
pal <- colorRampPalette(c("#559999", "grey80", "#BB650B"))(5)
pal

ggplot(crimes, aes(map_id = state, fill=Assault_q)) +
  geom_map(map = states_map, colour="black") +
  scale_fill_manual(values=pal) +
  expand_limits(x = states_map$long, y = states_map$lat) +
  coord_map("polyconic") +
  labs(fill="Assault Rate\nPercentile")

# The 'state' column in the crimes data is to be matched to the 'region' column
# in the states_map data
ggplot(crimes, aes(map_id = state, fill=Assault)) +
  geom_map(map = states_map) +
  expand_limits(x = states_map$long, y = states_map$lat) +
  coord_map("polyconic")










