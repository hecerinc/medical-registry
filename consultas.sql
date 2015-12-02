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
SELECT CONCAT(fname, ' ', lname) AS 'Nombre' FROM patients WHERE ssid = 106960;
SELECT date, exam
FROM patients 
	JOIN labtests ON patients.ssid = labtests.patient_id 
	JOIN labtest_catalog ON labtests.test_id = labtest_catalog.id 
WHERE ssid = 106960;

/*
	Reporte de resultados de un examen específico

	El reporte de los resultados de un examen de laboratorio incluye los datos del paciente, los parámetros evaluados en el examen, el valor del parámetro, valores máximos y mínimos de referencia y comentarios adicionales del laboratorio o doctor. Esto es pertinente para el doctor para diagnosticar una condición de acuerdo a un parámetro, proveyendo valores de referencia para facilitar el diagnóstico.
*/
SELECT 'Reporte de examen de laboratorio';
SELECT fname AS 'Nombre', lname AS 'Apellido', date, exam
FROM patients 
	JOIN labtests ON labtests.patient_id = patients.ssid
	JOIN labtest_catalog ON labtest_catalog.id = labtests.test_id
WHERE labtests.id = 2;
SELECT parameter as 'Parametro', value as 'Valor', min, max, comments as 'Comentarios'
FROM labtests 
	JOIN results ON labtest_id = labtests.id 
	JOIN patients ON patient_id = patients.ssid 
WHERE labtests.id = 2;



/* Eugenio */
/* ------------------------------------------------------------------------------------------------------------------ */
/* 
 *
 *
 *		QUERY # 2
 *
 *		Catalogo de prescripciones con detalles e indicaciones para una visita en particular 
*/
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



/*
*
*
*		QUERY 4
*
*/


SELECT
	p.fname as 'Nombre',
	p.lname as 'Apellido',
	DATEDIFF(hour, dob, GETDATE())/8766 AS 'Edad'
FROM patients p
WHERE p.ssid = 123492;

SELECT 
	mc.generic_name, 
	mc.commercial_name,
	mc.manufacturer, 
	COUNT(*) AS 'times_prescribed' 
FROM visits 
	JOIN prescriptions ON prescriptions.visit_id = visits.id 
	JOIN details ON details.prescription_id = prescriptions.id
	JOIN medicine_catalog mc ON details.medicine_id = mc.id
WHERE patient_id = 123492 AND YEAR(prescriptions.date) = '2015'
GROUP BY mc.generic_name, mc.commercial_name, mc.manufacturer;


/* Finished Eugenio */
/* ------------------------------------------------------------------------------------------------------------- */


/* Hemkes */
/* -------------------------------------------------------------------------------------------------------------- */

/*
	El nombre del paciente(Orden Alfabetico), diagnostico del doctor, doctor encargado de la revision y la fecha en la cual se llevo a cabo la cita
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

/* Finished Hemkes */
/* -----------------------------------------------------------------------------------------------------*/




/* Uriel */

/*
	Detalles de la ultima consulta de un paciente
	Es importante para el doctor saber cuando fue la ultima consulta que tuvo con un paciente para verificar si la información que tiene sobre él aun es util o es necesario realizar nuevos examenes. Este reporte muestra los detalles de la utlima visita del paciente entre lo que se encuentra	la fecha de dicha visita, el peso y altura en ese momento, nombre y numero de seguro social y otros datos como el telefono y la direccion.
*/
-- TODO no corre
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
FROM patients 
	INNER JOIN visits ON ssid = patient_id
	INNER JOIN doctors ON doctors.id = doctor_id
WHERE patients.fname = 'Martin' AND patients.lname = 'Murillo';


/*
	Visitas de un paciente ordenadas de la mas reciente a la mas antigua Es importante para el doctor estar al tanto de las consultas que ha tenido su paciente para comprobar como va progresando su estado. Esta consulta muestra todas las consultas que ha tenido un paciente en el hospital desde la mas reciente hasta la primera.
*/
-- No corre TODO
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
FROM patients 
	INNER JOIN visits ON ssid = patient_id 
	INNER JOIN doctors ON doctors.id = doctor_id
WHERE patients.fname = 'Martin' AND patients.lname = 'Murillo'
ORDER BY visits.date DESC;

/*
	Este reporte permite acceder a cada una de las prescripciones que ha hecho hasta el momento de la consulta, incluyendo todo los detalles de las mismas, los cuales son: nombre y apellidos del doctor, número de identificación de la prescripción, fecha en que se realizó, fecha en que finalizó y los detalles de las indicaciones. Este reporte en específico accede a las prescripciones del doctor Eugenio Rangel.
*/
SELECT 
	doctors.fname AS 'Nombre',
	doctors.lname AS 'Apellido',
	details.id AS 'ID Prescripcion',
	details.start_date AS 'Fecha de inicio', 
	details.end_date AS 'Fecha de fin',
	medicine_catalog.generic_name AS 'Medicina (nombre genérico)',
	medicine_catalog.commercial_name AS 'Medicina (nombre comercial)',
	details.dosage AS 'Dosis',
	details.indications AS 'Indicaciones'
FROM doctors 
	JOIN visits ON doctors.id = doctor_id 
	JOIN prescriptions ON visits.id = visit_id 
	JOIN details ON prescriptions.id = prescription_id 
	JOIN medicine_catalog ON medicine_id = medicine_catalog.id
WHERE doctors.fname = 'Eugenio' AND doctors.lname = 'Rangel';

/* Finished Uriel */
/* -----------------------------------------------------------------------------------------------------*/


/* Hector Ortiz */
select  p.fname as 'Nombre Paciente',
p.lname as 'Apellido Paciente',
v.comments as 'Diagnostico', 
d.fname as 'Nombre Doctor',
d.lname as 'Apellido Doctor' 
from patients p join visits v 
ON p.ssid = v.patient_id 
join doctors d on v.doctor_id = d.id 
WHERE v.date = getdate();
