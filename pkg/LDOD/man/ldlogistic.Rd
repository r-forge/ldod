\name{ldlogistic}
\alias{ldlogistic}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Locally D-optimal designs for Logistic model
}
\description{
%Finds Locally D-optimal designs for Logistic and Logistic dose-response models which are defined as E(y) = (1/(exp(-a - b * x)+1)), V(y) = (1/(exp(-a - b * x) + 1)) * (1 - (1/(exp(-a - b * x) + 1))) and E(y) = (1/(exp(-b * (x - a)) + 1)), V(y) = (1/(exp(-b * (x - a)) + 1)) * (1 - (1/(exp(-b * (x - a)) + 1))), respectively.

Finds Locally D-optimal designs for Logistic and Logistic dose-response models which are defined as \eqn{E(y) = 1/(1+\exp(-a-bx))} and \eqn{E(y) = 1/(1+\exp(-b(x-a)))} with \eqn{Var(y) = E(y)(1-E(y))}, respectively, where \eqn{a} and \eqn{b} are unknown parameters. 
}
\usage{
ldlogistic(a, b, form = 1 , lb, ub, user.points = NULL, user.weights = NULL, 
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
  \item{form}{
must be \code{1} or \code{2}. If \code{form = 1}, then \eqn{E(y)=(1/(\exp(-a-bx)+1))}; if 'form = 2', then \eqn{E(y)=1/(\exp(b2(x-b1))+1)}.
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

Kiefer, J. C.  (1974), General equivalence theory for optimum designs (approximate theory). Ann. Statist., 2, 849-879.
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
ldlogistic(a = .9 , b = .8, form = 1, lb = -5, ub = 5)
# $points: -3.0542559  0.8042557

## usage of n.sim and n.restars:
# Various responses for different values of rseed

ldlogistic(a = 20 , b = 10, form = 1, lb = -5, ub = 5, rseed = 9) 
# $points: -4.746680 -1.976591 

ldlogistic(a = 20 , b = 10, form = 1, lb = -5, ub = 5, rseed = 11) 
# $points -4.994817 -2.027005

ldlogistic(a = 20 , b = 10, form = 1, lb = -5, ub = 5, n.restarts = 5, n.sim = 5)
# (valid response) $points: -2.15434, -1.84566

## usage of precision:
ldlogistic(a = 22 , b = 10, form = 1, lb = -5, ub = 20, n.restarts = 7, n.sim = 7,
           user.points = c(20, 5), user.weights = c(.5, .5)) # $user.eff: NaN

ldlogistic(a = 22 , b = 10, form = 1, lb = -5, ub = 20, n.restarts = 7, n.sim = 7,
           user.points = c(20, 5), user.weights = c(.5, .5), prec = 321) # $user.eff: 0
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{optimal design}
\keyword{Logistic}% __ONLY ONE__ keyword per line
\keyword{equivalence theorem}
