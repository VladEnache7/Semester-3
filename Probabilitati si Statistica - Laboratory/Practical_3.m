clear
pkg load statistics

nickel = [3.26 1.89 2.42 2.03 3.07 2.95 1.39 3.06 2.46 3.35 1.56 1.79 1.76 3.82 2.42 2.96];

n = length(nickel)

conf_inter = 0.95
alpha = 1 - conf_inter

# -------------------- a) --------------------
printf("-------------------- a) --------------------\n\n")
# the left side of the interval where miu can take values
m1 =  mean(nickel) - std(nickel) / sqrt(n) * tinv(1 - alpha / 2, n - 1);
# the right side
m2 =  mean(nickel) - std(nickel) / sqrt(n) * tinv(alpha / 2, n - 1);

printf("The confidence interval for the theoretical mean when not sigma unknown is (%.3f, %.3f)\n", m1, m2);


# -------------------- b) --------------------
printf("-------------------- b) --------------------\n\n")

alpha = 0.01

m0 = 3;
miu = mean(X)

# the null hypothesis is H0: miu = 3 (It goes together with miu < 3 => the average is smaller than 3)
# the other hypothesis is H1: miu > 3 (the average exceed 3)


[h, pval, ci, stats] = ttest(X, m0, "alpha", alpha, "tail", "right");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 0)
  printf("The null hypotesis IS NOT rejected \n\n");
  printf("data suggests that the average smaller than 3\n\n");
else
  printf("The null hypotesis IS rejected \n\n");
  printf("Data suggests that the  average not smaller than 3\n\n");
endif


printf("The value of the test stat is = %.4f\n\n", stats.tstat);
printf("The confidence interval is (%f, %f)\n\n", ci);
printf("The pvalue of the test is %.4f\n\n", pval);



# the rejection region
RR = [tinv(1 - alpha, n - 1) inf];

printf("The rejection region is RR = (%.4f, %.4f)\n\n", RR);
