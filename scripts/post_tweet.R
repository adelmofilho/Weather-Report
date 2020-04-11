library(rtweet)
library(jsonlite)

tokens <- jsonlite::read_json("artifacts/keys_tokens.json")

twitter_token <- rtweet::create_token(app = "Holiday-bot",
                                      access_token = tokens$access_token,
                                      access_secret = tokens$access_token_secret,
                                      consumer_key = tokens$API_key,
                                      consumer_secret = tokens$API_secret_key,
                                      set_renv = FALSE)

saveRDS(object = twitter_token,
        file = "artifacts/rtweet_token.rds")


