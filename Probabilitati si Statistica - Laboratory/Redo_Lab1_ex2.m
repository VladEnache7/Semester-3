
clc
clear

x = 0:0.1:3;

y1 = (x .^ 5) / 10;

y2 = (x .* sin(x));

y3 = cos(x);

figure

subplot(1, 3, 1)
plot(x, y1, 'r', 'LineWidth', 2)

subplot(1, 3, 2)
plot(x, y2, 'b', 'LineWidth', 2)
subplot(1, 3, 3)
plot(x, y3, 'g', 'LineWidth', 2)

title("3 funtions graph")
legend("(x .^ 5) / 10", "(x .* sin(x))", "cos(x)")


figure
subplot(1, 4, 1)
plot(x, x.*sin(x), 'm', 'LineWidth', 2, x, x.^5/100, 'b', 'LineWidth', 2, x, cos(x), 'r', 'LineWidth', 2)
xlabel("x -> ")
ylabel("y -> ")
legend("x*sine", "weird function", "cosine")

subplot(1, 4,2)
fplot("[x*sin(x)]", [0, 3], 'LineWidth', 2)
subplot(1, 4,3)
fplot("[x^5/100]", [0, 3], 'LineWidth', 2)
subplot(1, 4,4)
fplot("[cos(x)]", [0, 3], 'LineWidth', 2)
