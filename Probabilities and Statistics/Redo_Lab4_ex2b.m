clear
pkg load statistics

% simulate Bino(n,p) random var
n = input('Number of trials = ');
p = input('Probability of success in (0,1) = ');

# ask for how many simulations of Bino(n, p)
N = input('Number of simulation = ');


# generate n random numbers
U = rand(n, N);

# count how many where successes
X = sum(U < p);

# save the unique values in order to plot them
UX = unique(X);

# count the frequency of all different answers
nX = hist(X, length(UX));

# compute the relative frequency of each different result
relfr = nX / N;

# take each values as a posibility
k = 0:n;
pk = binopdf(k, n, p);

plot(k, pk, 'g*', UX, relfr, 'ro')
legend('Bino distribution','Simulation')
