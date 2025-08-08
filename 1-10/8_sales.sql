CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS leads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    source VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS deals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lead_id INT NOT NULL,
    user_id INT NOT NULL,
    stage ENUM('Prospect', 'Qualified', 'Proposal', 'Won', 'Lost') NOT NULL,
    amount DECIMAL(10, 2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (lead_id) REFERENCES leads(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
-- Users
INSERT INTO users (name) VALUES 
('Alice'), ('Bob');

-- Leads
INSERT INTO leads (name, source) VALUES 
('Acme Corp', 'Email'), 
('Beta LLC', 'Web'), 
('Gamma Inc', 'Referral');

-- Deals
INSERT INTO deals (lead_id, user_id, stage, amount, created_at) VALUES 
(1, 1, 'Prospect', 5000, '2025-08-01'),
(1, 1, 'Qualified', 5000, '2025-08-02'),
(2, 2, 'Prospect', 3000, '2025-08-03'),
(2, 2, 'Proposal', 3000, '2025-08-04'),
(3, 1, 'Prospect', 8000, '2025-08-02'),
(3, 1, 'Won', 8000, '2025-08-06');
WITH RankedDeals AS (
  SELECT 
    d.*, 
    ROW_NUMBER() OVER (PARTITION BY lead_id ORDER BY created_at DESC) AS rn
  FROM deals d
)
SELECT 
  rd.lead_id, 
  l.name AS lead_name,
  rd.stage,
  rd.amount,
  rd.created_at
FROM RankedDeals rd
JOIN leads l ON rd.lead_id = l.id
WHERE rd.rn = 1;
SELECT 
  d.id, l.name AS lead_name, d.stage, d.amount, d.created_at
FROM 
  deals d
JOIN 
  leads l ON d.lead_id = l.id
WHERE 
  d.user_id = 1
ORDER BY 
  d.created_at DESC;
SELECT 
  d.*, l.name AS lead_name
FROM 
  deals d
JOIN leads l ON d.lead_id = l.id
WHERE 
  MONTH(d.created_at) = 8 AND YEAR(d.created_at) = 2025;

