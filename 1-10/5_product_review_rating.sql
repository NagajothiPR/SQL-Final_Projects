CREATE TABLE IF NOT EXISTS reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating DECIMAL(2,1) CHECK (rating >= 1 AND rating <= 5),
    review TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    UNIQUE (user_id, product_id) -- prevent duplicate reviews
);
-- Example: users 1 and 2 review product 1
INSERT INTO reviews (user_id, product_id, rating, review)
VALUES 
(1, 1, 4.5, 'Great product!'),
(2, 1, 4.0, 'Very useful');

-- This will fail due to UNIQUE constraint (duplicate user-product review)
-- INSERT INTO reviews (user_id, product_id, rating, review)
-- VALUES (1, 1, 3.5, 'Update my review'); 
SELECT 
    p.id,
    p.name,
    AVG(r.rating) AS avg_rating,
    COUNT(r.id) AS total_reviews
FROM 
    products p
JOIN 
    reviews r ON p.id = r.product_id
GROUP BY 
    p.id, p.name;
    SELECT 
    p.id,
    p.name,
    AVG(r.rating) AS avg_rating
FROM 
    products p
JOIN 
    reviews r ON p.id = r.product_id
GROUP BY 
    p.id, p.name
HAVING 
    AVG(r.rating) >= 4
ORDER BY 
    avg_rating DESC
LIMIT 5;
SELECT 
    u.name AS user_name,
    r.rating,
    r.review,
    r.created_at
FROM 
    reviews r
JOIN 
    users u ON r.user_id = u.id
WHERE 
    r.product_id = 1
ORDER BY 
    r.created_at DESC;


