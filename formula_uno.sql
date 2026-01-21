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

-- =======================================================================================================================
-- =======================================================================================================================

-- 1) Listado de pilotos con su nombre, el nombre de su equipo y su abreviatura, que se construye con las 3 primeras letras de su apellido en mayúsculas.
SELECT CODPILOTO, NOMPILOTO, NOMEQUIPO, UPPER(SUBSTRING(NOMPILOTO, LOCATE (' ', NOMPILOTO) + 1, 3)) AS ABREVIATURA
FROM PILOTOS P
INNER JOIN EQUIPOS E ON E.CODEQUIPO = P.EQUIPO;

-- 2) El sueldo de los pilotos está en miles de euros, sin embargo, los presupuestos de los equipos están en miles de dólares.
--    Sabiendo que un euro es 1,3698 dólares (o bien que un dólar equivale a 0,7303 euros), modifica el presupuesto de los equipos 
--    para que también estén en euros.
UPDATE EQUIPOS 
SET PRESUPUESTO = PRESUPUESTO * 0.7303;

-- 3) Se desea saber si hay amistades correspondidas entre los pilotos, es decir, si un piloto es amigo de otro y éste es amigo 
--    del primero. Lista las parejas de amigos.
SELECT P1.CODPILOTO, P1.NOMPILOTO AS Piloto1, 
       P2.CODPILOTO, P2.NOMPILOTO AS Piloto2,
	   P1.AMIGO AS AMIGO_PIL_1,
       P2.AMIGO AS AMIGO_PIL_2
FROM PILOTOS P1
INNER JOIN PILOTOS P2 ON P1.AMIGO = P2.CODPILOTO
WHERE P2.AMIGO = P1.CODPILOTO
AND P1.CODPILOTO < P2.CODPILOTO;

SELECT P1.NOMPILOTO AS PILOTO1, 
       P2.NOMPILOTO AS AMIGO
FROM PILOTOS P1
INNER JOIN PILOTOS P2 ON P1.AMIGO = P2.CODPILOTO
WHERE P2.AMIGO = P1.CODPILOTO;
       

-- 4) Puntos obtenidos en cada Gran Premio por cada uno de los pilotos que tendrá las siguientes
--    columnas: NomPiloto, NomGP, Puntos, de acuerdo a los datos existentes y ordenados por Gran
--    premio y por posición.
SELECT PI.NOMPILOTO, 
	   G.NOMGP, 
       PU.PUNTOS
FROM RESULTADOS R
INNER JOIN PILOTOS PI ON R.CODPILOTO = PI.CODPILOTO
INNER JOIN GP G ON R.CODGP = G.CODGP
INNER JOIN PUNTUACIONES PU ON R.POSICION = PU.POSICION
ORDER BY G.NOMGP, R.POSICION;

-- 5) Visualiza la clasificación de los pilotos mostrando código del piloto, nombre y puntos totales en
--    orden decreciente de puntos. 
SELECT PI.CODPILOTO, PI.NOMPILOTO, SUM(PU.PUNTOS) AS PUNTOS_TOTALES
FROM RESULTADOS R
INNER JOIN PILOTOS PI ON R.CODPILOTO = PI.CODPILOTO
INNER JOIN PUNTUACIONES PU ON R.POSICION = PU.POSICION
GROUP BY PI.CODPILOTO
ORDER BY PUNTOS_TOTALES DESC;

-- 6) Clasificación final por equipos (equipos que hayan puntuado). Campos: nombre del equipo y
--    puntos totales (orden decreciente).
SELECT NOMEQUIPO, SUM(PU.PUNTOS) AS PUNTOS_TOTALES
FROM RESULTADOS R
INNER JOIN PILOTOS PI ON R.CODPILOTO = PI.CODPILOTO
INNER JOIN EQUIPOS E ON E.CODEQUIPO = PI.EQUIPO
INNER JOIN GP G ON R.CODGP = G.CODGP
INNER JOIN PUNTUACIONES PU ON R.POSICION = PU.POSICION
GROUP BY NOMEQUIPO
ORDER BY PUNTOS_TOTALES DESC;

-- 7)  Edad media de los pilotos de cada equipo (nombre del equipo y edad media).
SELECT NOMEQUIPO, AVG (TIMESTAMPDIFF(YEAR, FECHA_NACIMIENTO, CURDATE())) AS edad
FROM EQUIPOS E
INNER JOIN PILOTOS PI ON E.CODEQUIPO = PI.EQUIPO
GROUP BY NOMEQUIPO;

SELECT NOMEQUIPO, AVG (YEAR(CURDATE()) - YEAR(FECHA_NACIMIENTO)) AS edad
FROM EQUIPOS E
INNER JOIN PILOTOS PI ON E.CODEQUIPO = PI.EQUIPO
GROUP BY NOMEQUIPO;

-- 8)  Averigua qué pilotos que no han puntuado en ningún Gran Premio.
SELECT PI.NOMPILOTO
FROM PILOTOS PI
WHERE PI.CODPILOTO NOT IN (SELECT R.CODPILOTO
						   FROM RESULTADOS R
                           WHERE POSICION <= 10);
                           
-- 9) Piloto que ha conseguido más victorias (nombre del piloto y número de victorias).
SELECT P.NOMPILOTO, COUNT(POSICION) AS NUM_VICTORIAS
FROM PILOTOS P
INNER JOIN RESULTADOS R ON P.CODPILOTO = R.CODPILOTO
WHERE R.POSICION = 1
GROUP BY P.CODPILOTO, P.NOMPILOTO
HAVING COUNT(POSICION) >= ALL (SELECT COUNT(POSICION)
							   FROM RESULTADOS
							   WHERE POSICION = 1
							   GROUP BY CODPILOTO);

-- 10) Carreras que todavía no se han celebrado (no tiene ningún resultado anotado).
SELECT G.*
FROM GP G
WHERE G.CODGP NOT IN (SELECT G.CODGP
					  FROM RESULTADOS);
                      
-- 11) Pilotos cuyo sueldo supera el sueldo medio de su equipo, en orden de equipo (nombre del piloto,
--     nombre del equipo y sueldo).
SELECT P.NOMPILOTO, E.NOMEQUIPO, P.SUELDO
FROM PILOTOS P
INNER JOIN EQUIPOS E ON E.CODEQUIPO = P.EQUIPO
WHERE SUELDO > (SELECT AVG (SUELDO)
				FROM PILOTOS P2
                WHERE P2.EQUIPO = P.EQUIPO
                GROUP BY P2.EQUIPO);

-- 12) Listar el nombre y sueldo de los pilotos con un aumento de un 10% el sueldo de los pilotos con
--     podio en algun Gran Premio.
SELECT P.NOMPILOTO, P.SUELDO * 1.10 AS SUELDO_AUMENTADO
FROM PILOTOS P
WHERE P.CODPILOTO IN (SELECT CODPILOTO
					  FROM RESULTADOS
                      WHERE POSICION <=3);

-- 13)  Pilotos que no han participado en ninguna carrera de Europa
SELECT P.NOMPILOTO
FROM PILOTOS P
WHERE P.CODPILOTO NOT IN (SELECT P.CODPILOTO
						  FROM RESULTADOS R
                          INNER JOIN PILOTOS P ON R.CODPILOTO = P.CODPILOTO -- No es necesario
                          INNER JOIN GP G ON R.CODGP = G.CODGP
                          WHERE CONTINENTE = "EUROPA");

-- 14) Datos de las carreras de las que se han anotado más de 6 resultados
SELECT G.*
FROM GP G
JOIN RESULTADOS R ON G.CODGP = R.CODGP
GROUP BY G.CODGP, G.NOMGP, G.CIRCUITO, G.FECHA, G.LUGAR, G.CONTINENTE
HAVING COUNT(R.CODPILOTO) >= 6;











