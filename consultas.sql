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

--Catalogo de prescripciones con detalles e indicaciones para una visita en particular 
/* START QUERY --------------------------------------------------------------------------- */
SELECT 
	v.date as 'Fecha de Cita',
	m.commercial_name as 'Medicina',
	d.dosage as 'Dosis',
	d.indications as 'Indicaciones',
	i.comments as 'Comentario adicionales',
	m.unit_price as 'Precio',
	d.start_date as 'Fecha inicio', 
	d.end_date as 'Fecha final'
FROM prescriptions p 
	JOIN details d ON p.id= d.prescription_id
	JOIN medicine_catalog m ON d.medicine_id= m.id
	JOIN indications i ON p.id= i.prescription_id 
	JOIN visits v ON v.id= p.visit_id
WHERE v.id=108
ORDER BY v.date ASC;

--Despliega una receta con el id de una visita
SELECT d.fname as 'Nombre Dr', d.lname as 'Apellido', cedula as 'Cédula Profesional', office_location, field
FROM doctors d, patients p, visits v
WHERE v.id=108 AND d.id=v.doctor_id AND p.ssid=v.patient_id;

SELECT fname as 'Nombre', 
lname as 'Apellido', 
(DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), dob)), "%Y")+0 ) as 'Edad',
weight as 'Peso', 
height as 'Estatura', 
v.date as 'Fecha',
v.comments as 'Diagnostico'
FROM patients p, visits v
WHERE v.id=108 AND p.ssid=v.patient_id;

SELECT p.id as 'Prescription #',
m.generic_name as 'Nombre',
m.commercial_name as 'Commercial', 
d.dosage as 'dosis', 
d.indications as 'Indicaciones' ,
i.comments as 'Commentarios add',
d.start_date as 'Inicio' ,
d.end_date as 'fin'
FROM prescriptions p, details d, medicine_catalog m, indications i, visits v
WHERE v.id=108 AND p.visit_id=v.id AND p.id=d.prescription_id AND d.medicine_id= m.id AND p.id=i.prescription_id;

/* END QUERY ------------------------------------------------------------------------------------------------------ */



-- TODO
-- RECETAS EN UN ANO
-- Todas las prescripciones (recetas) (un paciente)
SELECT 
	fname as 'Nombre',
	lname as 'Apellido',
	dob as 'Fecha de Nacimiento',
	commercial_name as 'Medicamento',
	generic_name as 'Tipo',
	dosage as 'Dosis', 
	indications as 'Indicaciones'
FROM patients 
	JOIN visits ON patients.ssid = visits.patient_id
	JOIN prescriptions ON visits.id = prescriptions.visit_id
	JOIN details ON prescriptions.id =  details.prescription_id
	JOIN medicine_catalog ON details.medicine_id=  medicine_catalog.id
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



select 'Examenes de laboratorio';
select distinct lc.nombre, fecha
from patients p join labtests l on p.id = l.idPaciente join results r
on r.idLabTest = l.id join labtestcatalogs lc on lc.id = l.idLabtestcatalog
where p.nombre = 'Juan 'and p.apellido = 'Perez';

select doctors.fname as 'Nombre',
doctors.lname as 'Apellido',
details.id as 'ID de la prescripción',
details.start_date as 'Fecha de inicio', 
details.end_date as 'Fecha de fin',
details.indications as 'Indicaciones'
from doctors join visits on doctors.id = doctor_id join prescriptions on visits.id = visit_id join details on prescriptions.id = prescription_id
where doctors.id = 7;



SELECT fname as 'Nombre',
lname as 'Apellido',
dob as 'Fecha de Nacimiento',
commercial_name as 'Medicamento',
generic_name as 'Tipo',
dosage as 'Dosis', 
indications as 'Indicaciones'
FROM patients JOIN visits ON patients.ssid= visits.patient_id
JOIN prescriptions ON visits.id= prescriptions.visit_id
JOIN details ON prescriptions.id= details.prescription_id
JOIN medicine_catalog ON details.medicine_id= medicine_catalog.id
WHERE fname='Martin' AND lname='Murillo';


/* Uriel */

/*
Detalles de la ultima consulta de un paciente
Es importante para el doctor saber cuando fue la ultima consulta que tuvo con un paciente para verificar si la información que tiene sobre él aun es util
o es necesario realizar nuevos examenes. Este reporte muestra los detalles de la utlima visita del paciente entre lo que se encuentra
la fecha de dicha visita, el peso y altura en ese momento, nombre y numero de seguro social y otros datos como el telefono y la direccion.
*/
SELECT
MAX(visits.date) AS 'Ultima visita',
patients.ssid AS 'Numero de Seguro Social',
patients.fname AS 'Nombre del Paciente', 
patients.lname AS 'Apellido del Paciente',
patients.phone AS 'Telefono',
patients.address AS 'Direccion',
visits.height AS 'Altura',
visits.weight AS 'Peso',
visits.comments AS 'Comentarios',
doctors.fname AS 'Nombre Doctor',
doctors.lname AS 'Apellido Doctor'
FROM patients INNER JOIN visits ON ssid = patient_id INNER JOIN doctors
ON doctors.id = doctor_id
WHERE patients.fname = 'Martin' AND patients.lname = 'Murillo'


/*
Visitas de un paciente ordenadas de la mas reciente a la mas antigua
Es importante para el doctor estar al tanto de las consultas que ha tenido su paciente para comprobar como va progresando su estado.
Esta consulta muestra todas las consultas que ha tenido un paciente en el hospital desde la mas reciente hasta la primera.
*/
SELECT
visits.date AS 'Fecha de visita',
patients.ssid AS 'Numero de Seguro Social',
patients.fname AS 'Nombre del Paciente', 
patients.lname AS 'Apellido del Paciente',
patients.phone AS 'Telefono',
patients.address AS 'Direccion',
visits.height AS 'Altura',
visits.weight AS 'Peso',
visits.comments AS 'Comentarios',
doctors.fname AS 'Nombre Doctor',
doctors.lname AS 'Apellido Doctor'
FROM patients INNER JOIN visits ON ssid = patient_id INNER JOIN doctors
ON doctors.id = doctor_id
WHERE patients.fname = 'Martin' AND patients.lname = 'Murillo'
ORDER BY visits.date DESC




select  p.fname as 'Nombre Paciente',
p.lname as 'Apellido Paciente',
v.comments as 'Diagnostico', 
d.fname as 'Nombre Doctor',
d.lname as 'Apellido Doctor' 
from patients p join visits v 
on p.ssid = v.patient_id 
join doctors d on v.doctor_id = d.id 
WHERE v.date = getdate();
