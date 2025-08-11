SELECT l.name, COUNT(e.id) AS entry_count
FROM locations l
JOIN entry_logs e ON l.id = e.location_id
GROUP BY l.name;
SELECT * FROM entry_logs
WHERE entry_time BETWEEN '2025-08-01' AND '2025-08-10';
