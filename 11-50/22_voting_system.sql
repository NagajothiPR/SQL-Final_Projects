CREATE TABLE polls (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question VARCHAR(255) NOT NULL
);

CREATE TABLE options (
    id INT PRIMARY KEY AUTO_INCREMENT,
    poll_id INT NOT NULL,
    option_text VARCHAR(255) NOT NULL,
    FOREIGN KEY (poll_id) REFERENCES polls(id)
);

CREATE TABLE votes (
    user_id INT NOT NULL,
    option_id INT NOT NULL,
    voted_at DATETIME NOT NULL,
    PRIMARY KEY (user_id, option_id), -- Prevent duplicate vote per user per option
    FOREIGN KEY (option_id) REFERENCES options(id)
);
SELECT 
    o.option_text,
    COUNT(v.user_id) AS total_votes
FROM options o
LEFT JOIN votes v ON o.id = v.option_id
WHERE o.poll_id = 1
GROUP BY o.id, o.option_text;
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE conversations (
    id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    conversation_id INT NOT NULL,
    sender_id INT NOT NULL,
    message_text TEXT NOT NULL,
    sent_at DATETIME NOT NULL,
    FOREIGN KEY (conversation_id) REFERENCES conversations(id),
    FOREIGN KEY (sender_id) REFERENCES users(id)
);
SELECT 
    m.conversation_id,
    m.message_text,
    m.sent_at
FROM messages m
JOIN (
    SELECT conversation_id, MAX(sent_at) AS latest
    FROM messages
    GROUP BY conversation_id
) t ON m.conversation_id = t.conversation_id AND m.sent_at = t.latest;
SELECT 
    u.name AS sender,
    m.message_text,
    m.sent_at
FROM messages m
JOIN users u ON m.sender_id = u.id
WHERE m.conversation_id = 1
ORDER BY m.sent_at;
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE attendance (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present','Absent') NOT NULL,
    PRIMARY KEY (student_id, course_id, date),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
SELECT 
    s.name,
    SUM(status = 'Present') AS days_present,
    SUM(status = 'Absent') AS days_absent
FROM attendance a
JOIN students s ON a.student_id = s.id
WHERE a.course_id = 1
GROUP BY s.id, s.name;
SELECT 
    s.name, a.status
FROM attendance a
JOIN students s ON a.student_id = s.id
WHERE a.course_id = 1 AND a.date = '2025-08-11';
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
