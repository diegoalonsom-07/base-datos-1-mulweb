/*CREAR EQUIPOS*/
CREATE TABLE EQUIPOS (
	CODEQUIPO INT PRIMARY KEY, 
    NOMEQUIPO VARCHAR(30),
    DIRECTOR VARCHAR(30), 
    PRESUPUESTO INT);

/*CREAR PILOTOS*/
CREATE TABLE PILOTOS (
	CODPILOTO INT PRIMARY KEY, 
    NOMPILOTO VARCHAR(30),
    FECHA_NACIMIENTO DATE,
    EQUIPO INT, 
    SUELDO INT, 
    AMIGO INT NULL,
    FOREIGN KEY (EQUIPO) REFERENCES EQUIPOS(CODEQUIPO),
    FOREIGN KEY (AMIGO) REFERENCES PILOTOS(CODPILOTO));

/*CREAR PUNTUACIONES*/
CREATE TABLE PUNTUACIONES (
	POSICION INT PRIMARY KEY, 
    PUNTOS INT UNIQUE);
    
/*CREAR GRANDES PREMIOS*/
CREATE TABLE GP (
	CODGP INT PRIMARY KEY, 
    NOMGP VARCHAR(20),
    CIRCUITO VARCHAR(20), 
    FECHA DATE, 
    LUGAR VARCHAR(20), 
    CONTINENTE VARCHAR(20));

/*CREAR RESULTADOS*/
CREATE TABLE RESULTADOS (
	CODPILOTO INT, 
    CODGP INT, 
    POSICION INT,
    FOREIGN KEY (CODPILOTO) REFERENCES PILOTOS(CODPILOTO),
    FOREIGN KEY (CODGP) REFERENCES GP(CODGP),
    PRIMARY KEY (CODPILOTO, CODGP));

/*INSERTAR EQUIPOS*/
Insert into EQUIPOS (CODEQUIPO,NOMEQUIPO,DIRECTOR,PRESUPUESTO) values ('1','Red Bull','Adrian Newey','164731');
Insert into EQUIPOS (CODEQUIPO,NOMEQUIPO,DIRECTOR,PRESUPUESTO) values ('2','McLaren','Paddy LOWE','433282');
Insert into EQUIPOS (CODEQUIPO,NOMEQUIPO,DIRECTOR,PRESUPUESTO) values ('3','Ferrari','ALDO COSTA','414875');
Insert into EQUIPOS (CODEQUIPO,NOMEQUIPO,DIRECTOR,PRESUPUESTO) values ('4','Mercedes','Bob BEll','398003');
Insert into EQUIPOS (CODEQUIPO,NOMEQUIPO,DIRECTOR,PRESUPUESTO) values ('5','Renault','James Allison','393766');

/*INSERTAR PILOTOS*/
Insert into PILOTOS values ('10','Carlos Sáinz Jr','95/07/03','1','2000',null);
Insert into PILOTOS values ('50','Jenson Button','80/01/19','2','900','10');
Insert into PILOTOS values ('20','Sebastian Vettel','87/07/03','1','2000','50');
Insert into PILOTOS values ('70','Felipe Massa','81/04/25','3','14000','50');
Insert into PILOTOS values ('60','Fernando ALONSO','81/07/29','3','30000','70');
Insert into PILOTOS values ('30','Mark Webber','76/08/27','1','4200','60');
Insert into PILOTOS values ('40','Lewis Hamilton','85/01/07','2','16000',null);

/*CAMBIAR AMIGO DE BUTTON*/
UPDATE PILOTOS
SET AMIGO = 20
WHERE CODPILOTO = 50;

/*INSERTAR PUNTUACIONES*/
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('1','25');
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('2','18');
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('3','15');
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('4','12');
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('5','10');
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('6','8');
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('7','6');
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('8','4');
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('9','2');
Insert into PUNTUACIONES (POSICION,PUNTOS) values ('10','1');

/*INSERTAR GRANDES PREMIOS*/
Insert into GP (CODGP,NOMGP,CIRCUITO,FECHA,LUGAR,CONTINENTE) values ('4','España','Cataluña','20/05/09','Barcelona','EUROPA');
Insert into GP (CODGP,NOMGP,CIRCUITO,FECHA,LUGAR,CONTINENTE) values ('1','Bahrein','Sakhir','20/03/03','Bahrein','ASIA');
Insert into GP (CODGP,NOMGP,CIRCUITO,FECHA,LUGAR,CONTINENTE) values ('2','Australia','Australia','20/03/27','Melbourne','Australia');
Insert into GP (CODGP,NOMGP,CIRCUITO,FECHA,LUGAR,CONTINENTE) values ('3','China','Malasia','20/04/10','Sepang','Asia');

/*INSERTAR RESULTADOS*/
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('50','1','1');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('60','1','2');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('10','1','4');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('40','1','7');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('20','1','8');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('40','2','1');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('10','2','2');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('60','2','3');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('50','2','4');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('30','2','6');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('20','2','9');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('40','3','1');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('50','3','4');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('10','3','6');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('20','3','8');
Insert into RESULTADOS (CODPILOTO,CODGP,POSICION) values ('60','3','9');


/* -------------- PREPARACION DEL EXAMEN -------------- */
-- A. Muestra el nombre y el sueldo de todos los pilotos que ganen más de 5,000, ordenados de mayor a menor sueldo.
SELECT NOMPILOTO, SUELDO
FROM PILOTOS
WHERE SUELDO > 5000
ORDER BY SUELDO DESC;

-- B. Obtén el nombre de los Grandes Premios que se celebren en el continente 'ASIA' o 'Australia'.
SELECT * 
FROM GP
WHERE CONTINENTE = 'ASIA' OR CONTINENTE = 'AUSTRALIA';

-- C. Lista el nombre de cada piloto junto con el nombre de su equipo y el presupuesto de este.
SELECT NOMPILOTO, NOMEQUIPO, PRESUPUESTO
FROM PILOTOS P
INNER JOIN EQUIPOS E ON E.CODEQUIPO = P.EQUIPO;

-- D. Muestra el nombre de los pilotos y el nombre del Gran Premio donde hayan quedado en 1ª posición.
SELECT NOMPILOTO, NOMGP
FROM PILOTOS P
INNER JOIN RESULTADOS R ON R.CODPILOTO = P.CODPILOTO
INNER JOIN GP G ON G.CODGP = R.CODGP
WHERE R.POSICION = 1;

-- E. Obtén una lista con el nombre del piloto, el circuito y la posición obtenida para todos los resultados registrados.
SELECT NOMPILOTO, CIRCUITO, POSICION
FROM PILOTOS P
INNER JOIN RESULTADOS R ON R.CODPILOTO = P.CODPILOTO
INNER JOIN GP G ON G.CODGP = R.CODGP
ORDER BY NOMPILOTO, POSICION;

-- F. Muestra el nombre de todos los pilotos y, si tienen un amigo asignado, el nombre de ese amigo. (Pista: necesitas un LEFT JOIN con la misma tabla PILOTOS).
SELECT p.NOMPILOTO AS Piloto, a.NOMPILOTO AS Nombre_del_Amigo
FROM PILOTOS p
LEFT JOIN PILOTOS a ON p.AMIGO = a.CODPILOTO;

-- G. Lista todos los equipos y el nombre de sus pilotos. Asegúrate de que aparezcan incluso los equipos que no tienen pilotos asignados (como 'Mercedes' o 'Renault').
SELECT NOMEQUIPO, NOMPILOTO
FROM EQUIPOS E
LEFT JOIN PILOTOS P ON P.EQUIPO = E.CODEQUIPO;

-- H. Calcula el gasto total en sueldos que tiene cada equipo. Muestra el nombre del equipo y el total.
SELECT NOMEQUIPO, SUM(SUELDO) AS GASTO_SUELDO
FROM EQUIPOS E
LEFT JOIN PILOTOS P ON P.EQUIPO = E.CODEQUIPO
GROUP BY NOMEQUIPO;

-- I. ¿Cuántos podios (posiciones 1, 2 o 3) ha conseguido cada piloto? Muestra el nombre del piloto y la cantidad.
SELECT NOMPILOTO, COUNT(POSICION) AS PODIOS
FROM PILOTOS P
INNER JOIN RESULTADOS R ON R.CODPILOTO = P.CODPILOTO
WHERE POSICION >=3
GROUP BY NOMPILOTO
ORDER BY PODIOS DESC;

-- J. Muestra los equipos cuyo presupuesto medio por piloto sea superior a 100,000.
SELECT E.NOMEQUIPO
FROM EQUIPOS E
JOIN PILOTOS P ON E.CODEQUIPO = P.EQUIPO
GROUP BY E.NOMEQUIPO, E.PRESUPUESTO
HAVING (E.PRESUPUESTO / COUNT(P.CODPILOTO)) > 100000;

-- K. Encuentra los nombres de los pilotos que ganan más que la media de todos los pilotos de la parrilla.
SELECT NOMPILOTO, SUELDO
FROM PILOTOS P
WHERE SUELDO >= (SELECT AVG(SUELDO) AS PROMEDIO
				 FROM PILOTOS);

-- L. Muestra los datos de los Grandes Premios en los que no haya participado el piloto con CODPILOTO = 30 (Mark Webber).
SELECT *
FROM GP
WHERE CODGP NOT IN (SELECT CODGP 
					FROM RESULTADOS 
					WHERE CODPILOTO = 30);

-- M. Crea un informe que muestre: Nombre del Piloto, Nombre de su Equipo, Suma total de PUNTOS conseguidos en todos los GP y el Nombre de su Amigo. (Necesitarás unir 5 tablas: PILOTOS, EQUIPOS, RESULTADOS, PUNTUACIONES y otra vez PILOTOS para el amigo).
SELECT P.NOMPILOTO, E.NOMEQUIPO, SUM(PT.PUNTOS) AS Total_Puntos, A.NOMPILOTO AS Nombre_Amigo
FROM PILOTOS P
JOIN EQUIPOS E ON P.EQUIPO = E.CODEQUIPO
JOIN RESULTADOS R ON P.CODPILOTO = R.CODPILOTO
JOIN PUNTUACIONES PT ON R.POSICION = PT.POSICION
LEFT JOIN PILOTOS A ON P.AMIGO = A.CODPILOTO
GROUP BY P.NOMPILOTO, E.NOMEQUIPO, A.NOMPILOTO;


-- A. Muestra el nombre y el sueldo de todos los pilotos que ganen más de 5,000, ordenados de mayor a menor sueldo.
-- B. Obtén el nombre de los Grandes Premios que se celebren en el continente 'ASIA' o 'Australia'.
-- C. Lista el nombre de cada piloto junto con el nombre de su equipo y el presupuesto de este.
-- D. Muestra el nombre de los pilotos y el nombre del Gran Premio donde hayan quedado en 1ª posición.
-- E. Obtén una lista con el nombre del piloto, el circuito y la posición obtenida para todos los resultados registrados.
-- F. Muestra el nombre de todos los pilotos y, si tienen un amigo asignado, el nombre de ese amigo (Relación reflexiva).
-- G. Lista todos los equipos y el nombre de sus pilotos, incluyendo equipos sin pilotos (Left Join).
-- H. Calcula el gasto total en sueldos que tiene cada equipo mostrando el nombre del equipo.
-- I. ¿Cuántos podios (posiciones 1, 2 o 3) ha conseguido cada piloto? Muestra nombre y cantidad.
-- J. Muestra los equipos cuyo presupuesto medio por piloto sea superior a 100,000 (Uso de HAVING).
-- K. Encuentra los nombres de los pilotos que ganan más que la media de todos los pilotos (Subconsulta).
-- L. Muestra los datos de los Grandes Premios en los que NO haya participado el piloto con CODPILOTO = 30.
-- M. Informe completo: Nombre del Piloto, Nombre del Equipo, Suma total de PUNTOS y Nombre de su Amigo.
