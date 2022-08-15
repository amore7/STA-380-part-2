#Read data
data=read.csv(file ="greenbuildings.csv")
library(mosaic)
library(tidyverse)

#make variables into factors
data$green_rating = as.factor(data$green_rating)
data$LEED = as.factor(data$LEED)
data$Energystar = as.factor(data$Energystar)
data$amenities = as.factor(data$amenities)
data$renovated = as.factor(data$renovated)
data$class_a = as.factor(data$class_a)
data$class_b = as.factor(data$class_b)
data$net = as.factor(data$net)

# Exploratory Data Analysis
#Looking at rent prices for green ratings
ggplot(data, aes(green_rating, Rent)) + geom_boxplot()
data %>% filter(leasing_rate>=10)%>% group_by(green_rating) %>% 
  summarise(med_rent = median(Rent), count = n())

# Rent vs. Occupancy Rates
ggplot(data, aes(leasing_rate, Rent, color = green_rating)) + geom_point()
data %>% group_by(green_rating) %>% summarise(med_occupancy = median(leasing_rate), count = n())

# Age vs. Occupancy Rates
ggplot(data, aes(age, leasing_rate, color = green_rating)) + geom_point()

#POSSIBLE UNEXPECTED FACTORS AFFECTING RENT DIFFERENCE

#Explanations for each step included in write-up, not included here to avoid
#unnecessary redundancy

# 1. Number of stories
ggplot(data, aes(stories, Rent, color = green_rating)) + geom_point()
data %>% group_by(green_rating) %>% summarise(med_stories = median(stories))

# 2. Amenities
data %>% group_by(green_rating, amenities) %>% summarise(med_rent = median(Rent), count = n())

# 3. Age
data %>% group_by(green_rating) %>% summarise(med_age = median(age), count = n())
ggplot(data, aes(age, Rent, color = green_rating)) + geom_point()

# 4. Space
ggplot(data, aes(size, Rent, color = green_rating)) + geom_point()
data %>% group_by(green_rating)%>% summarize(med_size = median(size), mean_size = mean(size))

# 5. Clustering (Building location)
ggplot(data, aes(cluster, Rent, color = green_rating)) + geom_point()
#decided cluster grouping below (300 to 600), based off trial and error to maximize 
#difference in median rent price
data %>% filter(cluster>=300 & cluster<=600) %>% group_by(green_rating) %>%summarise(med = median(Rent), count = n())
