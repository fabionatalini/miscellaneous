################## computing probabilities with binomial distribution #################
#Launch a coin n=10 times,
#and compute the probability of getting "head" k times
#(where k is 0,1,2,3,4,...,n)
n <- 10
p <- 0.5

for(k in 0:n){
  print( (choose(n,k)) * (p^k) * ((1-p)^(n-k)) )
} #choose computes the binomial coefficient

for(k in 0:n){
  print( dbinom(x=k, size=10, prob=0.5) )
}

#If we flip a fair coin 10 times,
#what is the probability of getting exactly 5 heads?
k <- 5
(choose(n,k)) * (p^k) * ((1-p)^(n-k))
dbinom(x=k, size=10, prob=0.5)

################## generate random numbers from a binomial distribution #################
#We run 125 tests every day,
#and the known probability of getting a wrong result (error rate) is 5%
#Compute the expected number of wrong tests per day for a week (7 days):
set.seed(123)
rbinom(n=7, size=125, prob=0.05)
# 5  8  6  9 10  2  6
