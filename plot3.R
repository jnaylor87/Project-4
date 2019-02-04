library(downloader)
library(readr)
library(tidyverse)

# Download Dataset and Unzip
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(url, dest="~/Air_Pollution.zip", mode="wb") 
unzip("Air_Pollution.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 3 ----------------------------------------------------
NEI %>%
  filter(fips=="24510") %>%
  select(year,type,Emissions) %>%
  group_by(year,type) %>%
  summarize(Emissions=sum(Emissions)) -> NEI3

ggplot(data=NEI3,aes(x=year,y=Emissions,group=type))+geom_line(aes(color=type))
dev.copy(png,'plot3.png',width=480,height=480)
dev.off()  