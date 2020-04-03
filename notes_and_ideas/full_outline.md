# Stats280


change structure. do parameter selection first, then model structure, then model selection.

"For any dataset, there are many models we could fit. How do we decide which is best? It depends on the aim/question. If prediction is our aim, we simply measure how well they predict! "
This is first tweet in model selection.

But do I want to do "asking questions with model selection" and "overfitting" before parameter selection? Probably. Just reuse old tweets.

# Contents


# Intro

## Overview 1
Exploratory
Predictive
Confirmatory


## Overview 2
Model selection
Model structure
Parameter selection
Implementation


## Overview 3
Asking questions with models


## Overview 4
Overfitting, bias variance.



# 5 Parameter selection

Use y = mx + c as baseline

Principles:
  Define a loss metric
  Often chose best parameter set
  Sometimes, consider all parameters with probability


t5.1{
Let's examine how we choose parameter values. To do this we will use the very simple model y = mx + c. #stats280
}{picture of data and some lines}

t5.2{
If we were doing mathematical modelling without statistics, we might be able to get parameter values from the literature, but instead we want to learn the values from the data. #stats280
}

t5.3{
The way we do this is to choose a loss metric that tells us how good a set of parameters are. Generally, the bigger the distance between the data and the predictions from the mode, the worse the model. #stats280
}

t5.4{
Being able to calculate how good a specific parameter set is doesn't directly tell us how to find the best parameter set. But that will be covered in the implementation section. #stats280
}

t5.5{
Some methods focus on one "best" set of parameters. Other methods always consider all parameter values but calculate how likely each set is. #stats280
}

## Simple loss 1: mae

t5.6{
First let's consider some really simple loss metrics. The simplest is to calculate the absolute distance between each datapoint and it's prediction from the model. Then take the mean, giving the mean absolute error. #stats280
}

## Simple loss 2: least squares.

t5.7{
  Another simple loss metric is the root mean squared error (RMSE). Because you use the squared error, this metric cares more about the points that are far away from the model prediction. #stats280
}{Plot of max MAE and RMSE with one outlier? Or multiple lines for each with colour showing value}

t5.8{
We use RMSE because it is on the same scale as the data. But the best parameters from RMSE will always be the same as the best parameters from the sum of the squared error. So this is the same as the well known least squares. #stats280
}

t5.9{
There are two reasons why RMSE is so common. First, unlike MAE, it is continuously differentiable which is mathematically and computationally useful.
}

t5.10{
  Secondly, it happens to give the same optimal parameter sets as the maximum likelihood estimate for a  normal likelihood. Likelihood will be the next topic.
}



## Max Likelihood




## Bayes


## Regularisation




# 6 Model structure

## Continuous Linear models


## Categorical linear models


## Categorical mixed-effect

## continuous mixed-effect


## Splines

## Gaussian-process


## Neural networks


## Trees



# 7 Model selection

## Out of sample prediction


## AIC


## Frequentist tests


## Bayes




# 8 Implementation

More details on what counts as implementation


## Optimisation

### unimodal

### multimodal


### Optimisation with standard loss

### Max likelihood

### MAP estimate


### Bayes

Some models are exact, but most aren't.

#### TMB style?

Do MAP then approximate with of posterior

#### MCMC

Do properly


## 9 Case studies
