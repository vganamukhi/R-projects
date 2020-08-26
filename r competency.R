

MyData <- read.csv(file="C:/Users/veena/Documents/R/DCbikes.csv", header=TRUE, sep=",")

MyData

dim(MyData)

#Question 1
summary(MyData)
str(MyData)


library(dplyr)
library(ggplot2)
library(forecast)
library(TSstudio)
library(plotly)
library(lubridate)

#question 2
bike_data <- read.csv(file.choose())


attach(bike_data)
View(bike_data)
bike_data_ts <- ts(Total.bikes.hour, 
                   frequency = 24*365,
                   start = c(2016))
print(bike_data_ts)
View(bike_data_ts)


plot.ts(bike_data_ts)

#question 3




ggplot(bike_data, aes(x=temp, y=Total.bikes.hour), na.rm = TRUE)+geom_line()


bike_data_decompose <- decompose(bike_data_ts, type = 'additive')
str(bike_data_decompose)
bike_data_decompose %>% 
  forecast::autoplot()+ xlab("Year")+
  ggtitle("bike_data_decompose")


plot(temp,Total.bikes.hour, type="l", col="green", lwd=5, xlab="time", ylab="concentration", main="Exponential decay")


#question 4

x <- bike_data %>%
  group_by(weather_main) %>%
  summarize(mean(Total.bikes.hour,na.rm = TRUE))

view(x)
sort(x$`mean(Total.bikes.hour, na.rm = TRUE)`)

#Question 5


bike_data %>% ggplot(aes(x=humidity,))+geom_bar()

#Question 6


Q1 <- filter(bike_data, Month == 6 | Month == 7 | Month == 8 )
View(Q1)

Q1_ts <- ts(Q1$Total.bikes.hour, 
                   frequency = 24*92,
                   start = c(2016))

plot(Q1_ts)

plot(Q1$Day, Q1$Total.bikes.hour, xlab="day", ylab="Total_bike_usage")

ggplot(Q1, aes(x=Q1$Day, y=Q1$Total.bikes.hour))+geom_line(stat = "identity")

#Question 7

bike_data <- bike_data%>% mutate(VeryLow = ifelse(Total.bikes.hour >= 0 & Total.bikes.hour <450, 'TRUE', 'FALSE'))
bike_data <- bike_data%>% mutate(Low = ifelse(Total.bikes.hour >= 450 & Total.bikes.hour <900, 'TRUE', 'FALSE'))
bike_data <- bike_data%>% mutate(Medium = ifelse(Total.bikes.hour >= 900 & Total.bikes.hour <1350, 'TRUE', 'FALSE'))
bike_data <- bike_data%>% mutate(High = ifelse(Total.bikes.hour >= 1350 & Total.bikes.hour <1800, "TRUE", "FALSE"))
bike_data <- bike_data%>% mutate(VeryHigh=ifelse(Total.bikes.hour >= 1800,'TRUE','FALSE'))


View(bike_data)

#Question 8
bike_data_very_high <- filter(bike_data, VeryHigh == "TRUE")
select(bike_data_very_high, datetime)

#Question 9
x<-make_datetime( bike_data$Year, bike_data$Month , bike_data$Day, bike_data$Hour )
x
bike_data$NewDate <- x
View(bike_data)


