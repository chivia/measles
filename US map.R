library(ggplot2)
library(maps) 
library(mapproj)
# For map data
# Get map data for USA
states_map <- map_data("state")
ggplot(states_map, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="white", colour="black")
# geom_path (no fill) and Mercator projection
ggplot(states_map, aes(x=long, y=lat, group=group)) +
  geom_path() + coord_map("mercator")
