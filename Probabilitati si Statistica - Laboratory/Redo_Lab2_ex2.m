clc
clear

#n = input("Give the number of trails: ");
n = 3;

#p = input("Give the probability of success [0,1]: ");
p = 0.5;


# ------------------------ a)

x = 0:1:n; # take all the possible cases

fx = binopdf(x, n, p);
figure;
plot(x, fx, 'r', 'LineWidth', 2);
title("Probability distribution function");
xlabel('x');
ylabel('y');

# --------------------------- b)

x2 = 0:0.001:n;

Fx = binocdf(x2, n, p);
figure;
plot(x2, Fx, 'r', 'LineWidth', 2);
title("Cumulative distribution function");
xlabel('x');
ylabel('y');

# --------------------------- c)

printf("P(X = 0) = %f\n", binopdf(0, n, p));
printf("P(X != 1) = 1 - P(X = 1) = %f\n", 1 - binopdf(1, n, p));

# --------------------------- d)

printf("P(X <= 2) = %f\n", binocdf(2, n, p));
printf("P(X < 2) = P(X <= 1) = %f\n", binocdf(1, n, p));

# --------------------------- e)

printf("P(X >= 1) = 1 - P(X < 1) = 1 - P(X <= 0) = %f\n", 1 - binocdf(0, n, p));
printf("P(X > 1) = 1 - P(X <= 1) = %f\n", 1 - binocdf(1, n, p));

# --------------------------- f)

heads = 0;

for k = 1 : n
  x = rand();
  if (x >= 0.5)
    heads = heads + 1;
  end
end

printf("P(X = %d) = %f\n", heads, binopdf(heads, n, p));
