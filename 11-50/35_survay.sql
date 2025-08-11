SELECT q.question_text, COUNT(r.answer_text) AS total_responses
FROM questions q
JOIN responses r ON q.id = r.question_id
GROUP BY q.question_text;
SELECT q.question_text,
SUM(CASE WHEN r.answer_text='Yes' THEN 1 ELSE 0 END) AS yes_count,
SUM(CASE WHEN r.answer_text='No' THEN 1 ELSE 0 END) AS no_count
FROM questions q
JOIN responses r ON q.id = r.question_id
GROUP BY q.question_text;
