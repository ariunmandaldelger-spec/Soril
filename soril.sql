DROP DATABASE IF EXISTS hospital_db;
CREATE DATABASE hospital_db;
USE hospital_db;

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15) UNIQUE
);

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    phone VARCHAR(15) UNIQUE
);

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medicine VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

INSERT INTO patients (name, age, gender, phone) VALUES
('Bat',25,'Male','99112233'),
('Sara',30,'Female','88112233'),
('Bold',40,'Male','99113344');

INSERT INTO doctors (name, specialty, phone) VALUES
('Dr.Amar','Cardiologist','99110000'),
('Dr.Bold','Dentist','88110000');

INSERT INTO appointments (patient_id, doctor_id, appointment_date) VALUES
(1,1,'2025-03-01'),
(2,1,'2025-03-02'),
(1,2,'2025-03-03'),
(3,1,'2025-03-04');

INSERT INTO prescriptions (appointment_id, medicine, dosage) VALUES
(1,'Paracetamol','2/day'),
(2,'Ibuprofen','1/day'),
(3,'Vitamin C','1/day');

SELECT p.name, d.name, a.appointment_date
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

SELECT d.name, COUNT(*) 
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name;

SELECT d.name, COUNT(*) AS total
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name
ORDER BY total DESC
LIMIT 1;

SELECT p.name, COUNT(*) 
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.name
HAVING COUNT(*) >= 2;

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'report_user'@'localhost' IDENTIFIED BY '1234';

GRANT ALL PRIVILEGES ON hospital_db.* TO 'admin_user'@'localhost';
GRANT SELECT ON hospital_db.* TO 'report_user'@'localhost';

FLUSH PRIVILEGES;
