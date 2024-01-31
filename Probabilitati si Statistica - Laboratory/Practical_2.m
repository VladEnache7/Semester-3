clear
pkg load statistics

sheels = [1001.7 975.0 978.3 988.3 978.7 988.9 1000.3 979.2 968.9 983.5 999.2 985.6];
n = length(sheels);

alpha = 0.05;
# -------------------- a) --------------------
printf("-------------------- a) --------------------\n\n")
# H0: miu = 995 (miu > 995 the muzzles are faster than 995 m/s)
# H1: miu < 995  muzzles are NOT faster than 995 m/s

# sigma is unknown => ttest
miu = mean(sheels)

[h, pval, ci, stats] = ttest(sheels, 995, "alpha", alpha, "tail", "left");

printf("The value of the hypothesis is h = %d\n\n", h)
if (h == 0)
  printf("The null hypotesis IS NOT rejected \n\n");
  printf("The muzzles are faster than 995 m/s\n\n");
else
  printf("The null hypotesis IS rejected \n\n");
  printf("The muzzles are NOT faster than 995 m/s\n\n");
endif


printf("The value of the test stat is = %.4f\n\n", stats.tstat);
printf("The confidence interval is (%f, %f)\n\n", ci);
printf("The pvalue of the test is %.4f\n\n", pval);



# the rejection region
RR = [-inf tinv(alpha, n - 1)];
printf("The rejection region is RR = (%.4f, %.4f)\n\n", RR);

# -------------------- b) --------------------
printf("-------------------- b) --------------------\n\n")

conf_inter = 0.99;
alpha = 1 - conf_inter;

v1 = var(sheels);

var1 = ((n - 1) * v1) / (chi2inv(1 - alpha / 2, n - 1));
var2 = ((n - 1) * v1) / (chi2inv(alpha / 2, n - 1));

sigma1 = sqrt(var1);
sigma2 = sqrt(var2);

printf("The confidence interval for the standard deviation is (%.3f, %.3f)\n", sigma1, sigma2);
