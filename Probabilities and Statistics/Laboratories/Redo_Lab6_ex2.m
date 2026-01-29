clear

# -------------------- a) --------------------

% H0: (sigma1)^2 = (sigma2)^2
% H1: (sigma1)^2 != (sigma2)^2

premium = [22.4, 21.7, 24.5, 23.4, 21.6, 23.3, 22.4, 21.6, 24.8, 20.0];
regular = [17.7, 14.8, 19.6, 19.6, 12.1, 14.8, 15.4, 12.6, 14.0, 12.2];

n1 = length(premium);
n2 = length(regular);
alpha = 0.05;

[h, pval, ci, stat] = vartest2(premium, regular, "alpha", alpha, "tail", "both");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 1)
  printf("The null hypotesis IS rejected \n\n");
  printf("The datas have different variances\n\n");
else
  printf("The null hypotesis IS NOT rejected \n\n");
  printf("The datas have the same variances\n\n");
endif

printf("The value of the statistic = %1.2f\n\n", stat.fstat)
printf("The p value = %1.2f\n\n", pval)
printf("The confidence interval is (%f, %f)\n\n", ci);

f1 = finv(alpha/2, n1 - 1, n2 - 1);
f2 = finv(1 - alpha/2, n1 - 1, n2 - 1);

printf("RR = (-inf, %1.2f) U (%1.2f, inf)\n\n", f1, f2)

# -------------------- b) -------------------- based on the fact that Premium & Regular have the same variances

# H0: miu1 = miu2 (also miu1 < miu2 -> gas mileage DOES NOT seem to be higher, on average, when premium gasoline is used
# H1: miu1 > miu2 gas mileage seem to be higher, on average, when premium gasoline is used

[h, pval, ci, stats] = ttest2(premium, regular, "alpha", alpha, "tail", "right");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 1)
  printf("The null hypotesis IS rejected \n\n");
  printf("The gas mileage seem to be higher, on average, when premium gasoline is used\n\n");
else
  printf("The null hypotesis IS NOT rejected \n\n");
  printf("The gas mileage DOES NOT seem to be higher, on average, when premium gasoline is used\n\n");
endif

printf("The value of the statistic = %1.2f\n\n", stats.tstat)
printf("The p value = %1.2f\n\n", pval)
printf("The confidence interval is (%f, %f)\n\n", ci);


printf("RR = (%1.2f, inf)\n\n", tinv(1 - alpha, n1 + n2 - 2))


