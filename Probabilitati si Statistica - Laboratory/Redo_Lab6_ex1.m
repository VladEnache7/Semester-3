clear
pkg load statistics

# the sample data
X = [7 7 4 5 9 9 ...
    4 12 8 1 8 7 ...
    3 13 2 1 17 7 ...
    12 5 6 2 1 13 ...
    14 10 2 4 9 11 ...
    3 5 12 6 10 7];
# the length of the data
n = length(X);

sigma = 5;
alpha = 0.05;

# -------------------- a) --------------------
miu = mean(X)
printf("------------------> a) <-------------------\n\n")

# the null hypothesis is H0: miu = 8.5 (It goes together with miu > 8.5 => the standard is met)
# the other hypothesis is H1: miu < 8.5 (the standard is not met)

printf("\nThis is a left tail test for the mean when sigma si known because the mean of the data is less than m0\n\n");

printf("--------------- At the 5 percent significance level---------------\n\n")

# the miu to be compared with
m0 = 8.5;

[h, pval, ci, zval] = ztest(X, m0, sigma, "alpha", alpha, "tail", "left");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 1)
  printf("The null hypotesis is rejected \n\n");
  printf("The standard is not met\n\n");
else
  printf("The null hypotesis is not rejected \n\n");
  printf("The standard is met\n\n");
endif


printf("The value of the test stat is zval = %.4f\n\n", zval);
printf("The confidence interval is (%f, %f)\n\n", ci);
printf("The pvalue of the test is %.4f\n\n", pval);

# the rejection region
RR = [-inf norminv(alpha)];

printf("The rejection region is RR = (%.4f, %.4f)\n\n", RR);

printf("--------------- At the 1 percent significance level---------------\n\n")

alpha = 0.01;

[h, pval, ci, zval] = ztest(X, m0, sigma, "alpha", alpha, "tail", "left");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 1)
  printf("The null hypotesis is rejected \n\n");
  printf("The standard is not met\n\n");
else
  printf("The null hypotesis is not rejected \n\n");
  printf("The standard is met\n\n");
endif

printf("The pvalue of the test is %.4f\n\n", pval);
printf("The confidence interval is (%f, %f)\n\n", ci);
printf("The value of the test stat is zval = %.4f\n\n", zval);

