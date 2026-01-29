clc
clear

alpha = input("Enter the significance level (0..1):");

X = [7 7 4 5 9 9 ...
      4 12 8 1 8 7 ...
      3 13 2 1 17 7 ...
      12 5 6 2 1 13 ...
      14 10 2 4 9 11 ...
      3 5 12 6 10 7];

n = length(X);

# the null hypotesis is H0: miu = 8.5 (It goes together with miu > 8.5, the standard is met)
# The alternative hypotesis H1: miu < 8.5 (standard is not met)
# this is a left tail test for miu <

printf("This is a left tail test for the mean when sigma si known\n");
sigma = 5;
m0 = 8.5;

[h, p, ci, zval] = ztest(X, m0, sigma, "alpha", alpha, "tail", "left")

z = norminv(alpha, 0, 1);

RR = [-inf z];

printf("The value of h = %d\n", h);
if (h == 1)
  printf("The null hypotesis is rejected\n");
  printf("The standard is not met\n");
else
  printf("The null hypotesis is not rejected\n");
  printf("The standard is met\n");
endif

printf("The rejection region is (%4.4f, %4.4f)\n", RR);
printf("The value of the test stat is %4.4f\n", zval);
printf("The pvalue of the test is %4.4f\n", p);

# hints 1b) ttest stats.tstat
# 2a) vartest2


