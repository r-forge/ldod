\name{ldnbinom}
\alias{ldnbinom}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Locally D-optimal designs for Negative Binomial model
}
\description{
%Finds Locally D-optimal designs for  Negative binomial regression model which is defined as E(y) = a * exp(-b * x) and 
%V(y) = sigma^2 * a * exp(-b * x) * (1 + (a * exp(-b * x)/theta)), where sigma is an unknown consonant and theta is .
Finds Locally D-optimal designs for  Negative Binomial regression model which is defined as \eqn{E(y) = \lambda(x)} with \eqn{Var(y) = \sigma^2\lambda(x)(1+(\lambda(x)/\theta))}, where \eqn{y ~ NB(\theta, \lambda(x))}, \eqn{\lambda(x) = a\exp(-bx)} and \eqn{a}, \eqn{b} and \eqn{\sigma} are unknown parameters.

}
\usage{
ldnbinom(a, b, theta, lb, ub, user.points = NULL, user.weights = NULL,
..., n.restarts = 1, n.sim = 1, tol = 1e-8, prec = 53, rseed = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{a}{
initial value for paremeter \eqn{a}.
}
  \item{b}{
initial value for paremeter \eqn{b}.
}
  \item{theta}{
initial value for paremeter \eqn{\theta} which is the number of successes in a sequence of Bernoulli trials, must be a Natural number.
}
  \item{lb}{
lower bound of design interval.
}
  \item{ub}{
upper bound of design interval.
}
  \item{user.points}{
(optional) vector of user design points which calculation of its D-efficiency is aimed. Each element of \code{user.points} must be within the design interval.

}
  \item{user.weights}{
(optional) vector of weights which its elements correspond to \code{user.points} elements. The sum of weights should be \eqn{1}; otherwise they will be normalized.
}
  \item{\dots}{
(optional) additional parameters will be passed to function
\code{\link{curve}}. 
}
  \item{prec}{
(optional)
a number, the maximal precision to be used for D-efficiency calculation, in bite. Must be at least \eqn{2} (default \eqn{53}), see 'Details'.
%(default 53, corresponds to double precision)
}
   \item{n.restarts}{
(optional optimization parameter)
number of solver restarts required in optimization process (default \eqn{1}), see 'Details'.
}
  \item{n.sim}{
(optional optimization parameter)
number of random parameters to generate for every restart of solver in optimization process (default \eqn{1}), see 'Details'.
}
  \item{tol}{
(optional optimization parameter)
relative tolerance on feasibility and optimality in optimization process (default \eqn{1e-8}).
}
\item{rseed}{
(optional optimization parameter) a seed to initiate the random number generator, else system time will be used. 
}
}
\details{
While D-efficiency is \code{NaN}, an increase in the value of \code{prec} can be beneficial to achieve a numeric value, however, can slow down the calculation speed. 

Values of \code{n.restarts} and \code{n.sim} should be chosen according to the length of design interval.
}
\value{
plot of derivative function, see 'Note'.

a list containing the following values: 
\item{points}{obtained design points} 
\item{weights}{corresponding weights to the obtained design points}
\item{det.value}{value of Fisher information matrix determinant at the obtained design}
\item{user.eff}{D-efficeincy of user design, if \code{user.design} and \code{user.weights} are not \code{NULL}. }
}
\references{
Masoudi, E., Sarmad, M. and Talebi, H. 2012, An Almost General Code in R to Find Optimal Design, In Proceedings of the 1st ISM International Statistical Conference 2012, 292-297.

Rodriguez-Torreblanca, C. Rodriguez-Diaz, J.M. (2007), Locally D- and c-optimal designs for Poisson and negative binomial regression models, Metrika, 66, 161-172.

Kiefer, J. C.  1974, General equivalence theory for optimum designs (approximate theory), Ann. Statist., 2, 849-879.
}
\author{
Ehsan Masoudi, Majid Sarmad and Hooshang Talebi
}
\note{
To verify optimality of obtained design, derivate function   
(symmetry of Frechet derivative with respect to the x-axis) 
will be plotted on the design interval. Based on the equivalence theorem (Kiefer, 1974), a design is optimal if and only if its derivative function are equal or less than \eqn{0} on the design interval. The equality must be achieved just at the obtained points.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{cfisher}}, \code{\link{cfderiv}} and \code{\link{eff}}.
}
\examples{
ldnbinom(a = 2, b = 3, theta = 10, lb = -3, ub =3) 
# $points: -3.0000000 -0.8115872

## D-effecincy computation:
ldnbinom(a = 2, b = 3, theta = 10, lb = -3, ub =3, user.points = c(2, -3),
user.weights = rep(.5, 2)) # $user.eff: 0.06099
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{optimal design}
\keyword{Negative Binomial}% __ONLY ONE__ keyword per line
\keyword{equivalence theorem}

