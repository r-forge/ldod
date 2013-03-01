\name{ldrichards}
\alias{ldrichards}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Locally D-optimal designs for Richards model
}
\description{
Finds Locally D-optimal designs for Richards regression model which is defined as \eqn{E(y) = a/(1+b\exp(-\lambda*x))^h} with \eqn{Var(y) = \sigma^2}, where \eqn{a}, \eqn{b}, \eqn{\lambda}, \eqn{h} and \eqn{\sigma} are unknown parameters.
}
\usage{
ldrichards(a, b, lambda, h, lb, ub, user.points = NULL, user.weights = NULL,
..., n.restarts = 1, n.sim = 1, tol = 1e-8, prec = 53) 
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
lower bound of design interval, must be greater than or equal to \eqn{0}.
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
ldrichards(a = 1, b = 2, lambda = 2, h = 3, lb = 0, ub =3) 
## $points: 0.1805017 0.8296549 1.6139494 3.0000000

## D-effecincy computation:
ldrichards(a = 1, b = 2, lambda = 2, h = 3, lb = 0, ub =3,
user.points = c(0.18, 0.82, 1.61, 3, 2), user.weights = rep(1, 5)) 
## $user.eff: 0.928

## usage of n.sim and n.restars
result <- list()
for (i in 1:20)
  result[[i]] <- ldrichards(a = 1, b = 4, lambda = 3, h = 6, lb = 0, ub = 19) 
sapply(result, "[", 1) ## unstable values for design points

ldrichards(a = 1, b = 4, lambda = 3, h = 6, lb = 0, ub = 19, n.sim = 10, n.restarts = 10) 
## $points: 0.6562009,  1.0485844, 1.5894946, 19.0000000
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{optimal design}
\keyword{Richards}% __ONLY ONE__ keyword per line
\keyword{equivalence theorem}
