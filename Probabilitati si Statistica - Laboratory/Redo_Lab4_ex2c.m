clear
pkg load statistics

p = input("Enter the probability of success for Geometric Distribution: ");
N = input("Nr of simulations: ")

for i = 1:N
  X(i) = 0;
  while rand >= p
    X(i) = X(i) + 1; # count the number of failures before the first success
  endwhile
end

UX = unique(X);

nX = hist(X, length(UX));

relfr = nX / N;

k = 0:20;

# the probability of k failures before success
pk = geopdf(k, p);

plot(k, pk, '*', UX, relfr, 'o')
legend("Geometric Distribution", "Simulation")
