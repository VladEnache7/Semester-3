
clear
clc
# solving ex. 2
n = input("Give nb. of trails n = "); # n = natural number
p = input("Give the prob. of succes p(0..1) = "); # p is between o and 1

x = 0:1:n; # nr of successes in n trails

px = binopdf(x, n, p);

plot(x, px, '*r', 'LineWidth', 2)

hold on # with this it represents both plots in one window

xx = 0:0.01:n; # because cdf should be continous and we cannot represents continous points in computers
cx = binocdf(xx, n, p);

plot(xx, cx, 'g', 'LineWidth', 2)

legend("pdf", "cdf");
