SELECT AVG(TIMESTAMPDIFF(HOUR, created_at, resolved_at)) AS avg_hours
FROM tickets
WHERE resolved_at IS NOT NULL;
SELECT status, COUNT(*) AS total
FROM tickets
GROUP BY status;
