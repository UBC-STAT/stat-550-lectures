valid_par <- function(x) stopifnot(x > 0, is.finite(x))

llike <- function(x) {
  valid_par(x)
  mean(dpois(y, x, TRUE))
}

dllike <- function(x) {
  valid_par(x)
  mean(y) / x - 1
}

grad_ascent <- function(fn, gn, x0 = 1, gam = 1, maxit = 100, tol = 1e-6) {
  f0 = fn(x0)
  for (i in 1:maxit) {
    x = x0 + gam * gn(x0)
    f = fn(x0)
    if (abs(f - f0) < tol) break
    f0 = f
    x0 = x
  }
  if (i == maxit) warning("Did too many iterations. Try a different gamma.")
  x
}

y <- rpois(100, 3)
grad_ascent(llike, dllike)
