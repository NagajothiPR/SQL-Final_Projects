CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    message VARCHAR(255) NOT NULL,
    status ENUM('Unread','Read') DEFAULT 'Unread',
    created_at DATETIME NOT NULL
);
SELECT user_id, COUNT(*) AS unread_count
FROM notifications
WHERE status = 'Unread'
GROUP BY user_id;
UPDATE notifications
SET status = 'Read'
WHERE user_id = 1 AND status = 'Unread';
