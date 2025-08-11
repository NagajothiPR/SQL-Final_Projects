SELECT *
FROM reservations r1
JOIN reservations r2
  ON r1.table_id = r2.table_id
  AND r1.date = r2.date
  AND r1.time_slot = r2.time_slot
  AND r1.id <> r2.id;
SELECT date, COUNT(*) AS total_reservations
FROM reservations
GROUP BY date;
