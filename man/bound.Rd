% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bound.R
\name{bound}
\alias{bound}
\title{set outliers to min/max allowable values. It assumes x contains only numerical data}
\usage{
bound(x, bounds)
}
\arguments{
\item{x}{input data}

\item{bounds}{a vector with length 2, contains the min and max of the bound}
}
\value{
x truncated input x by min/max in bounds
}
\description{
set outliers to min/max allowable values. It assumes x contains only numerical data
}
