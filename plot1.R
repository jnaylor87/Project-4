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