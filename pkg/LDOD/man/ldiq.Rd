\name{ldiq}
\alias{ldiq}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Locally D-optimal designs for Inverse Quadratic model
}
\description{
 %A concise (1-5 lines) description of what the function does. ~~
Finds Locally D-optimal designs for Inverse Quadratic regression model which is defined as \eqn{E(y)=ax/(b+x+cx^2)} or \eqn{E(y)=x/(a+bx+cx^2)} with \eqn{Var(y) = \sigma^2}, where \eqn{a}, \eqn{b}, \eqn{c} and \eqn{\sigma} are unknown parameters.

}
\usage{
ldiq(a, b, c, form, lb, ub, user.points = NULL, user.weights = NULL, 
..., n.restarts = 1, n.sim = 1, tol = 1e-8, prec = 53, rseed = NULL)

}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{a}{ 
initial value for paremeter \eqn{a}, see 'Details'.
}
  \item{b}{
initial value for parameter \eqn{b}, see 'Details'.
}
  \item{c}{
initial value for parameter \eqn{c}, see 'Details'.
}
  \item{form}{
must be \code{1} or \code{2}. If \code{form = 1}, then \eqn{E(y)=ax/(b+x+cx^2)}; if \code{form = 2}, then \eqn{E(y)=x/(a+bx+cx^2)}.
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
\item{rseed}{
(optional optimization parameter) a seed to initiate the random number generator, else system time will be used. 
}
}

\details{
For each form of Inverse Quadratic model, the parameters must satisfy specific conditions: 


if \code{form = 1}
\deqn{a,b,c>0, 2\sqrt(bc)>1,}
if \code{form = 2}
\deqn{a,c>0,  |b|<\sqrt(ac),}
for more details see Dette and Kiss (2009).
 
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

Dette, H., Kiss, C., (2009), Optimal experimental designs for Inverse Quadratic Regression models, Statistica Sinica, 19, 1567-1586.

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
ldiq(a = 17 , b = 15, c = 9, form = 1, lb = 0, ub = 15) 
# $points: 0.4141466 1.2909896 4.0242083

## D-effecincy computation
ldiq(a = 17 , b = 15, c = 9, form = 2, lb = 0, ub = 15, user.points = c(10,2,4),
user.weights = c(.33, .33, .33)) # $user.eff: 0.18099
}


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{optimal design}
\keyword{Invesre Quadratic}% __ONLY ONE__ keyword per line
\keyword{equivalence theorem}

