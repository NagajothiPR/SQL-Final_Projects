-- Books table
CREATE TABLE books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL
);

-- Members table
CREATE TABLE members (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Borrows table
CREATE TABLE borrows (
    id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);
-- Books
INSERT INTO books (title, author) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald'),
('To Kill a Mockingbird', 'Harper Lee'),
('1984', 'George Orwell');

-- Members
INSERT INTO members (name) VALUES
('Amit Verma'),
('Sara Khan'),
('Ravi Iyer');

-- Borrow Records
INSERT INTO borrows (member_id, book_id, borrow_date, return_date) VALUES
(1, 1, '2025-07-01', '2025-07-10'), -- Returned on time
(1, 2, '2025-07-15', '2025-07-30'), -- Late
(2, 3, '2025-07-20', NULL),         -- Not yet returned
(3, 1, '2025-07-25', '2025-08-05'); -- Late
SELECT b.id AS borrow_id, m.name AS member_name, bk.title, bk.author,
       bo.borrow_date, bo.return_date
FROM borrows bo
JOIN members m ON bo.member_id = m.id
JOIN books bk ON bo.book_id = bk.id;
SELECT m.name, bk.title, bo.borrow_date,
       DATE_ADD(bo.borrow_date, INTERVAL 14 DAY) AS due_date
FROM borrows bo
JOIN members m ON bo.member_id = m.id
JOIN books bk ON bo.book_id = bk.id
WHERE bo.return_date IS NULL 
  AND CURDATE() > DATE_ADD(bo.borrow_date, INTERVAL 14 DAY);
SELECT m.name, bk.title, bo.borrow_date, bo.return_date,
       GREATEST(DATEDIFF(bo.return_date, DATE_ADD(bo.borrow_date, INTERVAL 14 DAY)), 0) AS late_days,
       GREATEST(DATEDIFF(bo.return_date, DATE_ADD(bo.borrow_date, INTERVAL 14 DAY)), 0) * 10 AS fine_amount
FROM borrows bo
JOIN members m ON bo.member_id = m.id
JOIN books bk ON bo.book_id = bk.id
WHERE bo.return_date IS NOT NULL;
SELECT m.name, bk.title, bo.borrow_date,
       GREATEST(DATEDIFF(CURDATE(), DATE_ADD(bo.borrow_date, INTERVAL 14 DAY)), 0) AS late_days,
       GREATEST(DATEDIFF(CURDATE(), DATE_ADD(bo.borrow_date, INTERVAL 14 DAY)), 0) * 10 AS fine_amount
FROM borrows bo
JOIN members m ON bo.member_id = m.id
JOIN books bk ON bo.book_id = bk.id
WHERE bo.return_date IS NULL;

