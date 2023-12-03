pkg load statistics

printf("Lab3_ex2.m")

p = input("Give probability between 5% and 95%: ");

for n = 1:3:100
  x = 0 : n;
  y = binopdf(x, n, p);
  plot(x, y)
  pause(0.5)
endfor
