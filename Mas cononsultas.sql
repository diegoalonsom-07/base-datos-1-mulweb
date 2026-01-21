-- A) Nombre y apellidos, nombre de la asignatura y nota de los alumnos que tengan todo aprobado
SELECT AL.DNI, APENOM AS ALUMNO, NOMBRE AS ASIGNATURA, NOTA
FROM ALUMNOS AL
INNER JOIN NOTAS N ON AL.DNI = N.DNI
INNER JOIN ASIGNATURAS A ON A.COD=N.COD
WHERE AL.DNI NOT IN (SELECT DNI
					 FROM NOTAS
                     WHERE NOTA <= 5);

-- B) Notas de las asignaturas cuyo nombre tenga 3 letras
SELECT AL.DNI, APENOM AS ALUMNO, NOMBRE AS ASIGNATURA, NOTA
FROM ALUMNOS AL
INNER JOIN NOTAS N ON AL.DNI = N.DNI
INNER JOIN ASIGNATURAS A ON A.COD=N.COD
WHERE A.NOMBRE LIKE ('___');

-- C) Seleccionar las asignaturas que haya aprobado algún alumno de Madrid.
SELECT DISTINCT NOMBRE
FROM ASIGNATURAS A
WHERE A.COD IN (SELECT COD
				FROM NOTAS N
                INNER JOIN ALUMNOS AL ON AL.DNI = N.DNI
                WHERE NOTA >=5 AND
					  POBLA = 'MADRID');

-- D) Temas del estante C que tengan más de 10 ejemplares
SELECT TEMA, ESTATE, EJEMPLARES
FROM LIBRERIA
WHERE ESTANTE = 'C' AND
	  EJEMPLARES < 10;
      
-- E) Tema con mayor número de ejemplares de cada estante
SELECT TEMA, ESTANTE, EJEMPLARES
FROM LIBRERIA L
WHERE EJEMPLARES = (SELECT MAX(EJEMPLARES)
					FROM LIBRERIA L2
					WHERE L.ESTANTE = L2.ESTANTE
                    GROUP BY L2.ESTANTE)
ORDER BY ESTANTE;

-- F) Nota media de los que tienen todo aprobado
SELECT APENOM, AVG(N.NOTA) AS MEDIA
FROM ALUMNOS AL
INNER JOIN NOTAS N ON AL.DNI = N.DNI
GROUP BY AL.DNI, APENOM
HAVING MIN(N.NOTA) >= 5;

SELECT APENOM, AVG(N.NOTA) AS MEDIA
FROM ALUMNOS AL
INNER JOIN NOTAS N ON AL.DNI = N.DNI
WHERE AL.DNI NOT IN (SELECT DNI
					 FROM NOTAS
                     WHERE NOTA < 5)
GROUP BY APENOM;

-- G) Alumno con mayor nota media
SELECT a.DNI,
       a.APENOM,
       AVG(n.NOTA) AS nota_media
FROM ALUMNOS a
JOIN NOTAS n ON a.DNI = n.DNI
GROUP BY a.DNI, a.APENOM
ORDER BY nota_media DESC
LIMIT 1;

SELECT a.APENOM,
       AVG(n.NOTA) AS nota_media
FROM ALUMNOS a
INNER JOIN NOTAS N ON a.DNI = n.DNI
GROUP BY APENOM
HAVING AVG(NOTA) >= ALL (SELECT AVG(NOTA)
						 FROM NOTAS
                         GROUP BY DNI);

-- I) ¿Hay alguien que ha sacado más nota que Ana Casas en algunaevaluación?
-- No existe Ana Casas

-- J) Empleados que tienen alguno de los oficios de los del departamento de VENTAS, pero sin sacar los propios 
--    empleados de VENTAS. Enseñar Nombre del Empleado, Oficio y Nombre del Departamento al que pertenece.
SELECT E.NOMBRE AS nombre_empleado,
       E.OFICIO,
       D.NOMBRE AS nombre_departamento
FROM EMPLEADOS e
INNER JOIN DEPARTAMENTOS D ON E.N_DPTO = D.N_DPTO
WHERE E.OFICIO IN (SELECT OFICIO
				   FROM EMPLEADOS E
				   JOIN DEPARTAMENTOS D ON E.N_DPTO = D.N_DPTO
                   WHERE D.NOMBRE = 'Ventas')
AND d.NOMBRE != 'VENTAS';
                   
-- K) Empleados con el mismo director que el empleado ‘SALA’. Enseñar el nombre del Empleado y el nombre del director.
SELECT E.NOMBRE AS EMPLEADO, D.NOMBRE AS DIRECTOR
FROM EMPLEADOS E
INNER JOIN EMPLEADOS D ON E.DIR = D.IDEMPLEADOS
WHERE E.DIR = (SELECT DIR 
			   FROM EMPLEADOS 
               WHERE NOMBRE = 'Sala')
AND E.NOMBRE != 'Sala';

-- L) Empleado con más antigüedad.
SELECT NOMBRE 
FROM EMPLEADOS 
WHERE FECHA_ALTA = (SELECT MIN(FECHA_ALTA) 
					FROM EMPLEADOS); 
                    
-- M) Señala la localidad de los empleados que no tienen director
SELECT D.LOCALIDAD, E.NOMBRE
FROM EMPLEADOS E
INNER JOIN DEPARTAMENTOS D ON E.N_DPTO = D.N_DPTO
WHERE E.DIR IS NULL;

-- N) Apellido y oficio de cada empleado con el apellido y oficio del empleado que le dirige, incluidos los empleados que no tienen director.
SELECT E.NOMBRE AS APELLIDO_EMPLEADO, E.OFICIO AS OFICIO_EMPLEADO, 
       D.NOMBRE AS APELLIDO_DIRECTOR, D.OFICIO AS OFICIO_DIRECTOR
FROM EMPLEADOS E
LEFT JOIN EMPLEADOS D ON E.DIR = D.IDEMPLEADOS;

-- O) ¿Quién dirige al director de MARTIN?
SELECT D2.NOMBRE
FROM EMPLEADOS E
INNER JOIN EMPLEADOS D1 ON E.DIR = D1.IDEMPLEADOS
INNER JOIN EMPLEADOS D2 ON D1.DIR = D2.IDEMPLEADOS
WHERE E.NOMBRE = 'Martin';

SELECT NOMBRE
FROM EMPLEADOS
WHERE IDEMPLEADOS = (SELECT DIR
					 FROM EMPLEADOS
                     WHERE IDEMPLEADOS = (SELECT DIR
										  FROM EMPLEADOS
                                          WHERE NOMBRE = 'MARTIN'));
