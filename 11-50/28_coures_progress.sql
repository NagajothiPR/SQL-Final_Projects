CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE lessons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE progress (
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    completed_at DATETIME,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (lesson_id) REFERENCES lessons(id)
);
SELECT 
    p.student_id,
    l.course_id,
    ROUND(
        100.0 * COUNT(p.completed_at) / COUNT(l.id), 2
    ) AS completion_percentage
FROM lessons l
LEFT JOIN progress p ON l.id = p.lesson_id
GROUP BY p.student_id, l.course_id;
