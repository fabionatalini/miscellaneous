# The significance of a correlation coefficient, r, is determined by converting it to a t-statistic 
# and then finding the significance of that t-value at the degrees of freedom that correspond to the sample size, n;
# so, you can use R to find the critical t-value 
# and then convert that value back to a correlation coefficient to find the critical correlation coefficient.
critical.r <- function( n, alpha = .05 ) {
  df <- n - 2
  # two-tailed
  critical.t <- qt(p=alpha/2, df=df, lower.tail = F)
  # convert back the test statistic
  # (r*sqrt(n-2)) / sqrt(1-(r^2)) where r is the sample correlation coef
  critical.r <- sqrt( (critical.t^2) / ( (critical.t^2) + df ) )
  return(critical.r)
}
# Example usage: Critical correlation coefficient at sample size of n = 100
critical.r( 100 )
