USE AccountingCompanyDataBase

-- ohh, noo, Will Smith decided to resign from Tesla
DELETE Employees
WHERE CNP = 8190321908765 AND EmployeeName = 'Will Smith';


-- Meta decided to close his 2 account at Alpha Bank Romania
DELETE Companies_Banks
WHERE AccountNumber = 'RO24BUCHAROBU638617734002';

-- delete the offices that are not assinged to a company
DELETE Offices
WHERE CompanyCUI IS NULL;
	