
clear
pkg load statistics

X = [20 20 21 22 22 22 23 23 23 23 23 23 24 24 24 24 24 25 25 25 25 25 25 25 25 25 26 26 27 27];
Y = [75 75 75 76 76 77 77 78 78 78 78 78 79 79 79 79 79 79 79 79 80 80 80 80 80 80 80 80 81 82];
n = length(X);
m = length(Y);

UX = unique(X);
UY = unique(Y);

nX = hist(X, length(UX));
nY = hist(Y, length(UY));

Xbar = mean(X);
Ybar = mean(Y);

printf("The mean(X) = %.4f, mean(Y) = %f\n", Xbar, Ybar)

varX = var(X);
varY = var(Y);

printf("The var(X) = %f, vat(Y) = %f\n", varX, varY)

covXY = cov(X, Y);
printf("The the covariance cov(X, Y ) = %f\n", covXY)

corrcoefXY = corrcoef(X, Y);
printf("the correlation coefficient ρXY = %2f\n", corrcoefXY)
