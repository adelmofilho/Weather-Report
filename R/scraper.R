#' Twitter bot server main function
#'
#' Posts a tweet based on ANBIMA holiday database
#'
#' @details Given twitter bot token it tweets a message concerns holidays
#'
#' @return encrypted message
#'
#' @name bot_server
#'
#' @param settings_path second one-way cipher
#'
#' @importFrom lubridate today
#' @importFrom rtweet post_tweet
#' @export
bot_server <- function(settings_path) {

  Sys.setlocale("LC_TIME", "C")

  settings <- jsonlite::read_json(settings_path)

  token <- readRDS(settings$token_path)

  hoje <- lubridate::today()

  page_url <- get_page(lubridate::year(hoje))

  holidays <- get_holidays(page_url)

  which_holiday <- hoje_tem(holidays[["dia"]], hoje)

  msg <- msg_to_post(holidays, which_holiday, hoje)

  rtweet::post_tweet(msg, token = token)
}

get_page <- function(year) {

    paste0("https://www.anbima.com.br/feriados/fer_nacionais/", year, ".asp")

}

#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr mutate
#' @importFrom magrittr "%>%"
#' @import rlang
get_holidays <- function(page_url) {

  xml2::read_html(page_url) %>%
    rvest::html_nodes("table.interna") %>%
    rvest::html_table(header = TRUE) %>%
    as.data.frame() %>%
    janitor::clean_names() %>%
    dplyr::mutate(dia = as.Date(x = format(as.Date(.data$data), "%d-%m-%y"),
                                format = "%y-%m-%d"))

}

hoje_tem <- function(feriados, hoje) {

  which(feriados == hoje)
}

msg_to_post <- function(holidays, which_holiday, hoje) {

  if (length(which_holiday) == 0) {

    msg <- paste0("Hoje, ",
                  format(hoje, "%d/%m/%Y"),
                  ", N\u00c3O \u00e9 um feriado nacional.")

  } else {

    msg <- paste0("Hoje, ",
                  format(hoje, "%d/%m/%Y"),
                  ", \u00e9 feriado!!! ",
                  holidays[["feriado"]][which_holiday])

  }

  return(msg)
}
