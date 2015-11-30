# ---------------------------------------------
# 
#		Documento para poner sus consultas
# 	
#
#	1. Fork the repo
#	2. Add your queries here
#	3. Create pull request
# ---------------------------------------------


/* Hector */
/*
	Reporte de historial de examenes de un paciente

	El reporte que genera es un historial de los examenes que se ha realizado un paciente arbitrario junto con la fecha
	Este listado es pertinenete para el doctor puesto que puede ver los exámenes que un paciente se ha realizado lo cual puede ayudar a diagnosticar una condición
	Dependiendo del mal que lo aqueja, puede ver el tipo de examen que arrojaría resultados que pudieran indicar una condición
*/
SELECT date, exam, test
FROM patients 
	JOIN labtests ON patients.ssid = labtests.patient_id 
	JOIN labtest_catalog ON labtests.test_id = labtest_catalog.id 
WHERE ssid = 280580223;

-- Resultados de un examen
/*
	Reporte de resultados de un examen específico

	El reporte de los resultados de un examen de laboratorio incluye los datos del paciente, los parámetros evaluados en el examen, el valor del parámetro, valores máximos y mínimos de referencia y comentarios adicionales del laboratorio o doctor. Esto es pertinente para el doctor para diagnosticar una condición de acuerdo a un parámetro, proveyendo valores de referencia para facilitar el diagnóstico.
*/
SELECT date, fname, lname, parameter, value, min, max, comments 
FROM labtests 
	JOIN results ON labtest_id = labtests.id 
	JOIN patients ON patient_id = patients.ssid 
WHERE labtests.id = 2;

/* Eugenio */

--Catalogo de prescriptines con detalles e indicaciones para una visita en particular 
SELECT 
v.date as 'Fecha de Cita',
m.commercial_name as 'Medicina',
d.dosage as 'Dosis',
d.indications as 'Indicaciones',
i.comments as 'Comentario adicionales',
m.unit_price as 'Precio',
d.start_date as 'Fecha inicio', 
d.end_date as 'Fecha final'
FROM prescriptions p JOIN details d ON p.id= d.prescription_id
JOIN medicine_catalog m ON d.medicine_id= m.id
JOIN indications i ON p.id= i.prescription_id 
JOIN visits v ON v.id= p.visit_id
WHERE v.id=108
Order BY v.date ASC;


-- Prescripciones de Martin Murillo (un paciente)
SELECT fname, lname, dob, commercial_name, dosage, indications
FROM patients JOIN visits ON patients.ssid= visits.patient_id
JOIN prescriptions ON visits.id= prescriptions.visit_id
JOIN details ON prescriptions.id= details.prescription_id
JOIN medicine_catalog ON details.medicine_id= medicine_catalog.id
WHERE fname='Martin' AND lname='Murillo';


/* Hemkes */
/*El nombre del paciente(Orden Alfabetico), diagnostico del 
doctor, doctor encargado de la revision y la fecha 
en la cual se llevo a cabo la cita
*/
select  p.fname as 'Nombre Paciente',
 p.lname as 'Apellido Paciente',
 v.comments as 'Diagnostico', 
 d.fname as 'Nombre Doctor',
 d.lname as 'Apellido Doctor', 
 v.date as 'Fecha'
from patients p join visits v 
on p.ssid = v.patient_id 
join doctors d on v.doctor_id = d.id 
order by p.fname ASC;
 
/*Muestra los medicamentos(Ordenados por precio), el precio
de cada medicamento, la forma en la que deben usarse
y la dosis */

select m.commercial_name as 'Medicamento', 
m.unit_price as 'Precio',
de.indications as 'Indicaciones',
de.dosage as 'Dosis'
from medicine_catalog m join details de 
on m.id = de.medicine_id
order by m.unit_price DESC;





/* Uriel */


-- Pacientes mujeres que son atendidas por doctores del Hospital San Jose
select patients.fname, patients.lname
from patients INNER JOIN visits on ssid = patient_id INNER JOIN doctors on doctors.id = doctor_id
where sex = 'F' AND office_location = 'Hospital San Jose';

-- Detalles de las prescripciones escritas por el doctor Eugenio Rangel
select doctors.fname, doctors.lname, details.id, details.start_date, details.end_date, details.indications 
from doctors join visits on doctors.id = doctor_id join prescriptions on visits.id = visit_id join details on prescriptions.id = prescription_id
where doctors.id = 07;