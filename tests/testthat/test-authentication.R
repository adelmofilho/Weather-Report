test_that("authorization works", {

    generate_token("sample_settings.json")

    latest <- readRDS("rtweet_token.rds")
    test <- readRDS("test_rtweet_token.rds")

    expect_true(all.equal(latest, test))

    file.remove("rtweet_token.rds")

})
