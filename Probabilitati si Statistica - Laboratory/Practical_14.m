clear
pkg load statistics

steel = [4.6 0.7 4.2 1.9 4.8 6.1 4.7 5.5 5.4];
glass = [2.5 1.3 2.0 1.8 2.7 3.2 3.0 3.5 3.5];

n1 = length(steel);
n2 = length(glass);
alpha = 0.05
# -------------------- a) --------------------
printf("-------------------- a) --------------------\n\n")
% H0: (sigma1)^2 = (sigma2)^2
% H1: (sigma1)^2 != (sigma2)^2


[h, pval, ci, stat] = vartest2(steel, glass, "alpha", alpha, "tail", "both");


printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 1)
  printf("The null hypotesis IS rejected \n\n");
  printf("The datas have DIFFERENT variances\n\n");
else
  printf("The null hypotesis IS NOT rejected \n\n");
  printf("The datas have EQUAL variances\n\n");
endif

printf("The value of the statistic = %1.2f\n\n", stat.fstat)
printf("The p value = %1.2f\n\n", pval)
printf("The confidence interval is (%f, %f)\n\n", ci);

f1 = finv(alpha/2, n1 - 1, n2 - 1);
f2 = finv(1 - alpha/2, n1 - 1, n2 - 1);

printf("RR = (-inf, %1.2f) U (%1.2f, inf)\n\n", f1, f2)

# -------------------- b) -------------------- based on the fact that datas have DIFFERENT variances
printf("-------------------- b) --------------------\n\n")
miu1 = mean(steel)
miu2 = mean(glass)

# H0: miu1 = miu2 (also miu1 > miu2 -> steel pipes seem to lose, on average, more heat than glass pipes
# H1: miu1 < miu2 steel pipes seem to NOT lose, on average, more heat than glass pipes



[h, pval, ci, stats] = ttest2(steel, glass, "alpha", alpha, "tail", "left");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 0)
  printf("The null hypotesis IS NOT rejected \n\n");
  printf("Steel pipes seem to DO lose, on average, more heat than glass pipes\n\n");
else
  printf("The null hypotesis IS rejected \n\n");
  printf("Steel pipes seem to NOT lose, on average, more heat than glass pipes\n\n");

endif

printf("The value of the statistic = %1.2f\n\n", stats.tstat)
printf("The p value = %1.2f\n\n", pval)
printf("The confidence interval is (%f, %f)\n\n", ci);

v1 = var(steel);
v2 = var(glass);

c = (v1 / n1) / (v1 / n1 + v2 / n2);
n = 1 / (c^2 / (n1-1) + (1-c)^2 / (n2-1));

printf("RR = (%1.2f, inf)\n\n", tinv(1 - alpha, n))

