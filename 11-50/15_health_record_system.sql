-- Patients table
CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL
);

-- Prescriptions table
CREATE TABLE prescriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    prescription_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- Medications table
CREATE TABLE medications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Prescription details (many-to-many between prescriptions and medications)
CREATE TABLE prescription_details (
    prescription_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id),
    FOREIGN KEY (medication_id) REFERENCES medications(id)
);
-- Patients
INSERT INTO patients (name, dob) VALUES
('Amit Verma', '1990-04-15'),
('Sara Khan', '1985-09-20');

-- Medications
INSERT INTO medications (name) VALUES
('Paracetamol'),
('Amoxicillin'),
('Vitamin D');

-- Prescriptions
INSERT INTO prescriptions (patient_id, prescription_date) VALUES
(1, '2025-08-01'),
(2, '2025-08-03');

-- Prescription details
INSERT INTO prescription_details (prescription_id, medication_id, dosage) VALUES
(1, 1, '500mg twice daily'),
(1, 3, '1000 IU once daily'),
(2, 2, '250mg three times daily');
SELECT p.name AS patient_name, pr.id AS prescription_id, pr.prescription_date
FROM prescriptions pr
JOIN patients p ON pr.patient_id = p.id
WHERE p.name = 'Amit Verma';
SELECT pr.id AS prescription_id, m.name AS medication_name, pd.dosage
FROM prescription_details pd
JOIN medications m ON pd.medication_id = m.id
JOIN prescriptions pr ON pd.prescription_id = pr.id
WHERE pr.id = 1;
SELECT p.name AS patient_name, pr.prescription_date, m.name AS medication_name, pd.dosage
FROM prescription_details pd
JOIN medications m ON pd.medication_id = m.id
JOIN prescriptions pr ON pd.prescription_id = pr.id
JOIN patients p ON pr.patient_id = p.id
WHERE p.name = 'Sara Khan'
  AND pr.prescription_date = '2025-08-03';
SELECT DISTINCT p.name AS patient_name, m.name AS medication_name
FROM prescription_details pd
JOIN medications m ON pd.medication_id = m.id
JOIN prescriptions pr ON pd.prescription_id = pr.id
JOIN patients p ON pr.patient_id = p.id
WHERE m.name = 'Paracetamol';
