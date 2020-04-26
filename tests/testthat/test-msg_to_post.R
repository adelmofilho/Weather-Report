test_that("msg_to_post works", {

    hoje_normal <- as.Date("2020-03-19")
    hoje_feriado <- as.Date("2020-05-01")
    holidays <- get_holidays("sample_html_page.html")

    msg_test_normal <- "Hoje, 19/03/2020, NÃO é um feriado nacional."
    which_holiday_normal <- hoje_tem(holidays[["dia"]], hoje_normal)
    msg_normal <- msg_to_post(holidays, which_holiday_normal, hoje_normal)

    expect_equal(msg_normal, msg_test_normal)

    msg_test <- "Hoje, 01/05/2020, é feriado!!! Dia do Trabalho"
    which_holiday <- hoje_tem(holidays[["dia"]], hoje_feriado)
    msg <- msg_to_post(holidays, which_holiday, hoje_feriado)

    expect_equal(msg, msg_test)
})
