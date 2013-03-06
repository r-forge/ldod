\name{cfisher}
\alias{cfisher}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Auto-constructing Fisher Information matrix
}
\description{
Auto-constructs Fisher information matrix for nonlinear and generalized linear models as two \R functions.
%models that their response variables are independent and can be writen as a function of explanatory variables and parameters. This function must be continuous and differentiable with respect to the models parameters. In addition, distribution of response variable must belong to the Natural exponential family. See 'Note' for more details.
}
\usage{
cfisher(ymean, yvar, ndpoints, prec = 53)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{ymean}{ a character string, 
formula of \eqn{E(y)} with specific satndard: characters \code{b1}, \code{b2}, \code{b3}, \dots symbolize model parameters and \code{x1}, \code{x2}, \code{x3}, \dots symbolize explanatory variables. See 'Examples'.
}
  \item{yvar}{
a character string, formula of \eqn{Var(y)} with specific standard as \code{ymean}. See 'Details' and 'Examples'.
}
  \item{ndpoints}{
number of design points.
}
  \item{prec}{
(optional) a number, the maximal precision to be used for D-efficiency calculation, in bite. Must be at least \eqn{2} (default \eqn{53}).
%A number, the maximal precision to be used for D-efficiency calculation, in bite. Must be at least 2 (default 53)%
}
}
\details{
If response variables have the same constant variance, for example \eqn{\sigma^2}, then \code{yvar} must be \eqn{1}. 
}
\value{
a list containing two closures:
\item{fim}{ a function in which its arguments are vector of design points (\eqn{x}), vector of corresponding weights (\eqn{w}) and vector of parameters (\eqn{\beta}) and its output is Fisher information matrix.}
\item{fim.mpfr}{a function in which its arguments are vector of design points (\eqn{x}), vector of corresponding weights (\eqn{w}) and vector of parameters (\eqn{\beta}) and its output is Fisher information matrix of class 'mpfrMatrix'.}
For more details, see 'Note'.
}
\references{
Masoudi, E., Sarmad, M. and Talebi, H. 2012, An Almost General Code in R to Find Optimal Design, In Proceedings of the 1st ISM International Statistical Conference 2012, 292-297.
}
\author{
Ehsan Masoudi, Majid Sarmad and Hooshang Talebi
}
\note{
This function is applicable for models that can be written as \eqn{E(Y_i)=f(x_i,\beta)}
where \eqn{y_i} is the \eqn{ith} response variable, \eqn{x_i} is the observation vector of the \eqn{ith} explanatory variables, \eqn{\beta} is the vector of parameters and \eqn{f} is a continuous and differentiable function with respect to \eqn{\beta}.
In addition, response variables must be independent with distributions that belong to the Natural exponential family. Logistic,Poisson, Negative Binomial, Exponential,  Richards, Weibull, Log-linear, Inverse Quadratic and Michaelis-Menten are examples of these models.

 %If the interested design contains n m-dimensional points, then the length of 'points' will be 
 
Consider a \eqn{p}-parameter model and a design \eqn{\xi} that contains \eqn{n} \eqn{m}-dimensional points. Then \deqn{x = (x_1, x_2, \ldots, x_i, \ldots, x_n),}
\deqn{w =  (w_1, w_2,\ldots, w_n),} \deqn{\beta = (\beta_1, \beta_2, \ldots, \beta_p),} where \eqn{x_i = (x_{i1}, x_{i2}, \ldots, x_{im})} is the \eqn{ith} design point.
}

%= (x_{11}, x_{12}, x_{1m}, \ldots, x_{ij}, \ldots,x_{n1}, x_{n2}, \ldots, x_{nm} )where xij is the jth element of the ith design point.
%% ~Make other sections like Warning with \section{Warning }{....} ~


\examples{
## Logistic dose response model
ymean <- "(1/(exp(-b2 * (x1 - b1)) + 1))"
yvar <- "(1/(exp(-b2 * (x1 - b1)) + 1)) * (1 - (1/(exp(-b2 * (x1 - b1)) + 1)))"
res <- cfisher(ymean, yvar, ndpoints = 2, prec = 54)

# res$fim is Fisher information matrix for a two-points design 
res$fim(x = c(x11 = 2, x21 = 3), w = c(w1 = .5, w2 = .5), b = c(b1 = .9, b2 = .8))

# res$fim is Fisher information matrix for a two-points design with 54 precision
res$fim.mpfr(x = c(x11 = 2, x21 = 3), w = c(w1 = .5, w2 = .5), b = c(b1 = .9, b2 = .8))

# Fisher information matrix for model:
fim<- cfisher(ymean, yvar, ndpoints = 1, prec = 54)
res$fim(x = c(x11 = 2), w = c(w1 = 1), b = c(b1 = .9, b2 = .8))

## posison with E(y) = exp(b1 + b2 * x1 + b3 * x1^2 + b4 * x2 +b5 * x2^2 + b6 * x1 * x2)
ymean <- yvar <- "exp(b1 + b2 * x1 + b3 * x1^2 + b4 * x2 +b5 * x2^2 + b6 * x1 * x2)"
fim <- cfisher(ymean, yvar, ndpoints = 6, prec = 54)

# res$fim is Fisher information matrix for a six-points design 
res$fim(x = c(1:12), w = rep(1/6, 6), b = c(1:6)) ## NAN

# res$fim.mpfr is Fisher information matrix for a six-points design with 53 precision
res$fim.mpfr(x = c(1:12), w = rep(1/6, 6), b = c(1:6))

## Linear regression with two indeoendent varibales (the design points are two-dimensional)
ymean <- "b1 + b2 * x1 + b3 * x2"
yvar = "1"
res <- cfisher(ymean, yvar, ndpoints = 3, prec = 54)
res$fim(x = c(1:6), w = c(.3, .3, .3))
res$fim.mpfr(x = c(1:6), w = c(.3, .3, .3))

## Logistic model:
ymean <- "1/(exp(-b1 - b2 * x1) + 1)"
yvar <- "(1/(exp(-b1 - b2 * x1) + 1)) * (1 - (1/(exp(-b1 - b2 * x1) + 1)))"
cfisher(ymean, yvar, ndpoints = 2, prec = 54)

## Poisson model:
ymean <- yvar <-  "exp(b1 + b2 * x1)"
cfisher(ymean, yvar, ndpoints = 2, prec = 54)

## Poisson dose response model:
ymean <- yvar <- "b1 * exp(-b2 * x1)"
cfisher(ymean, yvar, ndpoints = 2, prec = 54)

## Inverse Quadratic model:
ymean <- "(b1 * x1)/(b2 + x1 + b3 * (x1)^2)"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 3, prec = 54)
#
ymean <- "x1/(b1 + b2 * x1 + b3 * (x1)^2)"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 3, prec = 54)

## Weibull model:
ymean <- "b1 - b2 * exp(-b3 * x1^b4)"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 4, prec = 54)

## Richards model:
ymean <- "b1/(1 + b2 * exp(-b3 * x1))^b4"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 4, prec = 54)

## Michaelis-Menten model:
ymean <- "(b1 * x1)/(1 + b2 * x1)"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 2, prec = 54)
#
ymean <- "(b1 * x1)/(b2 + x1)"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 2, prec = 54)
#
ymean <- "x1/(b1 + b2 * x1)"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 2, prec = 54)

## log-linear model
ymean <- "b1 + b2 * log(x1 + b3)"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 3, prec = 54)

## Exponential model:
ymean <- "b1 + b2 * exp(x1/b3)"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 3, prec = 54)

## Emax model:
ymean  <- "b1 + (b2 * x1)/(x1 + b3)"
yvar <- "1"
cfisher(ymean, yvar, ndpoints = 3, prec = 54)

## Negative binomial model Y ~ NB(E(Y), theta) where E(Y) = b1*exp(-b2*x1):
theta = 5
ymean <- "b1 * exp(-b2 * x1)"
yvar <- paste("b1 * exp(-b2 * x1) * (1 + (1/", theta, ") * b1 * exp(-b2 * x1))", sep = "")
cfisher(ymean, yvar, ndpoints = 3, prec = 54)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{optimal design}
\keyword{Fisher information matrix}% __ONLY ONE__ keyword per line

