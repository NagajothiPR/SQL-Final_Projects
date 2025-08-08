-- Step 1: Create the categories table
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Step 2: Create the brands table
CREATE TABLE brands (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Step 3: Create the products table
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    image_url VARCHAR(255),
    category_id INT,
    brand_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (brand_id) REFERENCES brands(id)
);
INSERT INTO brands (name) VALUES 
('Apple'), 
('Nike'), 
('Samsung');
INSERT INTO products (name, description, price, stock, image_url, category_id, brand_id)
VALUES 
('iPhone 15', 'Latest iPhone model', 999.99, 50, 'iphone15.jpg', 1, 1),
('Nike Air Max', 'Running shoes', 199.99, 100, 'airmax.jpg', 2, 2),
('Galaxy S23', 'Android flagship', 849.00, 70, 'galaxys23.jpg', 1, 3),
('Basic T-Shirt', 'Cotton T-shirt', 19.99, 200, 'tshirt.jpg', 2, 2),
('E-Book Reader', '6-inch screen e-reader', 120.00, 30, 'ebook.jpg', 1, 3);
SELECT 
    p.id, p.name, p.price, p.stock, 
    c.name AS category, 
    b.name AS brand
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.id
JOIN 
    brands b ON p.brand_id = b.id;