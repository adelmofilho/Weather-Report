test_that("multiplication works", {
    test <- get_holidays("sample_html_page.html")
    base <- get_holidays(get_page(2020))
    expect_true(all.equal(test, base))
})
