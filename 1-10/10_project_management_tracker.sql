CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL
);
CREATE TABLE tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT,
    name VARCHAR(200) NOT NULL,
    status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (project_id) REFERENCES projects(id)
);
CREATE TABLE task_assignments (
    task_id INT,
    user_id INT,
    PRIMARY KEY (task_id, user_id),
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
SELECT 
    t.id AS task_id,
    t.name AS task_name,
    t.status,
    p.name AS project_name,
    u.name AS assigned_user
FROM tasks t
JOIN projects p ON t.project_id = p.id
JOIN task_assignments ta ON t.id = ta.task_id
JOIN users u ON ta.user_id = u.id;
SELECT 
    p.name AS project_name,
    t.status,
    COUNT(*) AS task_count
FROM tasks t
JOIN projects p ON t.project_id = p.id
GROUP BY p.name, t.status;
