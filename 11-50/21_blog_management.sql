-- 1. Users Table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- 2. Posts Table
CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    published_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 3. Comments Table
CREATE TABLE comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    commented_at DATETIME NOT NULL,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie');

INSERT INTO posts (user_id, title, content, published_date) VALUES
(1, 'First Blog Post', 'This is Alice’s first blog.', '2025-08-01'),
(2, 'Travel Tips', 'Bob shares his travel experiences.', '2025-08-03'),
(1, 'SQL Tricks', 'Some advanced SQL tricks from Alice.', '2025-08-08');

INSERT INTO comments (post_id, user_id, comment_text, commented_at) VALUES
(1, 2, 'Nice post, Alice!', '2025-08-02 10:30:00'),
(1, 3, 'Very helpful, thanks!', '2025-08-02 11:15:00'),
(2, 1, 'Great tips, Bob!', '2025-08-04 09:45:00'),
(3, 2, 'Loved these tricks!', '2025-08-09 14:00:00');
SELECT 
    title, published_date
FROM posts
WHERE published_date BETWEEN '2025-08-01' AND '2025-08-05'
ORDER BY published_date;
SELECT 
    p.title,
    COUNT(c.id) AS total_comments
FROM posts p
LEFT JOIN comments c ON p.id = c.post_id
GROUP BY p.id, p.title
ORDER BY total_comments DESC;
SELECT 
    p.title,
    MAX(c.commented_at) AS last_commented
FROM posts p
LEFT JOIN comments c ON p.id = c.post_id
GROUP BY p.id, p.title
ORDER BY last_commented DESC;
