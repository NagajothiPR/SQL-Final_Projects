SELECT s.*
FROM subscriptions s
WHERE DATE_ADD(s.start_date, INTERVAL s.renewal_cycle DAY) < CURDATE();
