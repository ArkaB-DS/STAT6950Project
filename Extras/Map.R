rm(list=ls())


library(readxl)
library(tidyverse)
library(xlsx)
library(rvest)
library(magrittr)
library(ggmap)


#setwd("D:/OSU Course Materials/6950 - Applied Statistics 2/Project")

Data=read.xlsx("database.xlsx",sheetIndex = 1)

Data$name=Data$Country


world <- ne_countries(scale = "medium", returnclass = "sf")

world[which(world$name=="United States"),]$name="United States of America"

DD=world %>% left_join(Data)

#DD= DD %>% filter(name!="Antarctica")

a=ggplot(data = DD,aes(fill=NFCR2019)) +
  geom_sf()+theme_bw()

pdf("Map_deforest.pdf")
a+scale_fill_gradient(low="red", high="yellow")+
  coord_sf(crs = "+proj=laea +lat_0=0 +lon_0=0 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs ")
dev.off()







