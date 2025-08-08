CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,  -- Snapshot price
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
-- 1. Create order for Alice (user_id = 1)
INSERT INTO orders (user_id, status) VALUES (1, 'Pending');

-- Assume inserted order ID = 1

-- 2. Insert order items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 999.99),   -- iPhone 15 x1
(1, 2, 2, 199.99);   -- Nike Air Max x2
-- Mark Alice's order as 'Shipped'
UPDATE orders
SET status = 'Shipped'
WHERE id = 1;
SELECT 
    o.id AS order_id,
    o.status,
    o.created_at,
    p.name AS product,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS total_price
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE o.user_id = 1
ORDER BY o.created_at DESC;
SELECT 
    o.id AS order_id,
    o.created_at,
    SUM(oi.quantity * oi.price) AS order_total
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
WHERE o.user_id = 1
GROUP BY o.id, o.created_at
ORDER BY o.created_at DESC;
SELECT 
    u.name AS customer,
    o.id AS order_id,
    o.status,
    o.created_at
FROM orders o
JOIN users u ON o.user_id = u.id
WHERE o.status = 'Delivered'
ORDER BY o.created_at DESC;
START TRANSACTION;

INSERT INTO orders (user_id, status) VALUES (1, 'Pending');
SET @order_id = LAST_INSERT_ID();

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(@order_id, 1, 1, 999.99),
(@order_id, 2, 2, 199.99);

COMMIT;
