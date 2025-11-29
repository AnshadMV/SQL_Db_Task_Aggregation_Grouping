
CREATE DATABASE Books_Db
Go
USE Books_Db
GO

CREATE TABLE Author (
AuthorId INT PRIMARY KEY IDENTITY(2000,1),
AuthorName NVARCHAR(50) 
) 

INSERT INTO Author (AuthorName) VALUES 
(  'SHINAS'),
( 'YADHU KRISHNANA'),
('ANAS'),
( 'NIYAS'),
( 'FARHAN'),
( 'AFSAL');

SELECT * FROM Author;
GO;

CREATE TABLE Books (
  B_Id INT PRIMARY KEY IDENTITY(1000,1),
  B_Name VARCHAR(50) ,
  B_Author INT,
  B_Price INT CHECK ( B_Price > 0) ,
  B_Stock BIT CHECK ( B_Stock >=0 ),
  B_publish_Date DATE,
  CONSTRAINT FK_Books_Author FOREIGN KEY (B_Author) REFERENCES Author(AuthorId)
  ON UPDATE CASCADE 
  ON DELETE CASCADE

)
INSERT INTO Books (B_Name, B_Author, B_Price, B_Stock, B_publish_Date)
VALUES
('SQL Made Easy',     2002, 450, 20, '2025-01-18'),
('Mastering Python',  2002, 550, 15, '2020-03-10'),
('C# in Depth',       2001, 600, 10, '2001-10-10'),
('Learning Flutter',  2003, 500, 25, '2003-09-10');

SELECT * FROM Books
GO;


CREATE TABLE Publisher ( 
	Pub_Id INT PRIMARY KEY IDENTITY(3000,1),
	Pub_Name NVARCHAR(50) ,
	Pub_year INT ,
	Pub_Books_Id INT ,

	CONSTRAINT Publishers_Books_Id FOREIGN KEY (Pub_Books_Id)  REFERENCES Books(  B_Id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE 
)
GO;

INSERT INTO Publisher ( Pub_Name ,Pub_year ,Pub_Books_Id) VALUES 
('JASIL ', 2024 , 1000),
('NABHAN ', 2025 , 1003),
('ADHINAD', 2020 , 1001),
('ADHIL', 2024 , 1002);

SELECT * FROM Publisher
gO;


CREATE TABLE Sales (
sale_ID INT PRIMARY KEY IDENTITY(5000,1),
book_ID INT ,
sale_Date DATE,
sale_amount INT,
sale_To NVARCHAR(50) ,
sale_by NVARCHAR(50)

CONSTRAINT FK_book_ID  FOREIGN KEY (book_ID)  REFERENCES Books(B_Id)
ON UPDATE CASCADE 
ON DELETE CASCADE
)

INSERT INTO Sales ( book_ID, sale_Date, sale_amount, sale_To, sale_by)
VALUES
( 1000, '2025-01-10', 400, 'Arjun Menon', 'Jasil'),
( 1002, '2025-01-12', 100, 'Keerthana Raj', 'Book World'),
(1003, '2025-01-15', 200, 'Rohit Suresh', 'Online Store'),
( 1003, '2025-01-18', 500, 'Minhaj Moideen', 'Campus Store'),
( 1002, '2025-02-01', 200, 'Diya Raveendran', 'Jasil'),
( 1001, '2025-02-05', 100, 'Vishnu Prasad', 'Book World'),
( 1003, '2024-04-10', 400, 'Arjun Menon', 'Jasil'),
( 1003, '2025-06-12', 100, 'Keerthana Raj', 'Book World'),
(1003, '2025-06-16', 200, 'Rohit Suresh', 'Online Store');

SELECT * FROM Sales
GO;



SELECT * FROM Sales
SELECT * FROM Books
SELECT * FROM Publisher
SELECT * FROM Author;


SELECT SUM(sale_amount) FROM Sales
GO

CREATE VIEW Aggr_SUM AS
SELECT 
b.B_Id ,
b.B_Name , 
SUM(s.sale_amount) AS Total_Sales_Amount  /*column name was specified*/
FROM Sales s
JOIN Books b ON b.B_Id = s.book_ID
GROUP BY b.B_Id ,b.B_Name;
GO

SELECT * FROM Aggr_SUM;
GO

CREATE VIEW More_sold_books AS
SELECT b.B_Id ,b.B_Name ,SUM(s.sale_amount) AS Total_sales_Amount
FROM Sales s
JOIN Books b ON b.B_Id = s.book_ID
GROUP BY b.B_Id ,b.B_Name 
HAVING SUM(s.sale_amount) > 300
GO
SELECT * FROM More_sold_books;


SELECT 
    b.B_Id,
    b.B_Name,
    COUNT(s.sale_ID) AS Times_Sold
FROM Sales s
JOIN Books b ON b.B_Id = s.book_ID
GROUP BY b.B_Id, b.B_Name
HAVING COUNT(s.sale_ID) >= 3;
GO



CREATE PROCEDURE GetBookTotalSales
    @BookTitle VARCHAR(50)
AS
BEGIN
    SELECT 
        b.B_Name,
        SUM(s.sale_amount) AS Total_Sales
    FROM Books b
    LEFT JOIN Sales s ON b.B_Id = s.book_ID
    WHERE b.B_Name = @BookTitle
    GROUP BY b.B_Name;
END;
GO


EXEC GetBookTotalSales 'C# in Depth'
GO;


CREATE FUNCTION GetAverageSaleAmount()
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @AvgSale DECIMAL(10,2);

    SELECT @AvgSale = AVG(sale_amount)
    FROM Sales;

    RETURN @AvgSale;
END;
GO;

SELECT dbo.GetAverageSaleAmount();
