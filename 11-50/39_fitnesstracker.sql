SELECT u.name, YEARWEEK(wl.log_date) AS week, SUM(wl.duration) AS total_minutes
FROM users u
JOIN workout_logs wl ON u.id = wl.user_id
GROUP BY u.name, YEARWEEK(wl.log_date);
SELECT u.name, w.name AS workout, w.type, wl.duration
FROM workout_logs wl
JOIN workouts w ON wl.workout_id = w.id
JOIN users u ON wl.user_id = u.id;
