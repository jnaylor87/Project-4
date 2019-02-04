library(downloader)
library(readr)
library(tidyverse)

# Download Dataset and Unzip
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(url, dest="~/Air_Pollution.zip", mode="wb") 
unzip("Air_Pollution.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 6 -----------------------------------------------------  

NEI %>%
  merge(x=NEI,y=SCC,by.x="SCC",by.y="SCC",all.x=TRUE) %>%
  filter(grepl("*Vehicles*",SCC.Level.Two),fips %in% c("24510","06037")) %>%
  select(year,Emissions,fips) %>%
  group_by(year,fips) %>%
  summarize(Emissions=sum(Emissions)) -> NEI6

ggplot(data=NEI6,aes(x=year,y=Emissions,group=fips))+geom_line(aes(color=fips))
dev.copy(png,'plot6.png',width=480,height=480)
dev.off() 