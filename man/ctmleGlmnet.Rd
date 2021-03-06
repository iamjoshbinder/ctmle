% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ctmle_glmnet.R
\name{ctmleGlmnet}
\alias{ctmleGlmnet}
\title{Collaborative Targeted Maximum Likelihood Estimation for hyper-parameter tuning of LASSO}
\usage{
ctmleGlmnet(Y, A, W, Wg = W, Q, lambdas = NULL, ctmletype, V = 5,
  folds = NULL, alpha = 0.995, family = "gaussian", gbound = 0.025,
  like_type = "RSS", fluctuation = "logistic", verbose = FALSE,
  detailed = FALSE, PEN = FALSE, g1W = NULL, g1WPrev = NULL,
  stopFactor = 10^6)
}
\arguments{
\item{Y}{continuous or binary outcome variable}

\item{A}{binary treatment indicator, 1 for treatment, 0 for control}

\item{W}{vector, matrix, or dataframe containing baseline covariates for Q bar}

\item{Wg}{vector, matrix, or dataframe containing baseline covariates for propensity score model (defaults to W if not supplied by user)}

\item{Q}{n by 2 matrix of initial values for Q0W, Q1W in columns 1 and 2, respectively. Current version does not support SL for automatic initial estimation of Q bar}

\item{lambdas}{numeric vector of lambdas (regularization parameter) for glmnet estimation of propensity score, with decreasing order. We recommend the
first lambda is selected by external cross-validation.}

\item{ctmletype}{1, 2 or 3. Type of general C-TMLE. Type 1 uses cross-validation to select best gn, Type 3 directly solves extra clever covariates,
and Type 2 uses both cross-validation and extra covariate. See more details in !!!}

\item{V}{Number of folds. Only used if folds is not specified}

\item{folds}{The list of indices for cross-validation step. We recommend the cv-splits in C-TMLE matchs that in gn_candidate_cv}

\item{alpha}{used to keep predicted initial values bounded away from (0,1) for logistic fluctuation, 0.995 (default)}

\item{family}{family specification for working regression models,
generally 'gaussian' for continuous outcomes (default), 'binomial' for binary outcomes}

\item{gbound}{bound on P(A=1|W), defaults to 0.025}

\item{like_type}{'RSS' or 'loglike'. The metric to use for forward selection and cross-validation}

\item{fluctuation}{'logistic' (default) or 'linear', for targeting step}

\item{verbose}{print status messages if TRUE}

\item{detailed}{boolean number. If it is TRUE, return more detailed results}

\item{PEN}{boolean. If true, penalized loss is used in cross-validation step}

\item{g1W}{Only used when type is 3. a user-supplied propensity score estimate.}

\item{g1WPrev}{Only used when type is 3. a user-supplied propensity score estimate, with small fluctuation compared to g1W.}

\item{stopFactor}{Numerical value with default 1e6. If the current empirical likelihood is stopFactor times larger than the best previous one, the construction would stop}
}
\value{
best_k  the index of estimate that selected by cross-validation

est estimate of psi_0

CI  IC-based 95% confidence interval for parameter estimate

pvalue pvalue for the null hypothesis that Psi = 0

likelihood sum of squared residuals, based on selected estimator evaluated on all obs or,
 logistic loglikelihood if like_type != 'RSS'

varIC empirical variance of the influence curve adjusted for estimation of g

varDstar empirical variance of the influence curve

var.psi variance of the estimate

varIC.cv cross-validated variance of the influence curve

penlikelihood.cv penalized cross-validatedlikelihood

cv.res all cross-validation results for each fold
}
\description{
This function computes the Collaborative Maximum Likelihood Estimation for hyper-parameter tuning of LASSO.
}
