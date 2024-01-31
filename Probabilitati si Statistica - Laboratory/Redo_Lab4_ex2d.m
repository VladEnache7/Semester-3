clear

p = input("Enter probability of success for Pascal Distribution: ");
N = input("Nr of simulations: ");
n = input("Nr of succeces: ");

for i = 1:N
  for j = 1:n
    X(j) = 0;
    while rand >= p
      X(j) = X(j) + 1;
    endwhile
    Y(i) = sum(X);
  endfor
end

UY = unique(Y);

nY = hist(Y, length(UY));

k = 0:150;
pk = nbinpdf(k, n, p);
plot(k, pk, '*', UY, nY/N, "o")
