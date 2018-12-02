#' Function to find sequences of \code{k} consecutives 1s
#'
#' Allows you to find to find sequences of \code{k} consecutives 1s in a vector
#' 
#' @param x Vector of 0s and 1s
#' @param k Number. Number of desired consecutives 1s
#' @return Vector indicating where the sequences start
#' @export
#' @examples
#' y <- c(1, 0, 0, 1, 1, 1, 0, 1, 1)
#' findruns(y, 2)
#' findruns(y, 3)
findruns <- function(x, k){
  n <- length(x)
  runs <- NULL
  for(i in 1:(n - k + 1)) {
    if(all(x[i:(i+k-1)] == 1)) runs <- c(runs, i)
  }
  return(runs)
}