SELECT f.name, COUNT(*) AS accepted_count
FROM proposals p
JOIN freelancers f ON p.freelancer_id = f.id
WHERE p.status = 'accepted'
GROUP BY f.name;
SELECT f.name, COUNT(p.project_id) AS total_projects
FROM proposals p
JOIN freelancers f ON p.freelancer_id = f.id
GROUP BY f.name;
