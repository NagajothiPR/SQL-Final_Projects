CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE invoices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    invoice_date DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE invoice_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_id INT NOT NULL,
    description VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id)
);
INSERT INTO clients (name) VALUES
('ABC Corp'), ('XYZ Pvt Ltd');

INSERT INTO invoices (client_id, invoice_date) VALUES
(1, '2025-08-01'), (2, '2025-08-02');

INSERT INTO invoice_items (invoice_id, description, quantity, rate) VALUES
(1, 'Website Design', 1, 15000),
(1, 'Hosting', 12, 500),
(2, 'Consulting', 5, 2000);
SELECT i.id AS invoice_id, c.name AS client_name,
       SUM(ii.quantity * ii.rate) AS total_amount
FROM invoices i
JOIN clients c ON i.client_id = c.id
JOIN invoice_items ii ON i.id = ii.invoice_id
GROUP BY i.id, c.name;
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
