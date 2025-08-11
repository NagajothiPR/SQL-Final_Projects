SELECT r.vehicle_id,
DATEDIFF(r.end_date, r.start_date) * 50 AS total_charge
FROM rentals r;
SELECT * FROM vehicles v
WHERE v.id NOT IN (
    SELECT vehicle_id FROM rentals
    WHERE CURDATE() BETWEEN start_date AND end_date
);
