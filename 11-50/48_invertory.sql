SELECT p.name, SUM(b.quantity) AS expired_qty
FROM products p
JOIN batches b ON p.id = b.product_id
WHERE b.expiry_date < CURDATE()
GROUP BY p.name;
