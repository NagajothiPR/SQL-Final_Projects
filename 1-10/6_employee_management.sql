CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dept VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL
);
CREATE TABLE IF NOT EXISTS timesheets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    project_id INT NOT NULL,
    hours DECIMAL(5,2) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(id),
    FOREIGN KEY (project_id) REFERENCES projects(id)
);
-- Employees
INSERT INTO employees (name, dept) VALUES
('Alice', 'Engineering'),
('Bob', 'Marketing');

-- Projects
INSERT INTO projects (name) VALUES
('Website Redesign'),
('SEO Optimization');

-- Timesheets
INSERT INTO timesheets (emp_id, project_id, hours, date) VALUES
(1, 1, 8.0, '2025-08-01'),
(1, 1, 7.5, '2025-08-02'),
(1, 2, 4.0, '2025-08-03'),
(2, 2, 6.5, '2025-08-01');
SELECT 
    e.name AS employee,
    p.name AS project,
    SUM(t.hours) AS total_hours
FROM 
    timesheets t
JOIN 
    employees e ON t.emp_id = e.id
JOIN 
    projects p ON t.project_id = p.id
GROUP BY 
    e.name, p.name;
SELECT 
    e.name AS employee,
    p.name AS project,
    SUM(t.hours) AS weekly_hours
FROM 
    timesheets t
JOIN 
    employees e ON t.emp_id = e.id
JOIN 
    projects p ON t.project_id = p.id
WHERE 
    t.date BETWEEN '2025-08-01' AND '2025-08-07'
GROUP BY 
    e.name, p.name;
SELECT 
    t.date,
    e.name AS employee,
    p.name AS project,
    t.hours
FROM 
    timesheets t
JOIN 
    employees e ON t.emp_id = e.id
JOIN 
    projects p ON t.project_id = p.id
ORDER BY 
    t.date DESC;
