#' ZENIT-POLAR substitution cipher method of encryption
#'
#' Returns a message encrypted by ZENIT-POLAR substitution cipher method of encryption using by default TENIS-POLAR key.
#'
#' @details This kind of encryption replace the nth character of 1th key to the nth character of 2nd key and vice versa.
#'
#' @return encrypted message
#'
#' @name bot_server
#'
#' @param token_path second one-way cipher
#'
#' @importFrom lubridate today
#' @importFrom rtweet post_tweet
#' @export
bot_server <- function(settings_path){

  token <- readRDS(token_path)

  hoje <- lubridate::today()

  page_url <- get_page(lubridate::year(hoje))

  holidays <- get_holidays(page_url)

  which_holiday <- hoje_tem(holidays[['data']], hoje)

  msg <- msg_to_post(holidays, which_holiday)

  rtweet::post_tweet(msg, token = token)
}

#' @export
get_page <- function(year){

    paste0("https://www.anbima.com.br/feriados/fer_nacionais/", year, ".asp")

}

#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr mutate
#' @importFrom magrittr "%>%"
#' @export
get_holidays <- function(page_url){

  xml2::read_html(page_url) %>%
    rvest::html_nodes("table.interna") %>%
    rvest::html_table(header = TRUE) %>%
    .[[1]] %>%
    janitor::clean_names() %>%
    dplyr::mutate(data = as.Date(format(as.Date(data), "%d-%m-%y"), "%y-%m-%d"))

}

#' @export
hoje_tem <- function(feriados, hoje){

  Sys.setlocale("LC_TIME", "C")

  which(feriados == hoje)
}

#' @export
msg_to_post <- function(holidays, which_holiday){

  if (length(which_holiday) == 0) {

    msg <- "Hoje NÃO é um feriado nacional :("

  } else {

    msg <- paste0("Hoje é feriado!!! ", holidays[["feriado"]][which_holiday])

  }

  return(msg)
}



