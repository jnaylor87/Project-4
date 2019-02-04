library(downloader)
library(readr)
library(tidyverse)

# Download Dataset and Unzip
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(url, dest="~/Air_Pollution.zip", mode="wb") 
unzip("Air_Pollution.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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
