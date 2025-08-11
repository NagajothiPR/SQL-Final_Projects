SELECT c.title, AVG(f.rating) AS avg_rating
FROM courses c
JOIN feedback f ON c.id = f.course_id
GROUP BY c.title;
