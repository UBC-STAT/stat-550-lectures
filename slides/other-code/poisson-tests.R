library(testthat)
source("other-code/poisson-grad-ascent.R")

y <- c(2, 4, 0, 1) # shared by all tests

test_that("validators work", {
  expect_silent(valid_data(y))
  expect_error(valid_data(c(1, -2, 0)))
  expect_error(valid_data(Inf))
  
  expect_error(valid_par(y))
  expect_silent(valid_par(1))
  expect_error(valid_par(-1))
  expect_error(valid_par(Inf))
})


test_that("log likelihood runs", {
  expect_true(is.finite(llike(1, y)))
  
  # check our math
  lam <- 2 # 1 is usually special
  res <- mean(y) * log(lam) - lam
  expect_equal(llike(lam, y), res)
  expect_equal(
    llike(lam, y), 
    mean(dpois(y, lam, log = TRUE) + lgamma(y + 1))
  )
})


