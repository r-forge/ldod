\name{ldweibull}
\alias{ldweibull}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Locally D-optimal designs for Weibull model
}
\description{
Finds Locally D-optimal designs for Weibull regression model which is defined as \eqn{E(y) = a-b\exp(-\lambda*x^h)} with \eqn{Var(y) = \sigma^2}, where \eqn{a}, \eqn{b}, \eqn{\lambda}, \eqn{h} and \eqn{\sigma} are unknown parameters.
}
\usage{

ldweibull(a, b, lambda, h, lb, ub, user.points = NULL, user.weights = NULL, 
...,  n.restarts = 1, n.sim = 1, tol = 1e-8, prec = 53, rseed = NULL) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{a}{
initial value for paremeter \eqn{a}.
}
  \item{b}{
initial value for paremeter \eqn{b}.
}
  \item{lambda}{
initial value for paremeter \eqn{\lambda}.
}
  \item{h}{
initial value for paremeter \eqn{h}.
}
  \item{lb}{
lower bound of design interval, must be greater than \eqn{0}. Value \eqn{0} for lower bound is not allowed, instead of \eqn{0} a small value such as \eqn{10^-10}
can be used.
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
number of random parameters to generator for every restart of solver in optimization process (default \eqn{1}), see 'Details'.
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
While D-efficiency is \code{NaN}, an increase in \code{prec} can be beneficial to achieve a numeric value, however, it can slow down the calculation speed.  

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

Dette, H., Pepelyshev, A. (2008), Efficient Experimental Designs for Sigmoidal Growth Models, Statistical Planning and Inference, 138, 2-17.

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
ldweibull(a = 1, b = 1, lambda = 2, h = 1, lb = 10^-10, ub =3) 
# $points: 0.0000000001 0.1713914120 0.8002692550 3.0000000000

## usage of n.sim and n.restars:
# Various responses for different rseed

ldweibull(a = 1, b = 1, lambda = 3, h = 1, lb = 0.001, ub = 19, rseed = 1) 
# $points: 0.0010000  0.2991952  5.2428039 19.0000000

ldweibull(a = 1, b = 1, lambda = 3, h = 1, lb = 0.001, ub = 19, rseed = 19) 
# $points: 0.001000  1.217404  3.566328 19.000000

ldweibull(a = 1, b = 1, lambda = 3, h = 1, lb = 0.001, ub = 19, n.sim = 10, n.restarts = 10) 
# (valid respone) $points: 0.0010000, 0.1205858,  0.5544623, 19.0000000
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{optimal design}
\keyword{Weibull}% __ONLY ONE__ keyword per line
\keyword{equivalence theorem}
