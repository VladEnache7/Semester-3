#
clear
clc

# the introduction of Lab 1

A = [1 2 3; 4 5 6; 7 8 9];

x = 1:2:10;

A(1:2, 2:3);

A(1, 1);

x + 2;

3 * x;

x .^ 2;

B = [2 2 2; 3 3 3; 5 5 5];

A * B;

A .* B;

first_function(6);

# lab1_PS.pdf

A = [1 0 -2; 2 1 3; 0 1 0];
B = [2 1 1; 1 0 -1; 1 1 0];

printf("C = A - B\n");
C = A - B;

printf("D = A * B\n");
D = A * B;

printf("E = A .* B\n");
E = A .* B;

x = 0:0.01:2;

y1 = x .^ 5 / 10;
y2 = x .* sin(x);
y3 = cos(x);

figure;
hold on;
plot(x, y1, 'r', 'LineWidth', 2);
plot(x, y2, 'g', 'LineWidth', 2);
plot(x, y3, 'b', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title("First Plot");
legend("x .^ 5 / 10", "x .* sin(x)", "cos(x)");
hold off;

