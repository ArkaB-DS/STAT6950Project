library(readxl)
library(tidyverse)
library(xlsx)



Data=read.xlsx("database.xlsx",sheetIndex = 1)



## AML2019

AML2019_missing_list=Data[is.na(Data$AML2019),]$Country


Capital_long_lat=read.csv("Capital_long_lat.csv")


Capital_long_lat$CapitalLatitude=as.numeric(Capital_long_lat$CapitalLatitude)


imputed_AML_2019_means=NULL


for(i in 1:length(AML2019_missing_list)){
  
  Base=Capital_long_lat %>% filter(CountryName==AML2019_missing_list[i])
  
  Other=Capital_long_lat %>% filter(CountryName!=AML2019_missing_list[i])
  
  
  Distances=sqrt((Other$CapitalLatitude-Base$CapitalLatitude)^2+
                   (Other$CapitalLongitude-Base$CapitalLongitude)^2)
  
  D=data.frame(CountryName=Other$CountryName,Distances) %>% arrange(Distances)
  
  DD=Data[Data$Country %in% 
            D$CountryName[1:41],] %>% 
    select(AML2019) %>% 
    na.omit() %>%
    head(5)
  
  
  imputed_AML_2019_means[i]=mean(DD$AML2019)
  
  print(paste("Done for country",AML2019_missing_list[i]))
  
}







