# Stats for twitter

## 
tags twitterstats 280stats biostats?



## Overarching ideas

Exploratory, confirmatory, predictive.

Model, inference, implementation.

Inference agnostic. Frequentism, bayes, ML.

Simulate to understand, simulate to check.
* Is this inference shit
* How does frequentism work
* How does probability work/look like.
* What is the data generating mechanism that the model assumes?

Intuition of underlying theory, but not bogged down in maths.
* Few/no implementation details.
* Few equations.
* But never named tests without context.









## Exploratory, confirmatory, predictive.

### Explore

mtcars %>%
  gather("var", "value", -mpg) %>% 
  ggplot(aes(x = value, y = mpg)) +
    geom_point() +
    geom_smooth() + 
    facet_wrap(~ var, scales = "free") 

mtcars %>% gather("var", "value", -mpg) %>% ggplot(aes(x = value, y = mpg)) + geom_point() + geom_smooth() + facet_wrap(~ var, scales = "free") 

mtcars %>%
  gather("var", "value", -mpg) %>% 
  group_by(var) %>% 
  summarise(p = cor(value, mpg, method = 'pear')) %>% 
  arrange(abs(p))
  
### confirmatory 

lm...

### predictive

randomForest::randomForest(mpg ~ ., mtcars, nodesize = 1)

lm <- lm(mpg ~ ., mtcars)
mean(lm$residuals ^ 2)

sv <- e1071::svm(mpg ~ ., mtcars)
mean(sv$residuals ^ 2)

