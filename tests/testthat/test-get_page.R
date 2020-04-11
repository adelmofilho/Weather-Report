test_that("get_page works", {
  expect_equal(get_page(2020), "https://www.anbima.com.br/feriados/fer_nacionais/2020.asp")
})
