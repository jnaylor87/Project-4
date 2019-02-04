library(downloader)
library(readr)
library(tidyverse)

# Download Dataset and Unzip
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(url, dest="~/Air_Pollution.zip", mode="wb") 
unzip("Air_Pollution.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 1 ----------------------------------------------------
NEI %>%
  select(year,Emissions) %>%
  group_by(year) %>%
  summarize(Emissions=sum(Emissions)) -> NEI1

plot(NEI2$year,NEI1$Emissions,type="l")
dev.copy(png,'plot1.png',width=480,height=480)
dev.off()  

#Plot 2 ----------------------------------------------------
NEI %>%
  filter(fips=="24510") %>%
  select(year,Emissions) %>%
  group_by(year) %>%
  summarize(Emissions=sum(Emissions)) -> NEI2

plot(NEI2$year,NEI2$Emissions,type="l")
dev.copy(png,'plot2.png',width=480,height=480)
dev.off() 

#Plot 3 ----------------------------------------------------
NEI %>%
  filter(fips=="24510") %>%
  select(year,type,Emissions) %>%
  group_by(year,type) %>%
  summarize(Emissions=sum(Emissions)) -> NEI3

ggplot(data=NEI3,aes(x=year,y=Emissions,group=type))+geom_line(aes(color=type))
dev.copy(png,'plot3.png',width=480,height=480)
dev.off()  

#Plot 4 -----------------------------------------------------
NEI %>%
  merge(x=NEI,y=SCC,by.x="SCC",by.y="SCC",all.x=TRUE) %>%
  filter(grepl("*Coal*",SCC.Level.Three)) %>%
  select(year,Emissions) %>%
  group_by(year) %>%
  summarize(Emissions=sum(Emissions)) -> NEI4

ggplot(data=NEI4,aes(x=year,y=Emissions))+geom_line()
dev.copy(png,'plot4.png',width=480,height=480)
dev.off() 

#Plot 5 -----------------------------------------------------
NEI %>%
  merge(x=NEI,y=SCC,by.x="SCC",by.y="SCC",all.x=TRUE) %>%
  filter(grepl("*Vehicles*",SCC.Level.Two),fips=="24510") %>%
  select(year,Emissions) %>%
  group_by(year) %>%
  summarize(Emissions=sum(Emissions)) -> NEI5
  
ggplot(data=NEI5,aes(x=year,y=Emissions))+geom_line()  
dev.copy(png,'plot5.png',width=480,height=480)
dev.off() 
  
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

