
clc
clear

x = 0:0.1:2;

y1 = (x .^ 5) / 10;

y2 = x .* sin(x);

y3 = cos(x);

hold on;
#figure; # Create a new figure window for plotting.
plot(x, y1, 'r', 'LineWidth', 2);
#figure;
plot(x, y2, 'b', 'LineWidth', 2);
#figure;
plot(x, y3, 'g', 'LineWidth', 2);
hold off;

title("3 funtions graph");
legend("(x ^ 5) / 10", "x * sin(x)", "cos(x)");

