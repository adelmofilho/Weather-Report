#' ZENIT-POLAR substitution cipher method of encryption
#'
#' Returns a message encrypted by ZENIT-POLAR substitution cipher method of encryption using by default TENIS-POLAR key.
#'
#' @details This kind of encryption replace the nth character of 1th key to the nth character of 2nd key and vice versa.
#'
#' @return encrypted message
#'
#' @name generate_token
#'
#' @param settings_path message to encrypt
#'
#' @importFrom jsonlite read_json
#' @importFrom rtweet create_token
#' @export
generate_token <- function(settings_path){

    settings <- jsonlite::read_json(settings_path)

    tokens <- jsonlite::read_json(settings$json_path)

    twitter_token <- rtweet::create_token(app = settings$app_name,
                                          access_token = tokens$access_token,
                                          access_secret = tokens$access_token_secret,
                                          consumer_key = tokens$API_key,
                                          consumer_secret = tokens$API_secret_key,
                                          set_renv = FALSE)

    saveRDS(object = twitter_token,
            file = settings$token_path)
}
