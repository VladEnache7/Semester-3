option = input("Choose distribution from (normal, student, chi2, fisher): ", 's')

switch (option)
  case "normal"

    mu = input("Enter mean MU: ");
    sigma = input("Enter standard deviation SIGMA: ");

    % ---- a) ----
    pa1 = normcdf(0, mu, sigma);
    pa2 = 1 - pa1;

    % ---- b) ----
    pb1 = normcdf(1, mu, sigma) - normcdf(-1, mu, sigma);
    pb2 = 1 - pb1;

    % ---- c) ----
    alpha = input("Enter alpha(0,1): ")
    pc = norminv(alpha, mu, sigma);

    % ---- d) ----
    beta = input("Enter beta(0,1): ")
    pd = norminv(1 - beta, mu, sigma);


  case "student"

    df = input("Enter the degrees of freedom DF: ")
    % ---- a) ----
    pa1 = tcdf(0, df);
    pa2 = 1 - pa1;

    % ---- b) ----
    pb1 = tcdf(1, df) - tcdf(-1, df);
    pb2 = 1 - pb1;

    % ---- c) ----
    alpha = input("Enter alpha(0,1): ")
    pc = tinv(alpha, df);

    % ---- d) ----
    beta = input("Enter beta(0,1): ")
    pd = tinv(1 - beta, df);


  case "chi2"

    df = input("Enter the degrees of freedom DF: ")
    % ---- a) ----
    pa1 = chi2cdf(0, df);
    pa2 = 1 - pa1;

    % ---- b) ----
    pb1 = chi2cdf(1, df) - chi2cdf(-1, df);
    pb2 = 1 - pb1;

    % ---- c) ----
    alpha = input("Enter alpha(0,1): ")
    pc = chi2inv(alpha, df);

    % ---- d) ----
    beta = input("Enter beta(0,1): ")
    pd = chi2inv(1 - beta, df);

  case "fisher"

    df1 = input("Enter the degrees of freedom 1 DF1: ")
    df2 = input("Enter the degrees of freedom 2 DF2: ")
    % ---- a) ----
    pa1 = fcdf(0, df1, df2);
    pa2 = 1 - pa1;

    % ---- b) ----
    pb1 = fcdf(1, df1, df2) - fcdf(-1, df1, df2);
    pb2 = 1 - pb1;

    % ---- c) ----chi
    alpha = input("Enter alpha(0,1): ")
    pc = finv(alpha, df1, df2);

    % ---- d) ----
    beta = input("Enter beta(0,1): ")
    pd = finv(1 - beta, df1, df2);

  otherwise
    printf("Invalid option of distribution")

endswitch

printf("--> a)\n")
printf("P(X <= 0) = %5.4f\n", pa1)
printf("P(X >= 0) = 1 - P(X <= 0) = %5.4f\n\n", pa2)


printf("--> b)\n")
printf("P(−1 ≤ X ≤ 1) = P(X <= 1) - P(X <= -1) = %5.4f\n", pb1)
printf("P(X ≤ −1 or X ≥ 1) = 1 - P(−1 ≤ X ≤ 1) = %5.4f\n\n", pb2)


printf("--> c)\n")
printf("the value xα such that P(X < xα) = P(X ≤ xα) = α is %5.4f\n\n", pc)

printf("--> d)\n")
printf("the value xβ such that P(X > xβ) = P(X ≥ xβ) = β is %5.4f\n\n", pd)
