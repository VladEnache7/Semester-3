clear
pkg load statistics

x1 = [22.4 21.7 24.5 23.4 21.6 23.3 22.4 21.6 24.8 20.0];
x2 = [17.7 14.8 19.6 19.6 12.1 14.8 15.4 12.6 14.0 12.2];
n1 = length(x1);
n2 = length(x2);

conf_level  = input("Give the confidence level (0,1): ");

alpha = 1 - conf_level;

m1 = mean(x1);
m2 = mean(x2);
m = m1 - m2;
v1 = var(x1);
v2 = var(x2);

#------------------ a) sigma1 == sigma2 ------------------

sp = sqrt(((n1 - 1) * v1 + (n2 - 1) * v2) / (n1 + n2 - 2));

t1 = tinv(1 - alpha/2, n1 + n2 - 2);
t2 = tinv(alpha/2, n1 + n2 - 2); # or -t1

ci1 = m - t1 * sp * sqrt(1/n1 + 1/n2); # the left part of confidence interval
ci2 = m + t2 * sp * sqrt(1/n1 + 1/n2); # the right part

printf("The confidence interval for the difference of the true means when sigma1 = sigma2 is (%.3f, %.3f)\n", ci1, ci2)

#------------------ b) sigma1 != sigma2 ------------------

c = (v1 / n1) / (v1 / n1 + v2 / n2);
n = 1 / (c^2 / (n1-1) + (1-c)^2 / (n2-1));

t1 = tinv(1 - alpha/2, n);
t2 = - t1;

ci1 = m - t1 * sqrt(v1/n1 + v2/n2);
ci2 = m + t2 * sqrt(v1/n1 + 2/n2);

printf("The confidence interval for the difference of the true means when sigma1 != sigma2 is (%.3f, %.3f)\n", ci1, ci2)

#------------------ c) ------------------

f1 = finv(1 - alpha/2, n1 - 1, n2 - 1);
f2 = finv(alpha/2, n1 - 1, n2 - 1); # or -f1?

ci1 = (1 / f1) * (v1 / v2);
ci2 = (1 / f2) * (v1 / v2);

printf("confidence interval for the ratio of the variances is (%.3f, %.3f)\n", ci1, ci2)
printf("confidence interval for the ratio of the std. deviation is (%.3f, %.3f)\n", sqrt(ci1), sqrt(ci2))

