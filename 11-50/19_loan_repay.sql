CREATE TABLE loans (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    principal DECIMAL(12,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL
);

CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    paid_on DATE NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES loans(id)
);
INSERT INTO loans (user_id, principal, interest_rate) VALUES
(1, 100000, 8.5),
(2, 50000, 7.0);

INSERT INTO payments (loan_id, amount, paid_on) VALUES
(1, 10000, '2025-08-01'),
(1, 15000, '2025-09-01'),
(2, 5000, '2025-08-05');
SELECT l.id AS loan_id, l.principal, 
       IFNULL(SUM(p.amount),0) AS total_paid,
       l.principal - IFNULL(SUM(p.amount),0) AS remaining_amount
FROM loans l
LEFT JOIN payments p ON l.id = p.loan_id
GROUP BY l.id, l.principal;
