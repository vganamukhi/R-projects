#Loading the rvest package
library('rvest')
library('stringr')

#Specifying the url for desired website to be scraped
url <- 'https://www.udemy.com/courses/search/?q=top%2010%20courses&src=sac&kw=top%2010%20c'

#Reading the HTML code from the website
YouTube_video <- read_html(url)
YouTube_video

#scrape title of the product> 
#title_html <- html_nodes(xpath = '//*[@id="container"]/h1/yt-formatted-string')
#title <- html_text(title_html)> head(title)

# Figure out the title for each of the top posts
title <- YouTube_video%>%html_nodes(xpath = '//*[@id="search-result-page-v3"]/div/div/div[2]/div[2]/div[1]/div[2]/div[1]/div/div/a/div/div[2]/div[1]/h4') %>% html_text()                                   
title
str_replace_all(title, "[\r\n]", "")

views <- YouTube_video %>% html_node(xpath = '//*[@id="count"]/yt-view-count-renderer/span[1]') %>% html_text()
views

# Figure out the price for each of the top posts
price <- webpage %>% 
  html_nodes(xpath ='//*[@id="priceblock_ourprice"]') %>% 
  html_text()                                   
price
str_replace_all(price, "[\r\n]", "")

rating <- webpage %>%
  html_node(xpath = '//*[@id="acrPopover"]/span[1]/a/i[1]/span') %>%
  html_text()

rating
str_replace_all(rating, "[\r\n]", "")
str_trim(rating)
rating

#loop through different nodes, get the comments and save it to data frame



typeof(fruits)
