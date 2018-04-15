
e1 <- function(b, d) sum(abs(b[1] + b[2]*d[, 1] - d[, 2]))
e2 <- function(b, d) sum(abs(b - d[, 2]))

est1 <- function(d) optim(c(0, 1), e1, d = d)$par
est2 <- function(d) optim(0, e2, d = d)$par


pars1 <- est1(mtcars[, c(3, 1)])
pars2 <- est2(mtcars[, c(3, 1)])


ggplot(mtcars, aes(disp, mpg)) + 
  geom_point() +
  geom_abline(intercept = pars1[1], slope = pars1[2], col = 'red') +
  geom_abline(intercept=pars2[1], slope = 0, col = 'blue')



est1(mtcars[, c(3, 1)])
est2(mtcars[, c(3, 1)])

eval1 <- function(test, train){
  b <- est1(train)
  sum(abs(b[1] + b[2]*test[, 2] - test[ ,1]))
}

eval2 <- function(test, train){
  b <- est2(train)
  sum(abs(b - test[ ,1]))
}


eval2(mtcars[, c(3, 1)], mtcars[, c(3, 1)])
eval1(mtcars[, c(3, 1)], mtcars[, c(3, 1)])


cv2 <- modelr::crossv_mc(mtcars, 100)
models <- map(cv2$train, ~ lm(mpg ~ wt, data = .))
errs <- map2_dbl(models, cv2$test, modelr::rmse)

modelr::crossv_mc(mtcars, 100) %>% 
  mutate(models = map(.$train, ~ lm(mpg ~ wt, data = .))) %>% 
  mutate(error = map2_dbl(.$models, .$test, modelr::rmse))


error <- 
  mtcars[, c(3, 1)] %>% 
  modelr::crossv_kfold(5) %>% 
  mutate(error1 = map2_dbl(.$train, .$test, ~ eval1(as.data.frame(.x), as.data.frame(.y)))) %>% 
  mutate(error2 = map2_dbl(.$train, .$test, ~ eval2(as.data.frame(.x), as.data.frame(.y)))) %>% 
  summarise(mean_error_1 = mean(error1),
            mean_error_2 = mean(error2))


error2 <- 
  mtcars[, c(3, 1)] %>% 
  modelr::crossv_kfold(5) %>% 
  mutate(train = map(train, as.data.frame),
         test = map(test, as.data.frame)) %>% 
  mutate(error1 = map2_dbl(.$train, .$test, ~ eval1(.x, .y)),
         error2 = map2_dbl(.$train, .$test, ~ eval2(.x, .y))) %>% 
  summarise(mean_error_1 = mean(error1),
            mean_error_2 = mean(error2))