library(rvest)
library(lubridate)
library(xml2)

Sys.setlocale("LC_TIME", "C")

today <- lubridate::today("UTC")

chave <- format(today, "%B_%d")
hostname <- "https://en.wikipedia.org/wiki/"

url <- paste0(hostname, chave)

page <- xml2::read_html(url)

headers <- page %>%
    html_nodes(".mw-headline") %>%
    html_text()

index_event <- 1 + which(headers == "Events")

events <- page %>%
    html_nodes("ul") %>%
    .[[index_event]] %>%
    html_nodes("li")

n_events <- length(events)

event_index <- sample(1:n_events, 1, replace = FALSE)

event_raw <- page %>%
    html_nodes("ul") %>%
    .[[2]] %>%
    html_nodes("li") %>%
    .[[event_index]]

event_msg <- event_raw %>%
    html_text() %>%
    strsplit(split = " – ") %>% .[[1]] %>% .[-1]

event_year <- event_raw %>%
    html_text() %>%
    strsplit(split = " – ") %>% .[[1]] %>% .[1]

event_link <- event_raw %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    .[[2]] %>%
    strsplit("/wiki/") %>%
    .[[1]] %>%
    .[[2]]

msg <- paste0("Today in history, ",
              event_year,
              ", ",
              event_msg)

link <- paste0(hostname, event_link)

tweet <- paste(msg, link)

rtweet::post_tweet(status = "https://open.spotify.com/track/0dYN5MqKzCfdpDb1bgvdsm",

                   token = token)




link_event <- xml2::read_html(link)
