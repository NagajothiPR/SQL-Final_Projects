SELECT j.name, MAX(l.run_time) AS last_run
FROM jobs j
JOIN job_logs l ON j.id = l.job_id
GROUP BY j.name;
SELECT j.name, l.status, COUNT(*) AS total
FROM jobs j
JOIN job_logs l ON j.id = l.job_id
GROUP BY j.name, l.status;
