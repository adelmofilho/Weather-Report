test_that("get_page works", {
  test_url <- "https://www.anbima.com.br/feriados/fer_nacionais/2020.asp"
  expect_equal(get_page(2020), test_url)
})
