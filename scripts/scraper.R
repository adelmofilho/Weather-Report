


get_page <- function(year){

    paste0("https://www.anbima.com.br/feriados/fer_nacionais/", year, ".asp")

}

get_holidays <- function(page_url){

  xml2::read_html(page_url) %>%
    rvest::html_nodes("table.interna") %>%
    rvest::html_table(header = TRUE) %>%
    .[[1]] %>%
    janitor::clean_names() %>%
    dplyr::mutate(data = as.Date(format(as.Date(data), "%d-%m-%y"), "%y-%m-%d")) %>%
    dplyr::as_tibble()

}

hoje_tem <- function(feriados, hoje){

  Sys.setlocale("LC_TIME", "C")

  which(feriados == hoje)
}

msg_to_post <- function(holidays, which_holiday){

  if (length(which_holiday) == 0) {

    msg <- "Hoje NÃO é um feriado nacional :("

  } else {

    msg <- paste0("Hoje é feriado!!! ", holidays[["feriado"]][which_holiday])

  }

  return(msg)
}

bot_server <- function(token_path){

  token <- readRDS(token_path)

  hoje <- lubridate::today()

  page_url <- get_page(lubridate::year(hoje))

  holidays <- get_holidays(page_url)

  which_holiday <- hoje_tem(holidays[['data']], hoje)

  msg <- msg_to_post(holidays, which_holiday)

  rtweet::post_tweet(msg, token = token)
}


