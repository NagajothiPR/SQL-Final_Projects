-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Categories table
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Expenses table
CREATE TABLE expenses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    category_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    expense_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
-- Users
INSERT INTO users (name) VALUES
('Amit Verma'),
('Sara Khan');

-- Categories
INSERT INTO categories (name) VALUES
('Food'),
('Transport'),
('Shopping'),
('Utilities');

-- Expenses
INSERT INTO expenses (user_id, category_id, amount, expense_date) VALUES
(1, 1, 250.00, '2025-08-01'), -- Food
(1, 3, 1500.00, '2025-08-02'), -- Shopping
(2, 2, 300.00, '2025-08-02'), -- Transport
(1, 4, 1200.00, '2025-08-05'), -- Utilities
(2, 1, 500.00, '2025-08-06'); -- Food
SELECT c.name AS category, SUM(e.amount) AS total_spent
FROM expenses e
JOIN categories c ON e.category_id = c.id
WHERE e.user_id = 1
GROUP BY c.name
ORDER BY total_spent DESC;
SELECT DATE_FORMAT(expense_date, '%Y-%m') AS month, SUM(amount) AS total_spent
FROM expenses
GROUP BY DATE_FORMAT(expense_date, '%Y-%m')
ORDER BY month;
SELECT u.name AS user_name, c.name AS category, e.amount, e.expense_date
FROM expenses e
JOIN users u ON e.user_id = u.id
JOIN categories c ON e.category_id = c.id
WHERE e.amount BETWEEN 500 AND 2000
ORDER BY e.amount DESC;
SELECT u.name AS user_name, c.name AS top_category, SUM(e.amount) AS total_spent
FROM expenses e
JOIN users u ON e.user_id = u.id
JOIN categories c ON e.category_id = c.id
GROUP BY u.id, c.id
HAVING SUM(e.amount) = (
    SELECT MAX(total)
    FROM (
        SELECT SUM(amount) AS total
        FROM expenses
        WHERE user_id = u.id
        GROUP BY category_id
    ) AS sub
);
