USE AccountingCompanyDataBase


--retrieves employees with a salary greater than 200k and who were employed after January 1, 2023.
-- that meens they were with much experience
SELECT * FROM Employees
WHERE (Salary > 200000) AND (EmploymentDate >= '2023-01-01')

-- retrive the average salaries of the employees that stay in Iasi or Brasov or Sibiu
SELECT AVG(Salary)
FROM Employees
WHERE (Employee_Address LIKE '%Iasi%') OR (Employee_Address LIKE '%Brasov%') OR (Employee_Address LIKE '%Sibiu%') 

-- retrive all the distinct cities of the offices
SELECT DISTINCT City 
FROM Offices

-- retrive all distincts TVA
SELECT DISTINCT VATRate
FROM Services_Products