SELECT AVG(TIMESTAMPDIFF(MINUTE, o.placed_at, o.delivered_at)) AS avg_minutes
FROM orders o;
SELECT da.name, COUNT(d.order_id) AS total_deliveries
FROM delivery_agents da
JOIN deliveries d ON da.id = d.agent_id
GROUP BY da.name;
