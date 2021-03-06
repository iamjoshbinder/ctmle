#' print the summary of a ctmle object
#' @param x a summary.ctmle object
#' @param ... other parameter
#' @export
print.summary.ctmle <- function(x, ...){
      if(identical(class(x), "summary.ctmle")){
            if(!is.null(x$d)){
                  npercovar <- table(x$covar[1:x$ncand])
                  suffix <- paste(x$covar[1:x$ncand], letters[unlist(apply(npercovar, 1,function(x){1:x}))], sep="")
                  suffix[cumsum(npercovar)[npercovar==1]] <- names(cumsum(npercovar)[npercovar==1])
                  prev_covar <-suffix[cumsum(npercovar[-length(npercovar)])]
                  prev_moves <- c(paste(" + epsilon", prev_covar, " * h", prev_covar, sep=""),"")
                  current_move <- paste(" + epsilon", suffix, " * h", suffix,sep="")
                  TMLEcand <- paste("\tcand ", 1:x$ncand,": Q",1:x$ncand,"(A,W) =", sep="")
                  fluctuations <- paste("Q0(A,W)", c(rep("", npercovar[1]),
                                                     mapply(function(x){paste(prev_moves[1:(x-1)],collapse="")},x$covar[-(1:npercovar[1])])),
                                        current_move, sep="")
                  final_update <- c(rep("\n", npercovar[1]), paste("\t                = Q",
                                                                   rep(cumsum(npercovar[-length(npercovar)]), times=npercovar[-1]),"(A,W)",
                                                                   current_move[(npercovar[1]+1) : x$ncand],",\n", sep=""))
                  tx <- c("\t\t\th1a is based on an intercept-only model for treatment mechanism g(A,W)\n\n",
                          paste("\t\t\th", suffix[-1],
                                " is based on a treatment mechanism model containing covariates ",
                                mapply(function(x1){paste(x$terms[1:x1], collapse=", ")}, 1:(x$ncand-1)), "\n\n", sep=""))
                  cat("\nNumber of candidate TMLE estimators created: ", x$ncand, "\n")
                  cat("A candidate TMLE estimator was created at each move, as each new term\nwas incorporated into the model for g.\n")
                  cat(paste(rep("-",70), collapse=""), "\n")
                  print(x$d, digits=3)
                  cat(paste(rep("-",70), collapse=""), "\n")
                  cat("Selected TMLE estimator is candidate", x$selected,"\n\n")
                  cat("Each TMLE candidate was created by fluctuating the initial fit, Q0(A,W)=E[Y|A,W], obtained in stage 1.\n\n")
                  cat(paste(TMLEcand, fluctuations, final_update, tx))
            }
            cat(paste(rep("-",10), collapse=""), "\n")
            cat("C-TMLE result:\n")
            cat("\tparameter estimate: ", round(x$est,5), "\n")
            cat("\testimated variance: ", round(x$var,5), "\n")
            cat("\t           p-value: ",  ifelse(x$pvalue <= 2*10^-16, "<2e-16",signif(x$pvalue,5)), "\n")
            cat("\t 95% conf interval:", paste("(", round(x$CI[1],5), ", ", round(x$CI[2],5), ")", sep=""),"\n")
      }
}

