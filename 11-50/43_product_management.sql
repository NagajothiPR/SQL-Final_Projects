SELECT o.id AS order_id, r.reason, r.status
FROM orders o
JOIN returns r ON o.id = r.order_id;
SELECT status, COUNT(*) AS total
FROM returns
GROUP BY status;
