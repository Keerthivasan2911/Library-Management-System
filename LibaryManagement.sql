-- Active: 1728214109840@@127.0.0.1@3306
use perfect;
drop TABLE books;
-- Create Books Table
CREATE TABLE Books (
    Book_id INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(299) NOT NULL,
    Author_name VARCHAR(400) UNIQUE,
    Genre VARCHAR(299) NOT NULL,
    Year INT,
    Quantity INT
);

-- Insert Values into Books
INSERT INTO Books (Title, Author_name, Genre, Year, Quantity)
VALUES 
    ('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 3),
    ('1984', 'George Orwell', 'Dystopian', 1949, 5),
    ('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 2),
    ('Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 4),
    ('Moby Dick', 'Herman Melville', 'Adventure', 1851, 1);

-- Create Author Table
CREATE TABLE Author (
    Author_id INT AUTO_INCREMENT PRIMARY KEY,
    Author_name VARCHAR(400),
    Birth_year INT,
    Country VARCHAR(43)
);

-- Insert into Author Table
INSERT INTO Author (Author_name, Birth_year, Country) 
VALUES 
    ('F. Scott Fitzgerald', 1896, 'American'),
    ('George Orwell', 1903, 'British'),
    ('Harper Lee', 1926, 'American'),
    ('Jane Austen', 1775, 'British'),
    ('Herman Melville', 1819, 'American');

-- Create Members Table
CREATE TABLE Members (
    Member_id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(28),
    M_date DATE,
    Email VARCHAR(88)
);

-- Insert into Members Table
INSERT INTO Members (Name, M_date, Email)
VALUES 
    ('Johnson', '2021-01-15', 'alice@example.com'),
    ('Bob Smith', '2020-06-20', 'bob@example.com'),
    ('Brown', '2020-08-23', 'brown@example.com');

-- Create Borrow Table
CREATE TABLE Borrow (
    Borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    Member_id INT,
    Book_id INT,
    Borrow_date DATE,
    Return_date DATE,
    FOREIGN KEY (Member_id) REFERENCES Members(Member_id),
    FOREIGN KEY (Book_id) REFERENCES Books(Book_id)
);

-- Insert into Borrow Table
INSERT INTO Borrow (Member_id, Book_id, Borrow_date, Return_date)
VALUES 
    (1, 1, '2023-01-10', NULL),
    (2, 2, '2023-02-15', '2023-02-20'),
    (1, 3, '2023-03-01', '2023-03-15');

-- Updating Book Quantity when Borrowed
UPDATE Books 
SET Quantity = Quantity - 1 
WHERE Book_id = 1 AND Quantity > 0;

-- Example of Returning a Book (adjusting quantity back)
UPDATE Books 
SET Quantity = Quantity + 1 
WHERE Book_id = 1;

-- Select Borrowed Books for a Specific Member
SELECT b.Title, br.Borrow_date, br.Return_date 
FROM Books b
JOIN Borrow br ON b.Book_id = br.Book_id
WHERE br.Member_id = 1;

-- Count Total Borrowed Books
SELECT COUNT(*) AS total_borrowed_books FROM Borrow;

-- List Available Books
SELECT * FROM Books WHERE Quantity > 0;
