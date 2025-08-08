CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    image_url VARCHAR(255)
    -- category_id and brand_id can also be added here
);
CREATE TABLE carts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE cart_items (
    cart_id INT,
    product_id INT,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES carts(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
INSERT INTO users (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');
INSERT INTO carts (user_id) VALUES 
(1), (2);
-- Alice adds 2 iPhones (product_id = 1), 1 Nike Shoes (product_id = 2)
INSERT INTO cart_items (cart_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1);

-- Bob adds 1 Galaxy S23 (product_id = 3)
INSERT INTO cart_items (cart_id, product_id, quantity) VALUES
(2, 3, 1);
SELECT 
    u.name AS user,
    p.name AS product,
    ci.quantity,
    p.price,
    (ci.quantity * p.price) AS total_price
FROM cart_items ci
JOIN carts c ON ci.cart_id = c.id
JOIN users u ON c.user_id = u.id
JOIN products p ON ci.product_id = p.id
WHERE c.id = 1;  -- Alice's cart
SELECT 
    u.name AS user,
    SUM(ci.quantity * p.price) AS total_cart_value
FROM cart_items ci
JOIN carts c ON ci.cart_id = c.id
JOIN users u ON c.user_id = u.id
JOIN products p ON ci.product_id = p.id
WHERE c.id = 1
GROUP BY u.name;
-- Alice updates quantity of iPhone to 3
UPDATE cart_items
SET quantity = 3
WHERE cart_id = 1 AND product_id = 1;
-- Remove Nike Shoes from Alice's cart
DELETE FROM cart_items
WHERE cart_id = 1 AND product_id = 2;

