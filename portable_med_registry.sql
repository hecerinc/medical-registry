CREATE DATABASE `med_registry`;
USE `med_registry`;
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



# -----------------------------------------------------------------
#                        Relational Model
# -----------------------------------------------------------------

Patients(ssid, fname, lname, sex, dob, address, weight, height, phone)
PK(id)

Labtest_Catalog(id, exam, test)
PK(id)

# Instance of labtest
Labtests(id, test_id, date, patient_id, doctor_id)
PK(id)
FK(test_id) references Labtest_Catalog(id)
FK(patient_id) references patients(ssid)
FK(doctor_id) references Doctors(id)

Results(id, parameter, value, min, max, comments, labtest_id)
PK(id)
FK(labtest_id) references Labtests(id)

Visits(id, date, patient_id, doctor_id, comments)
PK(id)
FK(patient_id) references patients(ssid)
FK(doctor_id) references Doctors(id)

Doctors(id, fname, lname, cedula, address, office_location, phone, field)
PK(id)

Medicine_Catalog(id, generic_name, commercial_name, manufacturer, unit_price, qpu) #qpu = quanity per unit
PK(id)

Prescriptions(id, date, visit_id)
PK(id)
FK(visit_id) references Visits(id)

Prescription_Details(id, start_date, end_date, dosage, indications, medicine_id, prescription_id)
PK(id)
FK(medicine_id) references Medicine_Catalog(id)
FK(prescription_id) references Prescriptions(id)

# Further indications
Prescription_Indications(id, comments, prescription_id)
PK(id)
FK(prescription_id) references Prescriptions(id)

