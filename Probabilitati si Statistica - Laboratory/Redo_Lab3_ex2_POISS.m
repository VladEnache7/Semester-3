p = input("Enter p <= 0.05: ");
n = input("Enter n >= 30: ");

k = 0 : n;
plot(k, binopdf(k, n, p), k, poisspdf(k, n*p));

