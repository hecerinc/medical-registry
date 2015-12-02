--# Doctores
INSERT INTO doctors(id, fname, lname, cedula, address, office_location, phone, field) VALUES
(12, 'Jose', 'Gonzalez', 289147014,'271 Miguel Hidalgo, Monterrey','Doctors Hospital', '81712583627', 'Cardiology'),
(45, 'Juan', 'Gutiérrez', 2808025805,'313 Constitución, Monterrey', 'Hospital San Jose','87351657823', 'Pediatrist'),
(07, 'Eugenio', 'Rangel',480602866, '271 Miguel Hidalgo, Monterrey','Doctors Hospital', '81712583627', 'Ginecology'),
(01, 'Pedro', 'Cazares', 258068022,'111 Ignacio Allende, Monterrey','Hospital San Jose', '81752383447', 'Neurology'),
(99, 'Pedro', 'Cazares', 870304803,'222 Calle Zaragoza, Monterrey', 'Hospital San Jose','81752383453', 'Podology'),
(89, 'Lucia', 'Medrano', 849334876, '432 Avenida del sol, Monterrey', 'Hospital San Jose', '8132775849', 'Cardiology'),
(55, 'Sofia', 'Torres', 387635629, '121 Colonia Roma, Monterrey', 'Hospital Zambrano Helion', '8154773248', 'Optometry'),
(79, 'Lena', 'Mazza', 784938443, '35 Garza Sada, Monterrey', 'Hospital Zambrano Helion', '8145785989', 'Dermatology'),
(69, 'Maria', 'Fernandez', 8392754434, '123 Privada Margarita, Monterrey', 'Hospital San Jose', '811789875','Gastroenterology');
 
--#Patient

#Patient
INSERT INTO patients(ssid, fname, lname, sex, dob, address, weight, height, phone) VALUES
(183018031, 'Martin', 'Murillo','M', '1980-02-23','Main Street 253', 60.2, 1.67, '81190817508'),
(802850253, 'Luis', 'Romo','M', '1980-02-23','Revolution 863',  60.2, 1.67, '81190817508'),
(280580223, 'Gabriela', 'Navarro', 'F', '1995-08-17','Cumbres 103', 60.2, 1.67, '81190817508'),
(106960860, 'Edgar', 'Alanis','M', '1980-02-23', 'Columbus 962',60.2, 1.67, '81190817508'),
(168028492, 'Ninfa', 'Garza','F', '1995-08-17','Country 524', 60.2, 1.67, '81190817508'),
(574835467, 'Ricardo', 'Froto','M', '1978-03-12', 'Colonia Nevada 1830', 70.0, 1.78, '8113245869'),
(493049584, 'Carla', 'Canseco', 'F', '1992-02-22', 'Lomas del Mirador 219', 59.4, 1.70, '814549695'),
(432594832, 'Valeria', 'Martinez', 'F', '1992-04-04' 'Lazaro Cardena 4000', 58.3, 1.71, '8115772349'),
(384930203, 'Emilia', 'Guzman', 'F', '1988-05-10', 'Sierra Nevada 45', 59.3, 1.72, '8113485211'),
(438293492, 'Carolina', 'Marcos', 'F', '1974-12-12', 'Palo Blanco 82', 55.4, 1.68, '815644392'),
(123492334, 'Pedro', 'Iga', 'M', '1993-01-23', 'San Agustin 432', 70.4, 1.77, '8145334289')
(198463211, 'Raul', 'Vela', 'M', '1969-06-09', 'Bosques del Valle 103', 79.7, 1.76, '8143258639;');
 
 
--# Medicina
 INSERT INTO medicine_catalog (id, generic_name, commercial_name, manufacturer, unit_price, qpu) VALUES
(1, 'Acetaminophen','Excedrin', 'Novartis', 18.99, 30),
(2, 'Acetaminophen','Tylenol Extra Strength', 'McNeil', 14.99, 15),
(3, 'Ibuprofen','Advil Tablets', 'Novartis', 19.99, 25),
(4, 'Aspirin','Genuine Bayer Aspirin', 'Bayer', 8.99, 20),
(5, 'Oxymetazoline nasal','Afrin 12 Hours', 'Bayer', 5.99, 15),
(6, 'Methylphenidate', 'Concerta', 'Johnson & Johnson', 89.99, 30),
(7, 'Alprazolam', 'Xanax', 'Pfizer', 22.99, 90),
(8, 'Azithromycin', 'Zithromax', 'Pfizer', 13.99, 6),
(9, 'Acetaminophen', 'Vicodin', 'Abbvie', 189.99, 100),
(10, 'Hydrocodone', 'Hysingla ER', 'Purdue', 426.89, 60);

--#Visits
INSERT INTO visits(id, date, comments, patient_id, doctor_id) VALUES
(108, '2015-08-19', 'El paciente tiene dolor de cabeza', 183018, 12),
(186, '2015-09-11', 'El paciente sufre de dolor de espalda', 802850, 45),
(067, '2015-04-20', 'La paciente sufre de alergias', 280580, 07),
(003, '2014-12-22', 'El paciente tiene la garganta inflamada', 106960, 01),
(099, '2015-07-07', 'La paciente tiene la nariz tapada', 168028, 99);

--#Prescription
INSERT INTO prescriptions(id, DATE, visit_id) VALUES
(564738,'2015-08-19', 108),
(324527,'2015-09-11', 186),
(897667,'2015-04-20', 067),
(213389,'2014-12-22', 003),
(463748,'2015-07-07', 099);

--#Prescription Details
INSERT INTO details(id, start_date, end_date, dosage, indications, medicine_id, prescription_id) VALUES
(1, '2015-08-19', '2015-09-04', '2 pastillas','Tomar 1 en la mañana y otra en la tarde', 1, 564738),
(2, '2015-09-11', '2015-10-11', '1 pastilla', 'Tomarse 1 en la mañana', 2, 324527),
(3, '2015-04-20', '2015-04-28', '1/2 tableta', 'Tomarse 1 a cualquier hora del dia', 3, 897667),
(4, '2014-12-22', '2014-12-31', '3 pastillas', '1 en la mañana, otra a medio dia, 1 en la tarde', 4, 213389),
(5, '2015-07-07', '2015-07-12', '1 aprieto', 'Ingerir antes del medio dia', 5, 463748);

--#Prescription Indications
INSERT INTO indications(id, comments, prescription_id) VALUES
(1, 'Esperarse 6 horas antes de tomarse la otra pastilla', 564738),
(2, 'No tomarse mas de 1 pastilla al dia', 324527),
(3, 'Si no se pasan los sintomas en 12 horas tomarse otra dosis;', 897667),
(4, 'No ingerir mas de 3 pastillas en 24 horas', 213389),
(5, 'Si no se cura en 2 dias, se puede duplicar la dosis', 463748);

INSERT INTO labtest_catalog(id, exam, test) VALUES
(1, 'Biometria Hematica Completa', 'Globulos blancos'),
(2, 'Biometria Hematica Completa', 'Linfocitos (%)'),
(3, 'Biometria Hematica Completa', 'Monocitos (%)'),
(4, 'Biometria Hematica Completa', 'Eosinofilos (%)'),
(5, 'Biometria Hematica Compelta', 'Basofilos (%)');

INSERT INTO labtests(id, test_id, date, patient_id, doctor_id) VALUES
(1, 1, '2015-11-16', 280580, 12),
(2, 4, '2015-11-16', 106960, 45),
(3, 5, '2015-08-27', 168028, 7),
(4, 2, '2014-04-15', 183018, 1),
(5, 3, '2015-02-22', 183018, 99);

INSERT INTO results(id, parameter, value, min, max, comments, labtest_id) VALUES
(1, 'Globulos blancos', 13.04, 4.5,10.5, NULL, 1),
(2, 'Linfocitos (%)', 4.4,13,48, NULL, 2),
(3, 'Monocitos (%)', 5.14, 1, 13, NULL, 3),
(4, 'Eosinofilos (%)',1.9,0,7,NULL, 4),
(5, 'Basofilos (%)', 0.7,0,3, NULL, 5);


INSERT INTO results(id, parameter, value, min, max, comments, labtest_id) VALUES
(1, 'Globulos blancos', 13.04, 4.5,10.5, NULL, 1),
(2, 'Linfocitos (%)', 4.4,13,48, NULL, 2),
(3, 'Monocitos (%)', 5.14, 1, 13, NULL, 3),
(4, 'Eosinofilos (%)',1.9,0,7,NULL, 4),
(5, 'Basofilos (%)', 0.7,0,3, NULL, 5)
(6, 'Neutrofilos', 88.2, 36, 74, NULL, 4)
(7, 'Cetonas', 15, 0, 2.8, NULL, 4)
(8, 'Glucosa', 119, 70, 100, NULL, 4)
(9, 'Plaquetas', 266, 140, 400, NULL, 4)
(10, 'Hematocrito', 42.8, 41, 53, NULL, 4);