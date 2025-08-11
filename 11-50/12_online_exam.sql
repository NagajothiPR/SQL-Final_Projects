-- Exams table
CREATE TABLE exams (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    exam_date DATE NOT NULL
);

-- Questions table
CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    exam_id INT NOT NULL,
    question_text VARCHAR(255) NOT NULL,
    correct_option CHAR(1) NOT NULL,
    FOREIGN KEY (exam_id) REFERENCES exams(id)
);

-- Student Answers table
CREATE TABLE student_answers (
    student_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_option CHAR(1) NOT NULL,
    PRIMARY KEY (student_id, question_id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);
-- Exams
INSERT INTO exams (course_id, exam_date) VALUES
(101, '2025-08-01'),
(102, '2025-08-05');

-- Questions
INSERT INTO questions (exam_id, question_text, correct_option) VALUES
(1, 'What is SQL?', 'A'),
(1, 'Which is a primary key?', 'B'),
(2, 'What is Python?', 'A'),
(2, 'Which is a loop?', 'C');

-- Student Answers
INSERT INTO student_answers (student_id, question_id, selected_option) VALUES
(1, 1, 'A'), -- correct
(1, 2, 'B'), -- correct
(1, 3, 'B'), -- wrong
(1, 4, 'C'), -- correct
(2, 1, 'B'), -- wrong
(2, 2, 'B'), -- correct
(2, 3, 'A'), -- correct
(2, 4, 'B'); -- wrong
SELECT e.id AS exam_id, q.id AS question_id, q.question_text,
       sa.selected_option, q.correct_option
FROM student_answers sa
JOIN questions q ON sa.question_id = q.id
JOIN exams e ON q.exam_id = e.id
WHERE sa.student_id = 1;
SELECT sa.student_id, e.id AS exam_id,
       SUM(CASE WHEN sa.selected_option = q.correct_option THEN 1 ELSE 0 END) AS score,
       COUNT(q.id) AS total_questions
FROM student_answers sa
JOIN questions q ON sa.question_id = q.id
JOIN exams e ON q.exam_id = e.id
WHERE sa.student_id = 1
GROUP BY sa.student_id, e.id;
SELECT sa.student_id, e.id AS exam_id,
       SUM(CASE WHEN sa.selected_option = q.correct_option THEN 1 ELSE 0 END) AS score,
       COUNT(q.id) AS total_questions
FROM student_answers sa
JOIN questions q ON sa.question_id = q.id
JOIN exams e ON q.exam_id = e.id
GROUP BY sa.student_id, e.id;
