test_that("hoje_tem works", {

    dia <- "2020-03-19"
    feriados <- get_holidays("sample_html_page.html")[["dia"]]

    expect_length(hoje_tem(feriados, dia),0)
})
