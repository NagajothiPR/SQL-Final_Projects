-- 1. Create parent tables first
CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    instructor VARCHAR(100) NOT NULL
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Create the child table after parents exist
CREATE TABLE enrollments (
    course_id INT,
    student_id INT,
    enroll_date DATE,
    PRIMARY KEY (course_id, student_id),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Insert courses
INSERT INTO courses (title, instructor) VALUES
('Database Systems', 'Dr. Priya Kumar'),
('Python Programming', 'Mr. Ramesh Sharma'),
('Data Science Basics', 'Ms. Neha Gupta');

-- Insert students
INSERT INTO students (name, email) VALUES
('Amit Verma', 'amit@example.com'),
('Sara Khan', 'sara@example.com'),
('Ravi Iyer', 'ravi@example.com'),
('Pooja Nair', 'pooja@example.com');

-- Insert enrollments
INSERT INTO enrollments (course_id, student_id) VALUES
(1, 1), -- Amit → Database Systems
(1, 2), -- Sara → Database Systems
(2, 2), -- Sara → Python Programming
(2, 3), -- Ravi → Python Programming
(3, 4); -- Pooja → Data Science Basics
SELECT s.name, s.email
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
WHERE c.title = 'Python Programming';
SELECT c.title, COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.title;
SELECT c.title, c.instructor, e.enroll_date
FROM enrollments e
JOIN courses c ON e.course_id = c.id
JOIN students s ON e.student_id = s.id
WHERE s.name = 'Sara Khan';
SELECT s.name, s.email
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
WHERE e.student_id IS NULL;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
