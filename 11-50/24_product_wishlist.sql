CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE wishlist (
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
SELECT 
    p.name AS product_name,
    COUNT(w.user_id) AS wishlist_count
FROM wishlist w
JOIN products p ON w.product_id = p.id
GROUP BY p.id, p.name
ORDER BY wishlist_count DESC;
SELECT 
    p.name
FROM wishlist w
JOIN products p ON w.product_id = p.id
WHERE w.user_id = 1;
