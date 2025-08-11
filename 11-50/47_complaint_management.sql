SELECT d.name, COUNT(c.id) AS open_cases
FROM departments d
JOIN complaints c ON d.id = c.department_id
WHERE c.status = 'open'
GROUP BY d.name;
