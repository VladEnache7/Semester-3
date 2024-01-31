
clear
pkg load statistics

N = input("Enter the number of simulations: ");
p = input("Enter the probability (0,1): ");

# generate n random numbers
U = rand(1, N);

# compare it with the probability and save 0 or 1
X = (U < p);

# how many were lower than p and how many greater
nX = hist(X, 2);

# the frequency relative to the number of trails
rel_freq = nX / N;

printf("The frequency of fail is %f and of success is %f\n", rel_freq)
