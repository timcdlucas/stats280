# 



library(tidyverse)

# One model

## Model selection performed differently
## Parameter selection performed differently.

## Compare y ~ X1 + 1, y ~ 1, y ~ 0


ggplot(mtcars, aes(disp, mpg)) + geom_point()


## Fit by maximum likelihood
## Compare with frequentist aov

f1 = lm(mpg ~ disp + 1, mtcars)
f2 = lm(mpg ~ 1, mtcars)

anova(f1, f2)


## Fit by bayes
## Compare by bayes

b1 = brms::brm(mpg ~ disp, mtcars)
b2 = brms::brm(mpg ~ 1, mtcars)

bayes_factor(b1, b2)
bayes_factor(b2, b3)


## Fit by absolute error
## Compare by crossvalidation.


e1 <- function(b, d) sum(abs(b[1] + b[2]*d[, 1] - d[, 2]))
e2 <- function(b, d) sum(abs(b - d[, 2]))

est1 <- function(d) optim(c(0, 1), e1, d = d)$par
est2 <- function(d) optim(0, e2, d = d)$par

eval1 <- function(test, train){
  b <- est1(train)
  sum(abs(b[1] + b[2]*test[, 2] - test[ ,1]))
}

eval2 <- function(test, train){
  b <- est2(train)
  sum(abs(b - test[ ,1]))
}

error2 <- 
  mtcars[, c(3, 1)] %>% 
  modelr::crossv_kfold(5) %>% 
  mutate(train = map(train, as.data.frame),
         test = map(test, as.data.frame)) %>% 
  mutate(error1 = map2_dbl(.$train, .$test, ~ eval1(.x, .y)),
         error2 = map2_dbl(.$train, .$test, ~ eval2(.x, .y))) %>% 
  summarise(mean_error_1 = mean(error1),
            mean_error_2 = mean(error2))





eval <- function(d1, d2){
  d1 <- as.data.frame(d1)
  b <- optim(4:3, function(b, d) sum(abs(b[1] + b[2]*d[, 1] - d[, 2])), d = d1)$par
  sum(abs(b[1] + b[2]*as.data.frame(d2)[, 2] - d1[ ,1]))
}

error <- 
  mtcars[, c(3, 1)] %>% 
  modelr::crossv_kfold(5) %>% 
  mutate(err = map2_dbl(.$train, .$test, ~ eval(.x, .y))) %>% 
  summarise(mean = mean(err))



f=function(d,t){
  t=as.data.frame(t)
  b=optim(4:3,function(b,d)sum(abs(b[1]+b[2]*d[,1]-d[,2])),d=as.data.frame(d))$par
  sum(abs(b[1]+b[2]*t[,2]-t[,1]))
}

crossv_kfold(mtcars[,c(3,1)])%>%
  mutate(e=map2_dbl(.$train,.$test,f))%>%
  summarise(m=mean(e))



crossv_kfold(mtcars[,c(3,1)])%>%
  mutate(e=map2_dbl(.$train,.$test,~{
    t=as.data.frame(.y)
    b=optim(4:3,function(b,d)sum(abs(b[1]+b[2]*d[,1]-d[,2])),d=as.data.frame(.x))$par
    sum(abs(b[1]+b[2]*t[,2]-t[,1]))
  }))%>%
  summarise(m=mean(e))


crossv_kfold(mtcars[,c(3,1)])%>%
  summarise(e=map2_dbl(.$train,.$test,~{
    t=as.data.frame(.y)
    b=optim(4:3,function(b,d)sum(abs(b[1]+b[2]*d[,1]-d[,2])),d=as.data.frame(.x))$par
    sum(abs(b[1]+b[2]*t[,2]-t[,1]))
  }) %>% mean)

