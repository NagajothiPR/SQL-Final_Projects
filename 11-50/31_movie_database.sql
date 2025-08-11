SELECT m.title, AVG(r.score) AS avg_rating
FROM movies m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title;
SELECT m.title, g.name AS genre, AVG(r.score) AS avg_rating
FROM movies m
JOIN genres g ON m.genre_id = g.id
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.title, g.name;
