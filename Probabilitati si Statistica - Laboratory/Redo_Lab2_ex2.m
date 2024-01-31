clc
clear
pkg load statistics

%n = input("Give the number of trails: ");
n = 3;

%p = input("Give the probability of success (0,1): ");
p = 0.5

#----------------------- a) -----------------------
x = 0:1:n;% take all the posibilities of success
y = binopdf(x, n, p);
figure
plot(x, y, '>r', 'Linewidth', 1)
title("graph of binopdf")

printf("Tossing 3 times a coin is a Binomial Distribution because there are n trials with the same probability of success\n")


#----------------------- b) -----------------------
x = 0:0.001:n; % the only way to represent continous intervals
y = binocdf(x, n, p);
figure
plot(x, y, 'r', 'Linewidth', 2)
title("graph of binocdf")


#----------------------- c) -----------------------
printf("P(X = 0) = %f \n", binopdf(0, n, p))
printf("P(X != 1) = 1 - P(X = 1) %f \n", 1 - binopdf(1, n, p))

#----------------------- d) -----------------------
printf("P(X <= 2) = %f \n", binocdf(2, n, p))
printf("P(X < 2) = P(X <= 1) %f \n", binocdf(1, n, p))

#----------------------- e) -----------------------
printf("P(X >= 1) = 1 - P(X < 1) = 1 - P(X <= 0) = 1 - P(X = 0) = %f \n", 1 - binopdf(0, n, p))
printf("P(X > 1) = 1 - P(X <= 1) = %f \n", 1 - binocdf(1, n, p))

#----------------------- f) -----------------------
heads = 0
for i = 1:n
    if (rand() >= 0.5)
        heads = heads + 1
    endif
endfor

printf("P(X = %d) = %f\n", heads, binopdf(heads, n, p));
