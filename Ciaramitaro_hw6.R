library(ggmap)
library(tidyverse)
library(magick)
gc <- geocode("bude")

beachlabs <- c("Northcott Mouth Beach, Bude", "Widemouth Bay Beach, Bude")
beaches <- geocode(beachlabs)

pub <- geocode("36 Lansdown Rd, Bude EX23 8BN, UK") #The Barrel at Bude
cricket = geocode("Bude North Cornwall Cricket Club") 
crickettopub <- route(from = " S W Coast Path, Bude EX23 8HN, UK", to = "36 Lansdown Rd, Bude EX23 8BN, UK", mode = "walking",structure = "route")  

roadmap <- ggmap(get_map(gc, zoom= 12, maptype = "roadmap"))+
  #beaches
  geom_point(aes(x= lon, y= lat), data = beaches, color = "white", size = 5) + #white circle
  geom_point(aes(x= lon, y= lat), data = beaches, color = "#DC143C", size = 4.5) + #red circle
  geom_point(aes(x= lon, y= lat), data = beaches, color = "white", size = 1.8) + #white dot
  geom_text(aes(x = lon, y = lat, label = beachlabs), data = beaches, size = 3.5, 
            vjust=0, hjust=1.1, colour = "#DC143C", fontface = "bold", family = "verdana", alpha = .7) +
  
  #pub
  geom_point(aes(x=lon, y=lat), data = pub, color = "#008080", size = 4.5, shape = 18) + #teal diamond
  geom_point(aes(x=lon, y=lat), data = pub, color = "white", size = 1.8, shape = 18) + #white diamond
  geom_text(aes(x=lon, y=lat, label = "The Barrel at Bude"), data = pub, size = 3.5,
            vjust = -1, hjust = -.04, colour = "#DC143C", fontface = "bold", family = "verdana", alpha=.7 ) +
  
  #cricket place
  geom_point(aes(x=lon, y=lat), data=cricket, color = "orange", size = 4.5, shape=15) + #orange square
  geom_point(aes(x=lon, y=lat), data=cricket, color = "white", size = 1.8, shape=15) + #white square
  geom_text(aes(x = lon, y = lat, label = "Bude North Cornwall Cricket Club"), data = cricket, size = 3.5,
            vjust = .5, hjust = 1.05, colour = "#DC143C", fontface = "bold", family = "verdana", alpha=.7 ) +
  
  #Route from Cricket to Pub
  geom_path(
    aes(x = lon, y = lat),  colour = "green", size = 1.5,
    data = crickettopub, lineend = "round"
  )
watercolor <- ggmap(get_map(gc, zoom= 12, maptype = "watercolor"))+
  #beaches
  geom_point(aes(x= lon, y= lat), data = beaches, color = "white", size = 5) + #white circle
  geom_point(aes(x= lon, y= lat), data = beaches, color = "#DC143C", size = 4.5) + #red circle
  geom_point(aes(x= lon, y= lat), data = beaches, color = "white", size = 1.8) + #white dot
  geom_text(aes(x = lon, y = lat, label = beachlabs), data = beaches, size = 3.5, 
            vjust=0, hjust=1.1, colour = "#DC143C", fontface = "bold", family = "verdana", alpha = .7) +
  
  #pub
  geom_point(aes(x=lon, y=lat), data = pub, color = "#008080", size = 4.5, shape = 18) + #teal diamond
  geom_point(aes(x=lon, y=lat), data = pub, color = "white", size = 1.8, shape = 18) + #white diamond
  geom_text(aes(x=lon, y=lat, label = "The Barrel at Bude"), data = pub, size = 3.5,
            vjust = -1, hjust = -.04, colour = "#DC143C", fontface = "bold", family = "verdana", alpha=.7 ) +
  
  #cricket place
  geom_point(aes(x=lon, y=lat), data=cricket, color = "orange", size = 4.5, shape=15) + #orange square
  geom_point(aes(x=lon, y=lat), data=cricket, color = "white", size = 1.8, shape=15) + #white square
  geom_text(aes(x = lon, y = lat, label = "Bude North Cornwall Cricket Club"), data = cricket, size = 3.5,
            vjust = .5, hjust = 1.05, colour = "#DC143C", fontface = "bold", family = "verdana", alpha=.7 ) +
  
  #Route from Cricket to Pub
  geom_path(
    aes(x = lon, y = lat),  colour = "green", size = 1.5,
    data = crickettopub, lineend = "round"
  )
watercolor
dev.copy(png,'watercolor.png')
dev.off()
roadmap
dev.copy(png,'roadmap.png')
dev.off()

#make all images same size
size = geometry_size_pixels(width = 720, height = 1440)
image_write(image_scale(image_read("bude.jpg"), size), "bude.jpg", format="jpg")
image_write(image_scale(image_read("mouth.jpg"), size), "mouth.jpg", format="jpg")
image_write(image_scale(image_read("pub.jpg"), size), "pub.jpg", format="jpg")
image_write(image_scale(image_read("cricket.jpg"), size), "cricket.jpg", format="jpg")
image_write(image_scale(image_read("widemouth.jpg"), size), "widemouth.jpg", format="jpg")



