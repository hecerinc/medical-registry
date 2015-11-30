CREATE DATABASE med_registry;
GO
USE med_registry;
GO
CREATE TABLE patients(
	ssid INT NOT NULL,
	fname VARCHAR(255),
	lname VARCHAR(255),
	sex CHAR(1),
	dob DATE,
	address TEXT,
	weight FLOAT,
	height FLOAT,
	phone VARCHAR(255),
	PRIMARY KEY(ssid)
);
CREATE TABLE doctors(
	id INT NOT NULL,
	fname VARCHAR(255),
	lname VARCHAR(255),
	cedula INT NOT NULL,
	address TEXT,
	office_location TEXT,
	phone VARCHAR(255),
	field VARCHAR(255),
	PRIMARY KEY(id)
);

CREATE TABLE labtest_catalog(
	id INT NOT NULL,
	exam VARCHAR(255),
	test VARCHAR(255),
	PRIMARY KEY(id)
);
CREATE TABLE labtests(
	id INT NOT NULL,
	date DATE,
	test_id INT NOT NULL,
	patient_id INT NOT NULL, 
	doctor_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(test_id) REFERENCES labtest_catalog(id),
	FOREIGN KEY(patient_id) REFERENCES patients(ssid),
	FOREIGN KEY(doctor_id) REFERENCES doctors(id)
);

CREATE TABLE visits(
	id INT NOT NULL,
	date DATETIME,
	comments TEXT,
	patient_id INT NOT NULL,
	doctor_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(patient_id) REFERENCES patients(ssid),
	FOREIGN KEY(doctor_id) REFERENCES doctors(id)
);
CREATE TABLE medicine_catalog(
	id INT NOT NULL,
	generic_name VARCHAR(255),
	commercial_name VARCHAR(255),
	manufacturer VARCHAR(255),
	unit_price DECIMAL(19, 4),
	qpu VARCHAR(255), /* qpu = quantity per unit,*/
	PRIMARY KEY(id)
);
CREATE TABLE prescriptions(
	id INT NOT NULL,
	date DATETIME,
	visit_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(visit_id) REFERENCES visits(id)
);
CREATE TABLE details(
	id INT NOT NULL,
	start_date DATETIME,
	end_date DATETIME,
	dosage VARCHAR(255),
	indications VARCHAR(255),
	medicine_id INT NOT NULL,
	prescription_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(medicine_id) REFERENCES medicine_catalog(id),
	FOREIGN KEY(prescription_id) REFERENCES prescriptions(id)
);
CREATE TABLE indications(
	id INT NOT NULL,
	comments TEXT,
	prescription_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(prescription_id) REFERENCES prescriptions(id)
);
CREATE TABLE results(
	id INT NOT NULL,
	parameter VARCHAR(255),
	value VARCHAR(255),
	min DECIMAL,
	max DECIMAL,
	comments TEXT,
	labtest_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(labtest_id) REFERENCES labtests(id)
);
