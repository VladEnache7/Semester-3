
clc # Clear the terminal screen and move the cursor to the upper left corner.
clear # Delete the names s from the symbol table.


A = [1 0 -2; 2 1 3; 0 1 0];
B = [2 1 1; 1 0 -1; 1 1 0];


printf("C = A - B\n")
C = A - B

printf("D = A * B\n")
D = A * B

printf("E = A .* B (dot product)\n")
E = A .* B
