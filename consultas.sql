# ---------------------------------------------
# 
#		Documento para poner sus consultas
# 	
#
#	1. Fork the repo
#   2. Add your queries here
#	3. Create pull request
# ---------------------------------------------

SELECT date, exam, test FROM patients JOIN labtests ON patients.ssid = labtests.patient_id JOIN labtest_catalog ON labtests.test_id = labtest_catalog.id WHERE ssid = 280580223;

SELECT date, fname, lname, parameter, value, min, max, comments FROM labtests JOIN results ON labtest_id = labtests.id JOIN patients ON patient_id = patients.ssid WHERE labtests.id = 2;