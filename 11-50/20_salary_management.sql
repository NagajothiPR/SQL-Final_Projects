CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE salaries (
    emp_id INT NOT NULL,
    month DATE NOT NULL,
    base DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0,
    PRIMARY KEY (emp_id, month),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

CREATE TABLE deductions (
    emp_id INT NOT NULL,
    month DATE NOT NULL,
    reason VARCHAR(100),
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);
INSERT INTO employees (name) VALUES
('Amit Verma'), ('Sara Khan');

INSERT INTO salaries (emp_id, month, base, bonus) VALUES
(1, '2025-08-01', 30000, 5000),
(2, '2025-08-01', 25000, 3000);

INSERT INTO deductions (emp_id, month, reason, amount) VALUES
(1, '2025-08-01', 'Tax', 2000),
(1, '2025-08-01', 'Late Penalty', 500),
(2, '2025-08-01', 'Tax', 1500);
SELECT e.name, s.month,
       (s.base + s.bonus - IFNULL(SUM(d.amount),0)) AS net_salary
FROM salaries s
JOIN employees e ON s.emp_id = e.id
LEFT JOIN deductions d ON s.emp_id = d.emp_id AND s.month = d.month
GROUP BY e.name, s.month, s.base, s.bonus;
