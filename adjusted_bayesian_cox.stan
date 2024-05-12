data {
    int<lower=1> N_uncensored;                                      
    int<lower=1> N_censored;                                        
    vector[N_censored] X_censored;                               
    vector[N_uncensored] X_uncensored;                           
    vector[N_censored] times_censored;                          
    vector[N_uncensored] times_uncensored;                      
}

parameters {
  real beta_treatment;
  real eta;
}

model {
  beta_treatment ~ normal(0,10);
  eta ~ normal(0, 10);
  
  target += exponential_lpdf(times_uncensored | exp(eta+X_uncensored*beta_treatment)); 
  target += exponential_lccdf(times_censored | exp(eta+X_censored*beta_treatment));  
}
