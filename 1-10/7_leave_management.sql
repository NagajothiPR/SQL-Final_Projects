CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS leave_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS leave_requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    leave_type_id INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (emp_id) REFERENCES employees(id),
    FOREIGN KEY (leave_type_id) REFERENCES leave_types(id),
    CHECK (from_date <= to_date)
);
-- Employees
INSERT INTO employees (name) VALUES
('Alice'), ('Bob');

-- Leave Types
INSERT INTO leave_types (type_name) VALUES
('Casual Leave'), ('Sick Leave'), ('Earned Leave');

-- Leave Requests
INSERT INTO leave_requests (emp_id, leave_type_id, from_date, to_date, status) VALUES
(1, 1, '2025-08-10', '2025-08-12', 'Approved'),
(2, 2, '2025-08-15', '2025-08-16', 'Pending');
SELECT 
    e.name AS employee,
    lt.type_name AS leave_type,
    lr.from_date,
    lr.to_date,
    lr.status
FROM 
    leave_requests lr
JOIN 
    employees e ON lr.emp_id = e.id
JOIN 
    leave_types lt ON lr.leave_type_id = lt.id
ORDER BY 
    lr.from_date DESC;
SELECT 
    e.name AS employee,
    SUM(DATEDIFF(lr.to_date, lr.from_date) + 1) AS total_leave_days
FROM 
    leave_requests lr
JOIN 
    employees e ON lr.emp_id = e.id
WHERE 
    lr.status = 'Approved'
GROUP BY 
    e.name;
SELECT *
FROM leave_requests
WHERE emp_id = 1
  AND status IN ('Pending', 'Approved')
  AND (
      '2025-08-11' BETWEEN from_date AND to_date OR
      '2025-08-13' BETWEEN from_date AND to_date OR
      from_date BETWEEN '2025-08-11' AND '2025-08-13'
  );
