clear
pkg load statistics

# -------------------- a) --------------------
printf("-------------------- a) --------------------\n\n")
% H0: (sigma1)^2 = (sigma2)^2
% H1: (sigma1)^2 != (sigma2)^2



standard = [46 37 39 48 47 44 35 31 44 37];
new = [35 33 31 35 34 30 27 32 31 31];

std1 = std(standard);
std2 = std(new);

var1 = var(standard)
var2 = var(new)

n1 = length(standard);
n2 = length(new);
alpha = 0.05;

[h, pval, ci, stat] = vartest2(standard, new, "alpha", alpha, "tail", "both");

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
printf("RR = (-inf, %1.2f) U (%1.2f, inf)\n\n", f1, f2)


# -------------------- b) -------------------- based on the fact that datas have DIFFERENT variances
printf("-------------------- b) --------------------\n\n")
conf_level = 0.95;
alpha = 1 - conf_level;

m1 = mean(standard);
m2 = mean(new);
m = m1 - m2;
v1 = var(standard);
v2 = var(new);

c = (v1 / n1) / (v1 / n1 + v2 / n2);
n = 1 / (c^2 / (n1-1) + (1-c)^2 / (n2-1));

t1 = tinv(1 - alpha/2, n);

ci1 = m - t1 * sqrt(v1/n1 + v2/n2);
ci2 = m + t1 * sqrt(v1/n1 + 2/n2);

printf("The confidence interval for the difference of the true means when sigma1 != sigma2 is (%.3f, %.3f)\n", ci1, ci2)



