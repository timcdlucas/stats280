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




## Aims

How do we understand the overarching aims and ideas of statistics.
How can you go about understanding a new statistical method?
Given some data what kinds of things can we ask and how do we fo that?
Given some question how do ask it with statistics?


Embedd the things in overarching ideas throughout.
All methods should come with simulations to aid understanding.
All methods should come with sims to aid intuition of how good they are.
Use code (non sims) to help understand as well. Does a basic numerical solution help understanding? Then do it.
Everything should be visualised.

Should always start with "what is the model, how are we fitting it (and why in that way)."
When possible, should fit the same model in a different way. Freq + bayes. ML + freq/bayes.



## Manifesto draft

* Understanding is more important than maths and precision.

* Models, then fitting, then implementation.

* There are no bad methods, just bad applications.

* Implementation is essentially uninteresting.

* To understand things, you should use it and interactively examine it.

* Inference and statistical tests are one, not especially interesting corner of statistics.

* Knowing the names of tests is mostly unimportant.

* You don't need to learn a list of assumptions if you understand the model.

* Assume library(tidyverse) and not much else.

* This isn't an R course.

* This is a careful, exhaustive statistics course.


## Library



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


