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


# -------------------- b) --------------------
printf("------------------> b) <-------------------\n\n")
m0 = 5.5;
miu = mean(X)

# the null hypothesis is H0: miu = 5.5 (It goes together with miu < 5.5 => the average does not exceed 5.5)
# the other hypothesis is H1: miu > 5.5 (the average exceed 5.5)

alpha = 0.05;
tail = 1; # because is right tailed test

[h, pval, ci, stats] = ttest(X, m0, "alpha", alpha, "tail", "right");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 1)
  printf("The null hypotesis IS rejected \n\n");
  printf("Data suggests that the  average exceeds 5.5\n\n");
else
  printf("The null hypotesis IS NOT rejected \n\n");
  printf("data suggests that the average DOES NOT exceeds 5.5\n\n");
endif


printf("The value of the test stat is = %.4f\n\n", stats.tstat);
printf("The confidence interval is (%f, %f)\n\n", ci);
printf("The pvalue of the test is %.4f\n\n", pval);



# the rejection region
RR = [tinv(1 - alpha, n - 1) inf];
talpha = tinv(alpha, n - 1)
printf("The rejection region is RR = (%.4f, %.4f)\n\n", RR);

