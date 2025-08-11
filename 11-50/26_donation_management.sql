CREATE TABLE donors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE causes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL
);

CREATE TABLE donations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT NOT NULL,
    cause_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    donated_at DATETIME NOT NULL,
    FOREIGN KEY (donor_id) REFERENCES donors(id),
    FOREIGN KEY (cause_id) REFERENCES causes(id)
);
SELECT c.title, SUM(d.amount) AS total_donations
FROM donations d
JOIN causes c ON d.cause_id = c.id
GROUP BY c.id, c.title;

SELECT 
    c.title,
    SUM(d.amount) AS total_donations,
    RANK() OVER (ORDER BY SUM(d.amount) DESC) AS cause_rank
FROM donations d
JOIN causes c ON d.cause_id = c.id
GROUP BY c.id, c.title;
