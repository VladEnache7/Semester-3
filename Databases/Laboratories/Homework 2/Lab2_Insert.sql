-- insert data – for at least 4 tables; at least one statement must violate referential integrity constraints;
-- DONE - inserted data in all tables

USE AccountingCompanyDataBaseV2

INSERT INTO Banks (SWIFTCode, BankName, BankCity) VALUES
('RNCBROBU', 'BCR - Banca Comerciala Romana', 'Bucharest'),
('INGBROBU', 'ING Bank Romania', 'Bucharest'),
('BTRLRO22', 'Banca Transilvania', 'Cluj-Napoca'),
('CECEROBU', 'CEC Bank', 'Bucharest'),
('OTPROBU', 'OTP Bank', 'București, România'),
('BACXROBU', 'UniCredit Bank', 'București, România'),
('BUCHAROBU', 'Alpha Bank România', 'București, România'),
('PIRBROBU', 'Piraeus Bank România', 'București, România'),
('BRDEROBU', 'BRD - Groupe Société Générale', 'București, România'),
('BRELROBU', ' LIBRA BANK S.A.', 'București, România');

SELECT * 
FROM Banks;

INSERT INTO Partners_Companies (CompanyCUI, Company_Name, Phone, BusinessRegNumber, InternalCode) VALUES
(713527112, 'Hyundai', '1-800-WALMART', 711879, 1),
(971793834, 'Amazon', '1-206-266-1000', 606424, 2),
(660416356, 'Apple', '1-408-996-1010', 3193271, 3),
(658165878, 'Microsoft', '1-425-882-8080', 3145644, 4),
(953547190, 'Tesla', '1-650-253-0000', 61865165, 5),
(914489309, 'OMV Petrom', '1-700-988-0000', 441887806, 6),
(638617734, 'Meta', '1-650-543-4800', 35382473, 7),
(400420023, 'Samsung', '1-800-SAMSUNG', 40042000, 8),
(911981145, 'Huawei', '1-866-482-8355', 91448931, 9),
(914562834, 'Enel Romania', '1-866-888-8288', 91198109, 10),
(382013924, 'Auchan', '1-402-446-1400', 47271916, 11),
(303896834, 'Johnson & Johnson', '1-732-524-0400', 30389687, 12),
(657560145, 'Lidl', '1-800-668-6814', 65756013, 13),
(638644872, 'Metro', '1-800-VISA-999', 63864484, 14),
(638617485, 'Revolut', '1-800-MC-ASSIST', 63861774, 15),
(114266534, 'EMAG', '1-888-221-1161', 11426651, 16),
(911978779, 'Nike', '1-800-344-6453', 91197871, 17),
(382013934, 'Brother Printers', '1-404-676-2121', 38201394, 18),
(313938069, 'Altex', '1-914-253-2000', 31393803, 19),
(133785134, 'NVidia', '1-800-688-5643', 13378510, 20);


SELECT * 
FROM Partners_Companies;


INSERT INTO Companies_Banks VALUES
('RO09RNCBROBU713527112001', 713527112, 'RNCBROBU'),
('RO76INGBROBU971793834001', 971793834, 'INGBROBU'),
('RO33BTRLRO22660416356001', 660416356, 'BTRLRO22'),
('RO77CECEROBU658165878001', 658165878, 'CECEROBU'),
('RO64OTPROBU953547190001', 953547190, 'OTPROBU'),
('RO82BACXROBU914489309001', 914489309, 'BACXROBU'),
('RO20BUCHAROBU638617734001', 638617734, 'BUCHAROBU'),
('RO79PIRBROBU911981145001', 911981145, 'PIRBROBU'),
('RO50BRDEROBU914562834001', 914562834, 'BRDEROBU'),
('RO73BRELROBU638617485001', 638617485, 'BRELROBU'),
('RO52RNCBROBU713527112002', 713527112, 'RNCBROBU'),
('RO84INGBROBU971793834002', 971793834, 'INGBROBU'),
('RO59BTRLRO22660416356002', 660416356, 'BTRLRO22'),
('RO87CECEROBU658165878002', 658165878, 'CECEROBU'),
('RO68OTPROBU953547190002', 953547190, 'OTPROBU'),
('RO86BACXROBU914489309002', 914489309, 'BACXROBU'),
('RO24BUCHAROBU638617734002', 638617734, 'BUCHAROBU'),
('RO80PIRBROBU911981145002', 911981145, 'PIRBROBU'),
('RO54BRDEROBU914562834002', 914562834, 'BRDEROBU'),
('RO77BRELROBU638617485002', 638617485, 'BRELROBU'),
('RO56RNCBROBU713527112003', 713527112, 'RNCBROBU'),
('RO88INGBROBU971793834003', 971793834, 'INGBROBU'),
('RO63BTRLRO22660416356003', 660416356, 'BTRLRO22'),
('RO91CECEROBU658165878003', 658165878, 'CECEROBU');

-- at least one statement must violate referential integrity constraints -----------------------------------
--INSERT INTO Companies_Banks VALUES
--('RO91CECEROBU6581658780033', 658165878, 'CECERO3U');

SELECT * 
FROM Companies_Banks;


-- Insert values into Employees table with randomly generated CNP
INSERT INTO Employees (CNP, EmployeeName, CompanyCUI, Salary, Employee_Address, EmploymentDate) VALUES
(5021512901234, 'Angelina Jolie', 971793834, 220000, 'Strada Bel Air, Cluj-Napoca', '2016-05-21'),
(5031011915678, 'Leonardo DiCaprio', 660416356, 270000, 'Strada Sunset, Iași', '2017-02-10'),
(5040301923456, 'Scarlett Johansson', 658165878, 280000, 'Strada Broadway, Timișoara', '2018-08-15'),
(5052402909876, 'Tom Hanks', 953547190, 300000, 'Strada Walk of Fame, Sibiu', '2019-11-03'),
(6061211912345, 'Emma Watson', 914489309, 230000, 'Strada Diagon Alley, București', '2020-06-28'),
(6070722906543, 'Chris Hemsworth', 638617734, 260000, 'Strada Thor, Brașov', '2021-09-14'),
(6080212908765, 'Natalie Portman', 400420023, 210000, 'Strada Star Wars, Ploiești', '2022-04-19'),
(6091111914321, 'Robert Downey Jr.', 638617734, 280000, 'Strada Iron Man, Constanța', '2023-01-22'),
(6100322907890, 'Gal Gadot', 657560145, 240000, 'Strada Wonder Woman, Oradea', '2014-07-11'),
(7111421902345, 'Dwayne Johnson', 658165878, 260000, 'Strada Rock, Galați', '2015-02-25'),
(7120531908765, 'Jennifer Lawrence', 660416356, 220000, 'Strada Hunger Games, Arad', '2016-09-09'),
(7130112905432, 'Ryan Reynolds', 713527112, 270000, 'Strada Deadpool, Suceava', '2017-04-18'),
(7142402906789, 'Emma Stone', 911978779, 250000, 'Strada La La Land, Brăila', '2018-11-30'),
(7151521913456, 'Keanu Reeves', 911981145, 280000, 'Strada Matrix, Târgu Mureș', '2019-08-07'),
(8160621907890, 'Charlize Theron', 911978779, 230000, 'Strada Atomic Blonde, Botoșani', '2020-03-02'),
(8170202904321, 'Hugh Jackman', 638617734, 260000, 'Strada Wolverine, Reșița', '2021-10-14'),
(8181111907654, 'Mila Kunis', 400420023, 210000, 'Strada Black Swan, Focșani', '2022-05-23'),
(8190321908765, 'Will Smith', 953547190, 300000, 'Strada Fresh Prince, Drobeta-Turnu Severin', '2023-12-06'),
(8201212905432, 'Cate Blanchett', 971793834, 220000, 'Strada Lord of the Rings, Alba Iulia', '2014-09-09'),
(9210721909876, 'Chris Evans', 660416356, 270000, 'Strada Captain America, Iași', '2015-02-10'),
(9220212912345, 'Emma Roberts', 638644872, 240000, 'Strada Scream Queens, Timișoara', '2016-07-12'),
(9231521904567, 'Henry Cavill', 638617485, 260000, 'Strada Superman, Oradea', '2017-09-18'),
(9241011916789, 'Margot Robbie', 114266534, 280000, 'Strada Harley Quinn, Galați', '2018-04-21'),
(9250302908765, 'Idris Elba', 303896834, 230000, 'Strada Luther, Arad', '2019-10-25'),
(1020152190432, 'Zendaya', 313938069, 250000, 'Strada Euphoria, Sibiu', '2020-05-28'),
(1021122198765, 'Jake Gyllenhaal', 382013924, 270000, 'Strada Nightcrawler, Brașov', '2021-12-04'),
(1022211906543, 'Tom Hardy', 382013934, 230000, 'Strada Bane, Ploiești', '2022-06-19'),
(1023031908765, 'Rachel McAdams', 400420023, 260000, 'Strada The Notebook, Constanța', '2023-01-22'),
(1024252197890, 'Daniel Radcliffe', 638617485, 220000, 'Strada Harry Potter, Oradea', '2014-07-03'),
(1121212192345, 'Eva Green', 638617734, 240000, 'Strada Penny Dreadful, Galați', '2015-09-16'),
(1122152198765, 'Johnny Depp', 658165878, 260000, 'Strada Pirates of the Caribbean, Arad', '2016-04-29'),
(1123012905432, 'Halle Berry', 660416356, 220000, 'Strada Catwoman, Suceava', '2017-11-07'),
(1124202906789, 'Robert Pattinson', 713527112, 250000, 'Strada Twilight, București', '2018-04-10'),
(1125152193456, 'Kristen Stewart', 911978779, 280000, 'Strada Bella Swan, Târgu Mureș', '2019-10-13'),
(1220061909876, 'Robert De Niro', 911981145, 230000, 'Strada Goodfellas, Botoșani', '2020-05-18'),
(1221012914321, 'Natalie Dormer', 914489309, 260000, 'Strada Game of Thrones, Reșița', '2021-10-24'),
(1222252195678, 'Liam Hemsworth', 953547190, 300000, 'Strada Hunger Games, Drobeta-Turnu Severin', '2022-04-03'),
(1223031908765, 'Julia Roberts', 971793834, 220000, 'Strada Pretty Woman, Alba Iulia', '2023-11-06'),
(1224152197890, 'Matthew McConaughey', 660416356, 270000, 'Strada Interstellar, Iași', '2014-04-09'),
(1320621904321, 'Anne Hathaway', 713527112, 250000, 'Strada Les Misérables, București', '2015-09-15'),
(1321212908765, 'Chris Pratt', 911978779, 280000, 'Strada Guardians of the Galaxy, Târgu Mureș', '2016-04-20'),
(1322152195432, 'Nicole Kidman', 911981145, 230000, 'Strada Moulin Rouge, Botoșani', '2017-10-26'),
(1323221906789, 'Christian Bale', 914489309, 260000, 'Strada The Dark Knight, Reșița', '2018-05-01'),
(1324102903456, 'Jennifer Aniston', 638617734, 210000, 'Strada Friends, Brașov', '2019-12-06'),
(1420512196543, 'Daniel Craig', 638644872, 240000, 'Strada James Bond, Ploiești', '2020-05-11'),
(1421122198765, 'Eva Mendes', 400420023, 260000, 'Strada Hitch, Constanța', '2021-10-16'),
(1422221909876, 'Harrison Ford', 953547190, 300000, 'Strada Indiana Jones, Drobeta-Turnu Severin', '2022-04-23'),
(1423021906543, 'Margaret Qualley', 971793834, 220000, 'Strada Once Upon a Time in Hollywood, Alba Iulia', '2023-10-30'),
(1424252198765, 'Rami Malek', 660416356, 270000, 'Strada Bohemian Rhapsody, Iași', '2014-05-05');

SELECT * 
FROM Employees;


-- insert values into Offices
INSERT INTO Offices (OfficeCode, CompanyCUI, City, Street, Number, PostalCode) VALUES
(1, 114266534, 'Bucharest', 'Calea Victoriei', 123, 050012),
(2, 133785134, 'Cluj-Napoca', 'Strada Memorandumului', 45, 400114),
(3, 303896834, 'Iași', 'Strada Lăpușneanu', 87, 700045),
(4, 313938069, 'Sibiu', 'Bulevardul Nicolae Bălcescu', 56, 550012),
(5, 382013924, 'Timișoara', 'Strada Mercy', 78, 300023),
(6, 382013934, 'Ploiești', 'Bulevardul Republicii', 32, 100543),
(7, 400420023, 'Constanța', 'Strada Tomis', 21, 900011),
(8, 638617485, 'Brașov', 'Piața Sfatului', 19, 500078),
(9, 638617734, 'București', 'Calea Dorobanților', 67, 010123),
(10, 638644872, 'Oradea', 'Strada Independenței', 54, 410011),
(11, 657560145, 'Galați', 'Strada Domnească', 98, 800034),
(12, 658165878, 'Arad', 'Bulevardul Revoluției', 76, 310001),
(13, 660416356, 'Suceava', 'Strada Ștefan cel Mare', 43, 720045),
(14, 713527112, 'Târgu Mureș', 'Piața Victoriei', 32, 540023),
(15, 911978779, 'Brăila', 'Strada Dorobanților', 21, 810011),
(16, 911981145, 'Târgu Mureș', 'Bulevardul 1 Decembrie 1918', 87, 540045),
(17, 914489309, 'Botoșani', 'Strada Cuza Vodă', 54, 710011),
(18, 914562834, 'Galați', 'Bulevardul Eroilor', 76, 800034),
(19, 953547190, 'Drobeta-Turnu Severin', 'Strada 1 Decembrie', 98, 220011),
(20, 971793834, 'Alba Iulia', 'Bulevardul Horea', 32, 510023),
(21, 638617734, 'Reșița', 'Piața Revoluției', 19, 320078),
(22, 638644872, 'Focșani', 'Bulevardul Unirii', 67, 620011),
(23, 638617485, 'Ploiești', 'Strada Mihai Bravu', 54, 100034),
(24, 400420023, 'Constanța', 'Bulevardul Mamaia', 43, 900045),
(25, 953547190, 'Drobeta-Turnu Severin', 'Strada Traian', 21, 220011),
(26, 971793834, 'Alba Iulia', 'Piața Cetății', 32, 510023),
(27, 660416356, 'Iași', 'Bulevardul Ștefan cel Mare și Sfânt', 87, 700045),
(28, 638644872, 'Timișoara', 'Piața Victoriei', 76, 300078),
(29, 911981145, 'Botoșani', 'Strada Mihai Eminescu', 54, 710011),
(30, 658165878, 'Arad', 'Strada Vasile Goldiș', 98, 310034);

SELECT *
FROM Offices;

-- insert values into Services_Products as Payments
INSERT INTO Services_Products (InternalCode, SPName, Quantity, PriceValue, VATRate, Currency) VALUES
(1, 'Smartphones', 10, 7500, 19, 'RON'),
(2, 'Graphics Card', 5, 2500, 19, 'RON'),
(3, 'Painkillers', 20, 300, 9, 'RON'),
(4, 'Laptops', 15, 8000, 19, 'RON'),
(5, 'Grocery Basket', 50, 1500, 9, 'RON'),
(6, 'Color Laser Printer', 5, 1500, 19, 'RON'),
(7, 'LED TVs', 10, 6000, 19, 'RON'),
(8, 'Online Banking Subscription', 5, 100, 5, 'RON'),
(9, 'Social Media Advertising', 5, 4000, 19, 'RON'),
(10, 'Clothing Items', 30, 1000, 9, 'RON'),
(11, 'Home Appliances', 20, 800, 9, 'RON'),
(12, 'Microsoft Office Suite', 15, 4000, 19, 'RON'),
(13, 'Tablets', 10, 7000, 19, 'RON'),
(14, 'Running Shoes', 5, 2500, 5, 'RON'),
(15, 'Digital Cameras', 5, 3000, 19, 'RON'),
(16, 'Car Maintenance Service', 10, 5000, 19, 'RON'),
(17, 'Electricity Supply', 15, 800, 9, 'RON'),
(18, 'Electric Scooters', 5, 3000, 9, 'RON'),
(19, 'Online Shopping Credits', 20, 1000, 19, 'RON'),
(20, 'High-Performance Graphics Card', 5, 2500, 19, 'RON'),
(21, 'Gaming PCs', 10, 7000, 19, 'RON'),
(22, 'Running Shoes', 5, 2000, 5, 'RON'),
(23, 'Fuel', 15, 400, 9, 'RON'),
(24, 'Solar Panel Installation', 5, 3000, 5, 'RON'),
(25, 'Car Parts', 10, 5000, 19, 'RON'),
(26, 'Online Shopping Credits', 20, 1000, 19, 'RON'),
(27, 'Antibiotics', 15, 4000, 9, 'RON'),
(28, 'Gaming PCs', 5, 2500, 19, 'RON'),
(29, 'Painkillers', 10, 500, 19, 'RON'),
(30, 'Graphics Card', 5, 2000, 19, 'RON');

-- insert values into Services_Products as Incomes
INSERT INTO Services_Products (InternalCode, SPName, Quantity, PriceValue, VATRate, Currency) VALUES
(31, 'Financial Audit', 1, 15000, 19, 'RON'),
(32, 'Tax Consultation', 1, 8000, 19, 'RON'),
(33, 'Bookkeeping Services', 1, 12000, 9, 'RON'),
(34, 'Payroll Management', 1, 10000, 9, 'RON'),
(35, 'Budgeting and Forecasting', 1, 15000, 19, 'RON'),
(36, 'Financial Statement Preparation', 1, 12000, 19, 'RON'),
(37, 'Internal Control Evaluation', 1, 10000, 19, 'RON'),
(38, 'Business Advisory', 1, 15000, 9, 'RON'),
(39, 'Tax Compliance Services', 1, 12000, 19, 'RON'),
(40, 'Risk Management', 1, 10000, 19, 'RON');

SELECT *
FROM Services_Products;

INSERT INTO Income (InvoiceNumber, CompanyCUI, IncomeDate) VALUES
(1, 114266534, '2023-01-15'),
(2, 133785134, '2023-02-01'),
(3, 303896834, '2023-02-10'),
(4, 313938069, '2023-03-05'),
(5, 382013924, '2023-03-20'),
(6, 382013934, '2023-04-02'),
(7, 400420023, '2023-04-15'),
(8, 638617485, '2023-05-01'),
(9, 638617734, '2023-05-12'),
(10, 638644872, '2023-06-03'),
(11, 657560145, '2023-06-18'),
(12, 658165878, '2023-07-01'),
(13, 660416356, '2023-07-15'),
(14, 713527112, '2023-08-02'),
(15, 911978779, '2023-08-20'),
(16, 911981145, '2023-09-05'),
(17, 914489309, '2023-09-18'),
(18, 914562834, '2023-10-01'),
(19, 953547190, '2023-10-15'),
(20, 971793834, '2023-11-01');

SELECT *
FROM Income;

INSERT INTO Income_Services_Products (ProductCode, InvoiceNumber) VALUES
(31, 1),
(32, 2),
(33, 3),
(34, 4),
(35, 5),
(36, 6),
(37, 7),
(38, 8),
(39, 9),
(40, 10),
(31, 11),
(32, 12),
(33, 13),
(34, 14),
(35, 15),
(36, 16),
(37, 17),
(38, 18),
(39, 19),
(40, 20);

SELECT *
FROM Income_Services_Products;

INSERT INTO Payments (InvoiceNumber, CompanyCUI, PaymentDate) VALUES
(21, 114266534, '2023-01-15'),
(22, 133785134, '2023-02-01'),
(23, 303896834, '2023-02-10'),
(24, 313938069, '2023-03-05'),
(25, 382013924, '2023-03-20'),
(26, 382013934, '2023-04-02'),
(27, 400420023, '2023-04-15'),
(28, 638617485, '2023-05-01'),
(29, 638617734, '2023-05-12'),
(30, 638644872, '2023-06-03'),
(31, 657560145, '2023-06-18'),
(32, 658165878, '2023-07-01'),
(33, 660416356, '2023-07-15'),
(34, 713527112, '2023-08-02'),
(35, 911978779, '2023-08-20'),
(36, 911981145, '2023-09-05'),
(37, 914489309, '2023-09-18'),
(38, 914562834, '2023-10-01'),
(39, 953547190, '2023-10-15'),
(40, 971793834, '2023-11-01');

SELECT *
FROM Payments;

INSERT INTO Payments_Services_Products (ProductCode, InvoiceNumber) VALUES
(1, 21),
(2, 22),
(3, 23),
(4, 24),
(5, 25),
(6, 26),
(7, 27),
(8, 28),
(9, 29),
(10, 30),
(11, 31),
(12, 32),
(13, 33),
(14, 34),
(15, 35),
(16, 36),
(17, 37),
(18, 38),
(19, 39),
(20, 40);

SELECT *
FROM Payments_Services_Products;