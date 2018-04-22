# Stats for twitter

## 
tag #280stats biostats?



## Overarching ideas

Exploratory, confirmatory, predictive.

Model selection, model structure, parameter selection, implementation.

Inference agnostic. Frequentism, bayes, ML.

Simulate to understand, simulate to check.
* Is this inference shit
* How does frequentism work
* How does probability work/look like.
* What is the data generating mechanism that the model assumes?

Intuition of underlying theory, but not bogged down in maths.
* Few/no implementation details.
* Few equations.
* Never named tests without context.



Model selection, model structure + parameter selection + implementation.

Orthogonal to Exploratory, confirmatory, predictive.


Model selection: IT, freq, bayes, out of sample. + visual diagnostics etc., especially for confirmatory. If parameter estimation, a priori model selection only. Inter cluster distance etc. if you have no Y.
Model structure: Lots. glm, fixed vs random effects, trees, GP, categorical vs continuous Y, categorical vs continuous X. Mechanistic models.
Parameter selection: Max Likelihood, bayes, CV for hyperpars, normalized information gain etc.
Implementation: MCMC vs INLA for example.

Some dependence. Certain model selections require certain parameter selections. Can't do AIC/freq/bayes unless loss function is likelihood (+ prior).  
Can't select with out of sample unless you have Ys.

Confirmatory: probably model selection by IT, freq or bayes, probably relatively simple model structure or mechanistic model
Predictive: probably model selection by an out-of-sample metric.




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

https://dynamicecology.wordpress.com/2013/10/16/in-praise-of-exploratory-statistics/
http://topepo.github.io/caret/index.html
https://github.com/dzchilds/stats-for-bio
http://dzchilds.github.io/aps-data-analysis-L1/
http://www.biostathandbook.com/

"Visualization can surprise you, but it doesn’t scale well.
Modeling scales well, but it can’t surprise you."


http://onlinelibrary.wiley.com/doi/10.1111/j.1466-8238.2007.00331.x/abstract


## Contents


   
   
   
### Under/overfitting
   - bias - variance
   
### Model selection.
   - AIC
   - Bayes
   - CV
   - Frequentism
   - a priori

### parameter selection
   - MaxLike
   - Bayes
   - ML errors

### Model structure

Over view:
 - y ~ x
 - What is Y (nothing, single, vector)
 - What is x, number of vars, f(x), etc.

   - LM
   - GLM
   - ANOVA
   - discrete vs discrete
   - GAM
   - gaussian process
   - Random Effects
   - Neural network
   - trees
   - Ensembles
   
   - PCA


### Implementation

#### Software.

Small differences.
Some is wrong!

#### Algorithm

Both correct: sum of squares vs ompimising the likelihood.

#### MCMC vs INLA

Sometimes differences are different underlying approximations.
Something may be impossible one way, but possible another.


#### Non-converging

Just broken

Can't find optimum or whatever


#### Neural nets
- No expectation of finding true minimum.
- The implementation is an integral part of "accuracy".



### Specialist subjects.

#### Spatial methods

#### neural nets?





## Contents

### Overview 1
Exploratory
Predictive
Confirmatory


### Overview 2
Model selection
Model structure 
Parameter selection
Implementation



### Model structures overview

~ X1 + X2 - Clustering, dimensionality reduction (mostly ignore)
c(Y1, Y2) ~ X1 + X2 - Classification, multivariate stats. (mostly ignore)
Y ~ X1 + X2 - EVERYTHING


How many x's
What form f(x)
Distributions. Error distribution of y, distribution of random effects, etc.


Parametric vs nonparametric.

#### Continuous / natural numbers Y

Regression y ~ x1 + x2 + ...
   - Normal (b + f)
   - Poisson (b + f)
   - Random effects (b + f)
   - machine learning, LASSO.
   
ANOVA/t-test y ~ factor(x)
2 way ANOVA y ~ factor(x1)*factor(x2) 

#### Binomial Y
   - Fisher's exact or something.
   - Logistic regression (b + f)
   - ML classification




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






## Under fit over fit

### As bias variance.

High bias, low variance.

	
ggplot(d, aes(disp, mpg, colour = boot, group = boot)) +
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE)

d<- mtcars  %>% 
	sample_frac(20, replace = TRUE) %>% 
	mutate(boot = factor(rep(1:20, nrow(mtcars)))) 

ggplot(d, aes(disp, mpg)) +
  geom_point() + 
  geom_smooth(se = FALSE, span = 0.5) +
  facet_wrap( ~ boot)
	  
	  
ggplot(d, aes(disp, mpg)) +
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE) +
  geom_smooth(se = FALSE, span = 0.5, colour = 'red') +
  facet_wrap( ~ boot)


	  
	  
	  
	  
	  




## Implementation.


### Software.

Small differences.
Some is shit.

### Algorithm

Both correct:

No intercept:
lm(mpg ~ 0 + qsec, mtcars)$coef

mtcars %$% {sum(qsec * mpg) / sum(qsec ^ 2)}

beta <- seq(-20, 20, 1e-4)
ss <- sapply(beta, function(b) mtcars %$% sum((b*qsec - mpg)^2))
plot(ss ~ beta)
beta[which.min(ss)]




### MCMC vs INLA

Sometimes differences are different underlying approximations.
Something may be impossible one way, but possible another.


### Non-converging

Just broken

Can't find optimum or whatever


### Neural nets
- No expectation of finding true minimum.
- The implementation is an integral part of "accuracy".

	




### parameter estimation

#### overview

Given a model structure, the main task in statistics is to estimate the parameters. #stats280

In general to do this we define what we count as a 'good' set of parameters and then find the values for each parameter that are "most good". #stats280

The practical side of finding these good parameter values will be covered later in the"implementation" section. #stats280

Our definition of good or bad parameters has to be a function that takes the real value of a datapoint and the value 
Predicted by the model and returns a number. This number is the "loss". #stats280




#### loss functions

The simplest loss functions are simply a measurement of how well out poorly the model and a set of parameters predicts the data. #stats280

This can include things like the absolute error. 

#### likelihood

If you wanted to draw a line between statistics and machine learning (I don't) this wouldn't be a bad choice. #stats280
#### bayes









	  
