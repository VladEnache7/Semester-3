

N = input("N = ");
p = input("P = ");


U = rand(1, N);

X = (U < p);

U_X = [0 1];
n_X = hist(X, length(U_X))';
rel_freq = n_X/N
