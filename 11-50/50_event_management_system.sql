SELECT e.title, COUNT(a.user_id) AS registered, e.max_capacity
FROM events e
JOIN attendees a ON e.id = a.event_id
GROUP BY e.id, e.title, e.max_capacity
HAVING registered >= e.max_capacity;
