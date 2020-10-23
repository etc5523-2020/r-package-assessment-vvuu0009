test_that("selectInput01", {
  
  x <- c("continent")
  y <- corona_cont$continent
  expect_equal(
    selectInput01(x,y),
    selectInput("continent","select the continent", choices = corona_cont$continent)
  )
  
  x <- c("type")
  y <- corona_cont$type
  expect_equal(
    selectInput01(x,y),
    selectInput("type","select the type", choices = corona_cont$type)
  )
})
