USE universidad;

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
SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON departamento.id = profesor.id_departamento
WHERE tipo = 'profesor' ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

-- Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON departamento.id = profesor.id_departamento
WHERE tipo = 'profesor' AND profesor.id_departamento IS NULL;

-- Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT departamento.nombre 
FROM departamento 
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
WHERE profesor.id_profesor IS NULL;

-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT *
FROM persona
RIGHT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor
WHERE asignatura.id IS NULL;

-- Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT *
FROM asignatura
WHERE id_profesor IS NULL;

-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT departamento.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
GROUP BY departamento.nombre
HAVING count(asignatura.id) = 0;

-- Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(id) 
FROM persona
WHERE tipo = 'alumno';

-- Calcula quants alumnes van néixer en 1999.
SELECT COUNT(id) AS 'nascuts al 1999'
FROM persona
WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-12';

-- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
-- El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.

SELECT COUNT(id_profesor) AS 'nombre_de_profesors', departamento.nombre
FROM profesor
JOIN departamento ON profesor.id_departamento = departamento.id
GROUP BY departamento.nombre
ORDER BY COUNT(id_profesor) DESC;

-- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
-- Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT COUNT(id_profesor) AS 'nombre_de_profesors', departamento.nombre
FROM profesor
RIGHT JOIN departamento ON profesor.id_departamento = departamento.id
GROUP BY departamento.nombre
ORDER BY COUNT(id_profesor) DESC;

-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
-- Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT grado.nombre, COUNT(asignatura.id)
FROM grado
JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre;

-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre, COUNT(asignatura.id)
FROM grado
JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
HAVING COUNT(asignatura.id) > 40;

-- Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
-- El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus. 

SELECT grado.nombre, asignatura.tipo, SUM(creditos)
FROM grado
JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre, asignatura.tipo;

-- Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
-- El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

SELECT curso_escolar.anyo_inicio, COUNT(alumno_se_matricula_asignatura.id_alumno)
FROM persona 
JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE tipo = 'alumno'
GROUP BY curso_escolar.anyo_inicio;

-- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
-- El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) AS nombre_assignatures
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
GROUP BY persona.id, persona.nombre, persona.apellido1, persona.apellido2
ORDER BY nombre_assignatures DESC;

-- Retorna totes les dades de l'alumne/a més jove.
SELECT *
FROM persona
WHERE tipo = 'alumno'
ORDER BY fecha_nacimiento ASC
LIMIT 1;

-- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2
FROM persona
INNER JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE profesor.id_departamento IS NOT NULL AND asignatura.id IS NULL;