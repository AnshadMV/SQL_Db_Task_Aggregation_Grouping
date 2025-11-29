
CREATE DATABASE Books_Db
Go

USE Books_Db

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
GO;


SELECT * FROM Books

INSERT INTO Books (B_Name, B_Author, B_Price, B_Stock, B_publish_Date)
VALUES
('SQL Made Easy',     2002, 450, 20, '2025-01-18'),
('Mastering Python',  2002, 550, 15, '2020-03-10'),
('C# in Depth',       2001, 600, 10, '2001-10-10'),
('Learning Flutter',  2003, 500, 25, '2003-09-10');



CREATE TABLE Publisher ( 
	Pub_Id INT PRIMARY KEY IDENTITY(3000,1),
	Pub_Name NVARCHAR(50) ,
	Pub_year INT ,
	Pub_Books_Id INT ,

	CONSTRAINT Publishers_Books_Id FOREIGN KEY (Pub_Books_Id)  REFERENCES Books(  B_Id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE 
	
)


SELECT * FROM Publisher


INSERT INTO Publisher ( Pub_Name ,Pub_year ,Pub_Books_Id) VALUES 
('JASIL ', 2024 , 1004),
('NABHAN ', 2025 , 1003),
('ADHINAD', 2020 , 1001),
('ADHIL', 2024 , 1002);







SELECT * FROM Books
SELECT * FROM Publisher
SELECT * FROM Author;


CREATE TABLE Sales (
sale_ID INT PRIMARY KEY IDENTITY(5000,1),
book_ID INT ,
sale_Date DATE,
sale_amount TINYINT,
sale_To NVARCHAR(50) ,
sale_by NVARCHAR(50)

CONSTRAINT FK_book_ID  FOREIGN KEY (book_ID)  REFERENCES Books(B_Id)
ON UPDATE CASCADE 
ON DELETE CASCADE
)

DROP TABLE Sales
SELECT * FROM Sales

INSERT INTO Sales ( book_ID, sale_Date, sale_amount, sale_To, sale_by)
VALUES
( 1, '2025-01-10', 3, 'Arjun Menon', 'Jasil'),
( 2, '2025-01-12', 1, 'Keerthana Raj', 'Book World'),
(3, '2025-01-15', 2, 'Rohit Suresh', 'Online Store'),
( 4, '2025-01-18', 5, 'Minhaj Moideen', 'Campus Store'),
( 2, '2025-02-01', 2, 'Diya Raveendran', 'Jasil'),
( 1, '2025-02-05', 1, 'Vishnu Prasad', 'Book World');




DELETE Books


DROP DATABASE Books_Db