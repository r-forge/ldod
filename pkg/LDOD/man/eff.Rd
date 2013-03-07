\name{eff}
\alias{eff}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Calculation of D-efficiency with arbitrary precision 
}
\description{
Calculates the D-effficiency of design \eqn{\xi_1} respect to design \eqn{\xi_2} with arbitrary precision.
}
\usage{
eff(ymean, yvar, param, points1, points2, weights1, weights2, prec = 53)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{ymean}{ a character string, 
formula of \eqn{E(y)} with specific satndard: characters \code{b1}, \code{b2}, \code{b3}, \dots symbolize model parameters and \code{x1}, \code{x2}, \code{x3}, \dots symbolize explanatory variables. See 'Examples'.
}
  \item{yvar}{
a character string, formula of \eqn{Var(y)} with specific standard as \code{ymean}. See 'Details' and 'Examples'.
}
  \item{param}{
a vector of values of parameters which must correspond to \code{b1}, \code{b2}, \code{b3}, \dots in \code{ymean}. The number of parameters can not be more than \eqn{4}.
}
  \item{points1}{
a vector of \eqn{\xi_1} points. See 'Details'.
}
  \item{points2}{
a vector of \eqn{\xi_2} points. See 'Details'.
}
  \item{weights1}{
a vector of \eqn{\xi_1} points weights. The sum of weights should be \eqn{1}; otherwise they will be normalized.
}
  \item{weights2}{
a vector of \eqn{\xi_2} points weights. The sum of weights should be \eqn{1}; otherwise they will be normalized.
}
  \item{prec}{ 
(optional) a number, the maximal precision to be used for D-efficiency calculation, in bite. Must be at least \eqn{2} (default \eqn{53}).
}
}
\details{
If response variables have the same constant variance, for example \eqn{\sigma^2}, then \code{yvar} must be \eqn{1}.  


Consider design \eqn{\xi} with \eqn{n} \eqn{m}-dimensional points. Then, the vector of \eqn{\xi} points is 
\deqn{(x_1, x_2, \ldots, x_i, \ldots, x_n),}
where \eqn{x_i = (x_{i1}, x_{i2}, \ldots, x_{im})}. Hence the length of vector points is \eqn{mn}.
}
\value{
D-efficiency as an 'mpfr' number.
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
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
}


\examples{
## Logistic dose-response model
ymean <- "(1/(exp(-b2*(x1-b1))+1))"
yvar <- "(1/(exp(-b2*(x1-b1))+1))*(1-(1/(exp(-b2*(x1-b1))+1)))"
eff (ymean, yvar,  param = c(.9, .8), points1 = c(-3, 1, 2), 
     points2 = c(-1.029256,  2.829256), weights1 = rep(.33, 3), weights2 = c(.5, .5),
     prec = 54)
## or
ldlogistic(a = .9 , b = .8, form = 2, lb = -5, ub = 5, user.points = c(-3, 1, 2),
           user.weights = c(.33, .33, .33))$user.eff


## Poisson model:
ymean <- yvar <-  "exp(b1 + b2 * x1)"
eff (ymean, yvar,  param = c(.9, .8), points1 = c(-3, 1, 2), points2 = c(2.5, 5.0),
     weights1 = rep(.33, 3), weights2 = c(.5, .5), prec = 54)

#####################################################################
## In the following, ymean and yvar for some famous models are given:

## Logistic model:
ymean <- "1/(exp(-b1 - b2 * x1) + 1)"
yvar <- "(1/(exp(-b1 - b2 * x1) + 1))*(1 - (1/(exp(-b1 - b2 * x1) + 1)))"

## Poisson dose response model:
ymean <- yvar <- "b1 * exp(-b2 * x1)"

## Inverse Quadratic model:
ymean <- "(b1 * x1)/(b2 + x1 + b3 * (x1)^2)"
yvar <- "1"
#
ymean <- "x1/(b1 + b2 * x1 + b3 * (x1)^2)"
yvar <- "1"

## Weibull model:
ymean <- "b1 - b2 * exp(-b3 * x1^b4)"
yvar <- "1"

## Richards model:
ymean <- "b1/(1 + b2 * exp(-b3 * x1))^b4"
yvar <- "1"

## Michaelis-Menten model:
ymean <- "(b1 * x1)/(1 + b2 * x1)"
yvar <- "1"
#
ymean <- "(b1 * x1)/(b2 + x1)"
yvar <- "1"
#
ymean <- "x1/(b1 + b2 * x1)"
yvar <- "1"

## log-linear model:
ymean <- "b1 + b2 * log(x1 + b3)"
yvar <- "1"

## Exponential model:
ymean <- "b1 + b2 * exp(x1/b3)"
yvar <- "1"

## Emax model:
ymean  <- "b1 + (b2 * x1)/(x1 + b3)"
yvar <- "1"

## Negative binomial model Y ~ NB(E(Y), theta) where E(Y) = b1 * exp(-b2 * x1):
theta <- 5
ymean <- "b1 * exp(-b2 * x1)"
yvar <- paste ("b1 * exp(-b2 * x1)*(1 + (1/", theta, ") * b1 * exp(-b2 * x1))", sep = "")

## Linear regression model:
ymean <- "b1 + b2 * x1 + b3 * x2 + b4 * x1 * x2"
yvar = "1"
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{optimal design}
\keyword{Fisher information matrix}
\keyword{D-efficiency}

