-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

-- Retorna el llistat dels alumnes que van néixer en 1999.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
-- El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS 'departamento' FROM persona JOIN profesor ON persona.id = id_profesor 
JOIN departamento ON profesor.id_departamento = departamento.id WHERE tipo = 'profesor' 
ORDER BY persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT persona.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin, asignatura.nombre FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura WHERE persona.nif = '26902806M';

-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.nombre
FROM persona 
JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno 
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id 
WHERE persona.tipo = 'alumno' AND curso_escolar.anyo_inicio = '2018';

-- Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.

SELECT * 
FROM persona.apellido1, persona.apellido2
LEFT JOIN profesor ON persona.id = profesor.id_profesor
RIGHT JOIN 
WHERE tipo = 'profesor';

SELECT * FROM profesor;
SELECT * FROM persona WHERE tipo = 'profesor';