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

t5.11{
The simple loss functions previously mentioned don't consider probability in any way. If we want principled uncertainty estimates (how accurate do we think our parameter estimates are?) we need to include probability. #stats280
}

t5.12{
The first step for including probability with our models is to have a loss metric that is on the probability scale. If the model estimates a value 'pred' but we observe 'obs' what is the probability of this occurring. #stats280
}

t5.13{
This is called the likelihood. The likelihood is the probability of the data if we assume a certain parameter is true. #stats280
}

t5.14{
Likelihood is similar to probability. If we know the model parameters we talk about probability of data. P(heads) = 0.5 on a fair coin. #stats280
}

t5.15{
  If we know the data we talk about likelihood of parameters. If we see 60 heads, what's the likelihood that the coin is fair i.e. 50/50? #stats280
}

t5.16{
In a continuous world we talk about probability density which doesn't relate to our typical understanding of probability. #stats280
}


t5.17{
The probability of getting exactly 0.1 from a random number between 0 and 1 is zero, so we talk about density instead. #stats280
}

t5.18{
Here is the normal probability density function with mean μ and sd σ. For any x we get a probability density. #stats280
}{normalPDF.png}

t5.19{
In this case where we know μ=0 the probability density of drawing an x value of -1 is about 0.25. #stats280
}{normalPDF2.png}

t5.20{
In this case where we know μ=0 the probability density of drawing an x value of -1 is about 0.25. #stats280
}{normalPDF2.png}

t5.21{
  Now imagine we don't know the value of the mean μ but we have seen a datapoint with x=-1. #stats280
}{normalPDF2.png}

t5.22{
The likelihood that the datapoint came from a distribution with μ=0 is 0.25. Reverse logic to probability. #stats280
}{normalPDF2.png}

t5.23{
We can calculate the likelihood for each value of μ given that we've seen our one data point at x=-1. #stats280
}{likelihoodNorm.png}




t5.24{
This is the likelihood function. The Maximum likelihood estimate of μ is at the highest value (μ=-1 here).  #stats280
}{likelihoodNorm.png}



t5.25{
If we see two data points, to find the probability that they're both froma norm with μ=0 we mulitiply the probs. #stats280
}{normalPDF3.png}

t5.26{
We multiply them because thats how you get P(event A AND event B). Probability of heads AND heads is 0.5 x 0.5 = 0.25 #stats280
}{}

t5.27{
If we see n data points, we multiply them all together (written as Π). And this is our likelihood function. #stats280
}{productLikelihoodNorm.png}

t5.28{
Multiplying the likelihoods of each data point assumes that all the datapoints come from the same distribution. It also assume they are independent of the others (i.e. if we see one high datapoint, the next datapoint is no more likely to be high than usual). #stats280
}{productLikelihoodNorm.png}

This tweet rephrased from Mark brewer. Not sure how to handle this stuff.



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
