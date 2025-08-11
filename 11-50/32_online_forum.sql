SELECT p1.id AS post_id, p1.content AS parent_post, p2.content AS reply
FROM posts p1
JOIN posts p2 ON p1.id = p2.parent_post_id;
SELECT t.title, COUNT(p.id) AS total_posts
FROM threads t
JOIN posts p ON t.id = p.thread_id
GROUP BY t.id, t.title;
