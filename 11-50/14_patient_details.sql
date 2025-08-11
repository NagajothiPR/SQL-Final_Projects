-- Patients table
CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL
);

-- Doctors table
CREATE TABLE doctors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL
);

-- Visits table
CREATE TABLE visits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    visit_time DATETIME NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);
-- Patients
INSERT INTO patients (name, dob) VALUES
('Amit Verma', '1990-04-15'),
('Sara Khan', '1985-09-20'),
('Ravi Iyer', '1992-12-05');

-- Doctors
INSERT INTO doctors (name, specialization) VALUES
('Dr. Priya Kumar', 'Cardiology'),
('Dr. Ramesh Sharma', 'Orthopedics');

-- Visits
INSERT INTO visits (patient_id, doctor_id, visit_time) VALUES
(1, 1, '2025-08-09 10:00:00'),
(2, 1, '2025-08-09 10:30:00'),
(3, 2, '2025-08-09 11:00:00');
SELECT p.name AS patient_name, d.name AS doctor_name, v.visit_time
FROM visits v
JOIN patients p ON v.patient_id = p.id
JOIN doctors d ON v.doctor_id = d.id
WHERE d.name = 'Dr. Priya Kumar'
  AND DATE(v.visit_time) = '2025-08-09';
SELECT p.name AS patient_name, d.name AS doctor_name, d.specialization, v.visit_time
FROM visits v
JOIN patients p ON v.patient_id = p.id
JOIN doctors d ON v.doctor_id = d.id
WHERE p.name = 'Amit Verma';
DELIMITER $$
CREATE TRIGGER prevent_doctor_overlap
BEFORE INSERT ON visits
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM visits
        WHERE doctor_id = NEW.doctor_id
          AND ABS(TIMESTAMPDIFF(MINUTE, visit_time, NEW.visit_time)) < 30
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Doctor already has an appointment within 30 minutes.';
    END IF;
END$$
DELIMITER ;
SELECT d.name AS doctor_name, DATE(v.visit_time) AS visit_date, COUNT(*) AS total_visits
FROM visits v
JOIN doctors d ON v.doctor_id = d.id
GROUP BY d.name, DATE(v.visit_time)
ORDER BY visit_date, doctor_name;
