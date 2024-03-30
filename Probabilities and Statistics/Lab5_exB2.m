clear


XP = [22.4 21.7 24.5 23.4 21.6 23.3 22.4 21.6 24.8 20.0];

XR = [17.7 14.8 19.6 19.6 12.1 14.8 15.4 12.6 14.0 12.2];

n1 = length(XP);
n2 = length(XR);

oneMinusAlpha = input("Give the confidence level (0,1): ");

alpha = 1 - oneMinusAlpha;

sp = sqrt(((n1-1) * var(XP) + (n2 - 1) * var(XR)) / (n1 + n2 - 2))

m1 = mean(XP) - mean(XR) - tinv(1-alpha/2, n1 + n2 - 2) * sp * sqrt(1/n1 + 1/n2)
m2 = mean(XP) - mean(XR) + tinv(alpha/2, n1 + n2 - 2) * sp * sqrt(1/n1 + 1/n2)

printf("The confidence interval for difference between theoretical means when sigma1 = sigma2 is (%4.3f, %4.3f)\n", m1, m2)
