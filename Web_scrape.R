#Loading the rvest package
library('rvest')
library('stringr')
library(qdap)
library(magrittr)

#Specifying the url for desired website to be scraped
url <- 'https://www.amazon.com/Apple-iPhone-64GB-Silver-Prepaid/dp/B078HVJB69/ref=sr_1_1_sspa?keywords=iphone+x&qid=1571701171&sr=8-1-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEyRFo3M0hSMkJYSVQwJmVuY3J5cHRlZElkPUExMDAzODA2MUtDNlk1Q0JPVVFUUyZlbmNyeXB0ZWRBZElkPUEwOTE0NzI4MU9BS1lGTU9XRTdZQSZ3aWRnZXROYW1lPXNwX2F0ZiZhY3Rpb249Y2xpY2tSZWRpcmVjdCZkb05vdExvZ0NsaWNrPXRydWU='

#Reading the HTML code from the website
webpage <- read_html(url)

#scrape title of the product> 
# Figure out the title for each of the top posts
title <- webpage %>%html_nodes(xpath = '//*[@id="productTitle"]') %>% html_text()                                   
title

#Replace unnecessary lines
str_replace_all(title, "[\r\n]", "")

# Scrape the price of the phone
price <- webpage %>% 
  html_nodes(xpath ='//*[@id="priceblock_ourprice"]') %>% 
  html_text()                                   
price

#Replace unnecessary lines
str_replace_all(price, "[\r\n]", "")

#Scrape the rating for the phone
rating <- webpage %>%
  html_node(xpath = '//*[@id="acrPopover"]/span[1]/a/i[1]/span') %>%
  html_text()
rating


#Replace unnecessary lines
str_replace_all(rating, "[\r\n]", "")
str_trim(rating)
rating

#loop through different nodes, get the comments and save it to data frame

#Reviewer 1
#Scrape the reviews, rating name and review date 
customer_name1 <- webpage %>% html_node(xpath = '//*[@id="customer_review-RBRPZLUVB40S9"]/div[1]/a/div[2]/span') %>%
  html_text()
customer_name1

customer_rate1 <- webpage %>% html_node(xpath = '//*[@id="customer_review-RBRPZLUVB40S9"]/div[2]/a[1]/i/span') %>%
  html_text()
customer_rate1

customer_comment_date1 <- webpage %>% html_node(xpath = '//*[@id="customer_review-RBRPZLUVB40S9"]/span') %>%
  html_text()
customer_comment_date1

customer_comment1 <- webpage %>% html_node(xpath = '//*[@id="customer_review-RBRPZLUVB40S9"]/div[4]/span/div/div[1]/span') %>%
  html_text()
customer_comment1


customer_data <- data.frame(customer_name1, customer_rate1, customer_comment1,customer_comment_date1)

names(customer_data)<-c("Reviewer_name","Rating", "Reviewer_Comment", "Reviewed_Date")
customer_data

#Reviewer 2
#Scrape the reviews, rating name and review date 
customer_name2 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R2XS8CBW7AI3SZ"]/div[1]') %>%
  html_text()
customer_name2

customer_rate2 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R2XS8CBW7AI3SZ"]/div[2]/a[1]/i/span') %>%
  html_text()
customer_rate2

customer_comment_date2 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R2XS8CBW7AI3SZ"]/span') %>%
  html_text()
customer_comment_date2

customer_comment2 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R2XS8CBW7AI3SZ"]/div[4]/span/div/div[1]/span') %>%
  html_text()

customer_comment2 <- str_replace_all(customer_comment2, "[\U0001f44d]", "")
customer_comment2

customer_data2 <- data.frame(customer_name2, customer_rate2, customer_comment2,customer_comment_date2)
names(customer_data2)<-c("Reviewer_name","Rating", "Reviewer_Comment", "Reviewed_Date")

new_customer_data <- rbind(customer_data, customer_data2)
new_customer_data


#Reviewer 3
#Scrape the reviews, rating name and review date 
customer_name3 <- webpage %>% html_node(xpath = '//*[@id="customer_review-RW2WEJVX9G6LF"]/div[1]/a/div[2]/span') %>%
  html_text()
customer_name3

customer_rate3 <- webpage %>% html_node(xpath = '//*[@id="customer_review-RW2WEJVX9G6LF"]/div[2]/a[1]/i/span') %>%
  html_text()
customer_rate3

customer_comment_date3 <- webpage %>% html_node(xpath = '//*[@id="customer_review-RW2WEJVX9G6LF"]/span') %>%
  html_text()
customer_comment_date3

customer_comment3 <- webpage %>% html_node(xpath = '//*[@id="customer_review-RW2WEJVX9G6LF"]/div[4]/span/div/div[1]/span') %>%
  html_text()
customer_comment3

customer_data3 <- data.frame(customer_name3, customer_rate3, customer_comment3,customer_comment_date3)
names(customer_data3)<-c("Reviewer_name","Rating", "Reviewer_Comment", "Reviewed_Date")

new_customer_data <- rbind(new_customer_data, customer_data3)
View(new_customer_data)



#Reviewer 4
#Scrape the reviews, rating name and review date 
customer_name4 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1T9SHSJWAXDY7"]/div[1]') %>%
  html_text()
customer_name4

customer_rate4 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1T9SHSJWAXDY7"]/div[2]/a[1]/i/span') %>%
  html_text()
customer_rate4

customer_comment_date4 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1T9SHSJWAXDY7"]/span') %>%
  html_text()
customer_comment_date4

customer_comment4 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1T9SHSJWAXDY7"]/div[4]/span/div/div[1]/span') %>%
  html_text()
customer_comment4

customer_data4 <- data.frame(customer_name4, customer_rate4, customer_comment4,customer_comment_date4)
names(customer_data4)<-c("Reviewer_name","Rating", "Reviewer_Comment", "Reviewed_Date")

new_customer_data <- rbind(new_customer_data, customer_data4)
View(new_customer_data)


#Reviewer 5
#Scrape the reviews, rating name and review date 
customer_name5 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R10SV32UFYYRFD"]/div[1]/a/div[2]/span') %>%
  html_text()
customer_name5

customer_rate5 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R10SV32UFYYRFD"]/div[2]/a[1]/i/span') %>%
  html_text()
customer_rate5

customer_comment_date5 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R10SV32UFYYRFD"]/span') %>%
  html_text()
customer_comment_date5

customer_comment5 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R10SV32UFYYRFD"]/div[4]/span/div/div[1]/span') %>%
  html_text()
customer_comment5

customer_data5 <- data.frame(customer_name5, customer_rate5, customer_comment5,customer_comment_date5)
names(customer_data5)<-c("Reviewer_name","Rating", "Reviewer_Comment", "Reviewed_Date")

new_customer_data <- rbind(new_customer_data, customer_data5)
View(new_customer_data)


#Reviewer 6
#Scrape the reviews, rating name and review date 
customer_name6 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1M8F05QA6F49N"]/div[1]/a/div[2]/span') %>%
  html_text()
customer_name6

customer_rate6 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1M8F05QA6F49N"]/div[2]/a[1]/i/span') %>%
  html_text()
customer_rate6

customer_comment_date6 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1M8F05QA6F49N"]/span') %>%
  html_text()
customer_comment_date6

customer_comment6 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1M8F05QA6F49N"]/div[4]/span/div/div[1]/span') %>%
  html_text()
customer_comment6

customer_data6 <- data.frame(customer_name6, customer_rate6, customer_comment6,customer_comment_date6)
names(customer_data6)<-c("Reviewer_name","Rating", "Reviewer_Comment", "Reviewed_Date")

new_customer_data <- rbind(new_customer_data, customer_data6)
View(new_customer_data)

#Reviewer 7
#Scrape the reviews, rating name and review date 
customer_name7 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1NIOYOVVJQ1HO"]/div[1]/a/div[2]/span') %>%
  html_text()
customer_name7

customer_rate7 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1NIOYOVVJQ1HO"]/div[2]/a[1]/i/span') %>%
  html_text()
customer_rate7

customer_comment_date7 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1NIOYOVVJQ1HO"]/span') %>%
  html_text()
customer_comment_date7

customer_comment7 <- webpage %>% html_node(xpath = '//*[@id="customer_review-R1NIOYOVVJQ1HO"]/div[4]/span/div/div[1]/span') %>%
  html_text()
customer_comment7

customer_data7 <- data.frame(customer_name7, customer_rate7, customer_comment7,customer_comment_date7)
names(customer_data7)<-c("Reviewer_name","Rating", "Reviewer_Comment", "Reviewed_Date")

new_customer_data <- rbind(new_customer_data, customer_data7)
View(new_customer_data)


#Analyse the reviews using polarity function from qdap library
new_customer_data %$% polarity(Reviewer_Comment)

(datacamp_conversation <- new_customer_data %$% polarity(Reviewer_Comment, Reviewer_name))

datacamp_conversation$all$polarity

c <-counts(datacamp_conversation)
c$pos.words # positive words
c$neg.words #egative words

#plot graph fpr comments's polarity and length of the comments
plot(datacamp_conversation)

new_customer_data$Rate <- as.numeric(gsub("([0-9]+).*$", "\\1", new_customer_data$Rating))
View(new_customer_data)
barplot(new_customer_data$Rate)

library(ggplot2)
#Plot the graphs

p<-ggplot(new_customer_data, aes(x = datacamp_conversation$all$Reviewer_name, y =datacamp_conversation$all$polarity))+geom_bar(stat = "identity")
p + labs(title = "Polarity Plot") + labs(x = "Reviewer") + labs(x = "Polarity")

p<-ggplot(new_customer_data, aes(x = new_customer_data$Reviewer_name, y =new_customer_data$Rate))+geom_bar(stat = "identity")
p + labs(title = "Polarity Plot") + labs(x = "Reviewer") + labs(x = "Polarity")

