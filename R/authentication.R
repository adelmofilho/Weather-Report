#' Token Generation
#'
#' Creates a twitter bot token given twitter api credentials
#'
#' @details Saves a twitter bot token as rds object
#'
#' @return rds object
#'
#' @name generate_token
#'
#' @param settings_path path and filename of settings file
#'
#' @importFrom jsonlite read_json
#' @importFrom rtweet create_token
#' @export
generate_token <- function(settings_path) {

    settings <- jsonlite::read_json(settings_path)

    tokens <- jsonlite::read_json(settings$json_path)

    twitter_token <- rtweet::create_token(
        app = settings$app_name,
        access_token = tokens$access_token,
        access_secret = tokens$access_token_secret,
        consumer_key = tokens$API_key,
        consumer_secret = tokens$API_secret_key,
        set_renv = FALSE)

    saveRDS(object = twitter_token,
            file = settings$token_path)
}
