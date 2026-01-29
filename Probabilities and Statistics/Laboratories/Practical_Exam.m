clear
pkg load statistics


A = [1021 980 1017 988 1005 998 1014 985 995 1004 1030 1015 995 1023 ];
B = [1070 970 993 1013 1006 1002 1014 997 1002 1010 975];

# -------------------- a) --------------------
printf("-------------------- a) --------------------\n\n")
alpha = 0.05;

% H0: (sigma1)^2 = (sigma2)^2
% H1: (sigma1)^2 != (sigma2)^2

std1 = std(A);
std2 = std(B);

m1 = mean(A);
m2 = mean(B);


var1 = var(A);
var2 = var(B);

n1 = length(A);
n2 = length(B);


[h, pval, ci, stat] = vartest2(A, B, "alpha", alpha, "tail", "both");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 0)
  printf("The null hypotesis IS NOT rejected \n\n");
  printf("The populations have EQUAL variances\n\n");
else
  printf("The null hypotesis IS rejected \n\n");
  printf("The populations have DIFFERENT variances\n\n");
endif

printf("The value of the statistic = %1.2f\n\n", stat.fstat)
printf("The p value = %1.2f\n\n", pval)
printf("The confidence interval is (%f, %f)\n\n", ci);

f1 = finv(alpha/2, n1 - 1, n2 - 1);
f2 = finv(1 - alpha/2, n1 - 1, n2 - 1);

printf("RR = (-inf, %4.3f) U (%4.3f, inf)\n\n", f1, f2)

# -------------------- b) --------------------
printf("-------------------- b) --------------------\n\n")

# based on a) that they have equal variances
# H0: miu1 = miu2 (also miu1 < miu2 -> Supplier A less reliable than B
# H1: miu1 > miu2 Suplier A more reliable than B

[h, pval, ci, stats] = ttest2(A, B, "alpha", alpha, "tail", "right");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 0)
  printf("The null hypotesis IS NOT rejected \n\n");
  printf("Supplier A less reliable than B\n\n");
else
  printf("The null hypotesis IS rejected \n\n");
  printf("Suplier A more reliable than B\n\n");
endif

printf("The value of the statistic = %1.2f\n\n", stats.tstat)
printf("The p value = %1.2f\n\n", pval)
printf("The confidence interval is (%f, %f)\n\n", ci);


printf("RR = (%4.3f, inf)\n\n", tinv(1 - alpha, n1 + n2 - 2))



