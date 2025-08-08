CREATE TABLE IF NOT EXISTS suppliers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS inventory_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    supplier_id INT,
    action ENUM('IN', 'OUT') NOT NULL,
    qty INT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);
DELIMITER //

CREATE TRIGGER trg_update_stock
AFTER INSERT ON inventory_logs
FOR EACH ROW
BEGIN
    IF NEW.action = 'IN' THEN
        UPDATE products
        SET stock = stock + NEW.qty
        WHERE id = NEW.product_id;
    ELSE
        UPDATE products
        SET stock = stock - NEW.qty
        WHERE id = NEW.product_id;
    END IF;
END;
//

DELIMITER ;
SELECT 
    id, name, stock,
    CASE 
        WHEN stock = 0 THEN 'Out of Stock'
        WHEN stock < 10 THEN 'Low Stock'
        ELSE 'Sufficient'
    END AS status
FROM products;
