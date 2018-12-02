findruns <- function(x, k){
  n <- length(x)
  runs <- NULL
  for(i in 1:(n - k)) {
    if(i == 8) browser()
    if(all(x[i:(i+k-1)] == 1)) runs <- c(runs, i)
  }
  return(runs)
}
