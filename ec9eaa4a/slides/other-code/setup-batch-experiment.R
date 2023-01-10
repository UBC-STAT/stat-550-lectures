library(batchtools)
library(glmnet)

reg <- makeExperimentRegistry("lasso-tp", packages = "glmnet")

# functions ---------------------------------------------------------------

generatelm <- function(n = 100, p = 25, s = 2, rho = 0, SNR = 1) {
  bstar <- rep(1, s)
  S <- matrix(rho, p, p)
  diag(S) <- 1
  X <- mvtnorm::rmvnorm(n, sigma = S)
  mu <- drop(X[,1:s] %*% bstar)
  sig2 <- sum(mu^2) / SNR
  ytrain <- mu + rnorm(n, sd = sqrt(sig2))
  ytest <- mu + rnorm(n, sd = sqrt(sig2))
  list(X = X, ytrain = ytrain, ytest = ytest, 
       nonzeros = 1:s, zeros = (s+1):p,
       sig2 = sig2)
}

fit_glmnet <- function(dat) {
  x <- dat$X
  y <- dat$ytrain
  n <- length(dat$y)
  fit <- cv.glmnet(x, y)
  mse <- colMeans((y - predict.(fit$glmnet.fit, newx = x))^2)
  aic <- fit$lambda[which.min(log(mse) + 2 * fit$glmnet.fit$df / n)]
  bic <- fit$lambda[which.min(log(mse) + 2 * fit$glmnet.fit$df / n * log(n))]
  lams <- c(lambda.min = fit$lambda.min, lambda.1se = fit$lambda.1se,
            aic = aic, bic = bic)
  nonzeros <- predict(fit, s = lams, type = "nonzero")
  yhats <- predict(fit, newx = x, s = lams)
  tp <- sapply(nonzeros, function(x) sum(x %in% dat$nonzeros))
  tn <- sapply(nonzeros, function(x) sum(setdiff(dat$zeros, x)))
  data.frame(mse = colMeans((dat$ytest - yhats)^2) / dat$sig2,
             sensitivity = tp / sum(dat$nonzeros),
             specificity = tn / sum(dat$zeros),
             method = names(lams))
}

# parameters --------------------------------------------------------------
addProblem("fake_data", fun = function(data, job, ...) generatelm(...))
prob_design <- list(fake_data = CJ(
  n = 100, 
  p = c(25, 50, 100, 1000),
  rho = c(0, .2, .8), 
  SNR = c(.1, 1, 10),
  s = c(2, 10, 20)
))

addAlgorithm("glmnet_tuning", fun = function(data, job, instance, ...) fit_glmnet(instance))
algo_design <- list(glmnet_tuning = data.frame)

# compile and run ---------------------------------------------------------
addExperiments(prob_design, algo_design, repls = 25L)
ids <- findJobs() # 3600 jobs, too many to submit at once
ids[, chunk := chunk(job.id, n.chunks = 10)] # put into 10 chunks (randomly)
