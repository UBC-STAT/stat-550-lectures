valid_par <- function(lam) {
  stopifnot(is.numeric(lam), length(lam) == 1)
  stopifnot(lam > 0, is.finite(lam))
}

valid_data <- function(y) {
  stopifnot(is.numeric(y))
  stopifnot(all(y >= 0), all(is.finite(y)))
}

llike <- function(lambda, y) {
  valid_par(lambda)
  valid_data(y)
  
  mean(y) * log(lambda) - lambda
}

dllike <- function(lambda, y) {
  valid_par(lambda)
  valid_data(y)
  
  mean(y) / lambda - 1
}

grad_ascent <- function(y, fn, gn, x0 = 1, gam = 1, maxit = 100, tol = 1e-6) {
  f0 <- fn(x0, y)
  for (i in 1:maxit) {
    x <- x0 + gam * gn(x0, y)
    f <- fn(x, y)
    if (abs(f - f0) < tol) break
    f0 <- f
    x0 <- x
  }
  if (i == maxit) warning("Did too many iterations. Try a different gamma.")
  x
}

yy <- rpois(100, 5)
grad_ascent(yy, llike, dllike)
