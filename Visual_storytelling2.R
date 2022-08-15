#Reading Data
data=read.csv(file ="capmetro_UT.csv")
library(mosaic)
library(tidyverse)
library(dplyr)
library(patchwork)

#Making Adjustments for clarity of plots
data$weekend = ifelse(data$weekend == 'weekend', 'Yes', 'No')
data$timestamp1 <- as.POSIXct(paste(data$timestamp), format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

#class(data)
#head(data)
#str(data)

#Binning temperature ranges for clarity in plots
numbers_of_bins = 10
data<-data%>%mutate(Temperature_Range = cut(temperature, 
                                     breaks = unique(quantile(temperature,probs=seq.int(0,1, by=1/numbers_of_bins))), 
                                     include.lowest=TRUE))

#make variables into factors
data$timestamp = as.factor(data$timestamp)
data$boarding = as.factor(data$boarding)
data$alighting = as.factor(data$alighting)
data$day_of_week = as.factor(data$day_of_week)
data$temperature = as.factor(data$temperature)
data$hour_of_day = as.factor(data$hour_of_day)
data$month = as.factor(data$month)
data$weekend = as.factor(data$weekend)

#-------------------------FIRST SET OF SCATTER PLOTS----------------------------------
p1 = ggplot(data, aes(timestamp1, boarding, color = weekend)) + geom_point() + 
  theme(axis.text.y=element_blank()) + 
  ggtitle("Boarding vs timestamp") + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_datetime(date_breaks = "1 week", date_labels = "%D") +
  xlab("Date") + ylab('Number of people Boarding')
p2 = ggplot(data, aes(timestamp1, alighting, color = weekend)) + geom_point() + 
  theme(axis.text.y=element_blank()) + 
  ggtitle("Alighting vs timestamp") + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_datetime(date_breaks = "1 week", date_labels = "%D") +
  xlab("Date") + ylab('Number of people Boarding')

p1.1 = ggplot(data[data$month %in% "Nov", ], aes(timestamp1, boarding, color = weekend)) + geom_point() + 
  theme(axis.text.y=element_blank()) + 
  ggtitle("Boarding vs timestamp for the month of November") + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_datetime(date_breaks = "1 week", date_labels = "%D") +
  xlab("Date") + ylab('Number of people Boarding')

p2.1 = ggplot(data[data$month %in% "Nov", ], aes(timestamp1, alighting, color = weekend)) + geom_point() + 
  theme(axis.text.y=element_blank()) + 
  ggtitle("Alighting vs timestamp for the month of November") + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_datetime(date_breaks = "1 week", date_labels = "%D") +
  xlab("Date") + ylab('Number of people Alighting')

#-------------------------SECOND SET OF SCATTER PLOTS----------------------------------

p3 = ggplot(data[data$month %in% "Sep", ], aes(alighting,temperature, color = Temperature_Range)) + 
  geom_point() + theme(axis.text.x=element_blank(),axis.text.y=element_blank()) + 
  ggtitle("Alighting vs Temperature for September") + theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Number of People Alighting") + ylab('Temperature')
p4 = ggplot(data[data$month %in% "Oct", ], aes(alighting,temperature, color = Temperature_Range)) + 
  geom_point() + theme(axis.text.x=element_blank(),axis.text.y=element_blank())+ 
  ggtitle("Alighting vs Temperature for October") + theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Number of People Alighting") + ylab('Temperature')
p5 = ggplot(data[data$month %in% "Nov", ], aes(alighting,temperature, color = Temperature_Range)) + 
  geom_point() + theme(axis.text.x=element_blank(),axis.text.y=element_blank())+ 
  ggtitle("Alighting vs Temperature for November") + theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Number of People Alighting") + ylab('Temperature') 

#-------------------------THIRD SET OF SCATTER PLOTS----------------------------------

p6 = ggplot(data[data$month %in% "Sep", ], aes(boarding,temperature, color = Temperature_Range)) + 
  geom_point() + theme(axis.text.x=element_blank(),axis.text.y=element_blank()) + 
  ggtitle("Boarding vs Temperature for September") + theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Number of People Boarding") + ylab('Temperature')
p7 = ggplot(data[data$month %in% "Oct", ], aes(boarding,temperature, color = Temperature_Range)) + 
  geom_point() + theme(axis.text.x=element_blank(),axis.text.y=element_blank()) + 
  ggtitle("Boarding vs Temperature for October") + theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Number of People Boarding") + ylab('Temperature')
p8 = ggplot(data[data$month %in% "Nov", ], aes(boarding,temperature, color = Temperature_Range)) + 
  geom_point() + theme(axis.text.x=element_blank(),axis.text.y=element_blank()) + 
  ggtitle("Boarding vs Temperature for November") + theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Number of People Boarding") + ylab('Temperature')

#Printing first round of plots
p1 + p2 + plot_layout(nrow = 2)
p1.1 + p2.1 + plot_layout(nrow = 2)

#Printing second round of plots
p3
p4
p5

#Printing third round of plots
p6
p7
p8

#-------------------------BAR PLOTS----------------------------------

#getting sums
data1 = data %>% group_by(Temperature_Range) %>% summarize(sum(as.numeric(boarding)))
data1 = rename(data1, 'sums' = 'sum(as.numeric(boarding))')

#plotting sums
p9 = ggplot(data1, aes(Temperature_Range, sums))+ geom_col(aes(fill  = Temperature_Range),show.legend = FALSE)+ 
  ggtitle("Boarding Counts for Temperature Range bins, for entire dataset") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Temperature Range (F)") + ylab('Number of people Boarding')

#getting sums
data2 = data  %>% group_by(Temperature_Range) %>% summarize(sum(as.numeric(alighting)))
data2 = rename(data2, 'sums' = 'sum(as.numeric(alighting))')

#plotting sums
p10 = ggplot(data2, aes(Temperature_Range, sums))+ geom_col(aes(fill  = Temperature_Range),show.legend = FALSE)+ 
  ggtitle("Alighting Counts for Temperature Range bins, for entire dataset") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Temperature Range (F)") + ylab('Number of people Alighting')
#Printing plots
p9
p10
