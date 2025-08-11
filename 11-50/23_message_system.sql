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
    u.name AS sender,
    m.message_text,
    m.sent_at
FROM messages m
JOIN users u ON m.sender_id = u.id
JOIN (
    SELECT conversation_id, MAX(sent_at) AS latest_time
    FROM messages
    GROUP BY conversation_id
) latest ON m.conversation_id = latest.conversation_id 
         AND m.sent_at = latest.latest_time;
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
WHERE a.course_id = 1 
  AND a.date = '2025-08-11';
