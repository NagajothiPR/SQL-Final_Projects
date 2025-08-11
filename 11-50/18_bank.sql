CREATE TABLE accounts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    balance DECIMAL(12,2) DEFAULT 0
);

CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    type ENUM('deposit','withdrawal') NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    txn_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);
INSERT INTO accounts (user_id, balance) VALUES
(1, 5000), (2, 10000);

INSERT INTO transactions (account_id, type, amount) VALUES
(1, 'deposit', 2000),
(1, 'withdrawal', 1000),
(2, 'deposit', 5000);
WITH txn_summary AS (
    SELECT account_id,
           SUM(CASE WHEN type='deposit' THEN amount ELSE -amount END) AS net_change
    FROM transactions
    GROUP BY account_id
)
SELECT a.id AS account_id, a.balance + IFNULL(t.net_change,0) AS current_balance
FROM accounts a
LEFT JOIN txn_summary t ON a.id = t.account_id;
