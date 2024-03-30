clear
pkg load statistics

X = [7 7 4 5 9 9 ...
    4 12 8 1 8 7 ...
    3 13 2 1 17 7 ...
    12 5 6 2 1 13 ...
    14 10 2 4 9 11 ...
    3 5 12 6 10 7];
n = length(X);


printf("The average number of files stored is %.3f\n", mean(X));

conf_level  = input("Give the confidence level (0,1): ");

alpha = 1 - conf_level;

# sigma is given from the problem
sigma = 5;

#------------------------- a) -------------------------

# the left side of the interval where miu can take values
m1 =  mean(X) - sigma / sqrt(n) * norminv(1 - alpha / 2);
# the right side
m2 =  mean(X) - sigma / sqrt(n) * norminv(alpha / 2);

printf("The confidence interval for the theoretical mean assuming sigma = 5 is (%.3f, %.3f)\n", m1, m2);

#------------------------- b) -------------------------

# the left side of the interval where miu can take values
m1 =  mean(X) - std(X) / sqrt(n) * tinv(1 - alpha / 2, n - 1);
# the right side
m2 =  mean(X) - std(X) / sqrt(n) * tinv(alpha / 2, n - 1);

printf("The confidence interval for the theoretical mean when not sigma is not known is (%.3f, %.3f)\n", m1, m2);


#------------------------- c) -------------------------

var1 = ((n - 1) * std(X) ^ 2) / (chi2inv(1 - alpha / 2, n - 1));
var2 = ((n - 1) * std(X) ^ 2) / (chi2inv(alpha / 2, n - 1));

printf("The confidence interval for the theoretical variance is (%.3f, %.3f)\n", var1, var2);

sigma1 = sqrt(var1);
sigma2 = sqrt(var2);

printf("The confidence interval for the theoretical standard deviation is (%.3f, %.3f)\n", sigma1, sigma2);
