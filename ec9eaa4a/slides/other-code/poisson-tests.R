library(testthat)

y <- c(2,4,0,1)

test_that("log likelihood runs", {
  y <- c(2,4,0,1)
  expect_true(is.finite(llike(1)))
  expect_error(llike(0))
  expect_error(llike(-3))
})

y <- -1
test_that("log likehood bombs on bad data", {
  expect_equal(llike(3), -Inf)
})

