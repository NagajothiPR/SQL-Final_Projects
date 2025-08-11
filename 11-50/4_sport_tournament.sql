SELECT t.name,
SUM(CASE WHEN s.score = (
    SELECT MAX(score) FROM scores WHERE match_id = s.match_id
) THEN 1 ELSE 0 END) AS wins
FROM teams t
JOIN scores s ON t.id = s.team_id
GROUP BY t.name;
SELECT t.name, SUM(s.score) AS total_points
FROM teams t
JOIN scores s ON t.id = s.team_id
GROUP BY t.name
ORDER BY total_points DESC;
