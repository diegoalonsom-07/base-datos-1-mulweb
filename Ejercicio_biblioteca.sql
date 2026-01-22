CREATE TABLE LIBROS (
	IDLIBRO INT PRIMARY KEY AUTO_INCREMENT,
    TITULO VARCHAR (100),
    AÑO_PUBLI INT,
    GENERO VARCHAR (100),
    PAGINAS INT);
    
INSERT INTO LIBROS (TITULO, AÑO_PUBLI, GENERO, PAGINAS) VALUES ('1984', 1949, 'POLÍTICA Y FICCIÓN', 328);
INSERT INTO LIBROS (TITULO, AÑO_PUBLI, GENERO, PAGINAS) VALUES ('REBELIÓN EN LA GRANJA', 1945, 'POLÍTICA Y FICCIÓN', 112);
INSERT INTO LIBROS (TITULO, AÑO_PUBLI, GENERO, PAGINAS) VALUES ('EL HOBBIT', 1937, 'FANTASÍA', 310);
INSERT INTO LIBROS (TITULO, AÑO_PUBLI, GENERO, PAGINAS) VALUES ('LA COMUNIDAD DEL ANILLO', 1954, 'FANTASÍA', 423);


CREATE TABLE AUTORES (
	IDAUTOR INT PRIMARY KEY AUTO_INCREMENT,
    NOMBRE VARCHAR (100),
    NACIONALIDAD VARCHAR (100));
    
INSERT INTO AUTORES (NOMBRE, NACIONALIDAD) VALUES ('GEORGE ORWELL', 'REINO UNIDO');
INSERT INTO AUTORES (NOMBRE, NACIONALIDAD) VALUES ('J.R.R. TOLKIEN', 'REINO UNIDO');
INSERT INTO AUTORES (NOMBRE, NACIONALIDAD) VALUES ('GEORGE ORWELL', 'REINO UNIDO');
INSERT INTO AUTORES (NOMBRE, NACIONALIDAD) VALUES ('ISAAC ASIMOV', 'ESTADOS UNIDOS');
INSERT INTO AUTORES (NOMBRE, NACIONALIDAD) VALUES ('AGATHA CHRISTIE', 'REINO UNIDO');


CREATE TABLE LECTORES (
		IDLECTOR INT PRIMARY KEY AUTO_INCREMENT,
        NOMBRE VARCHAR (100),
        FECHA_REGISTRO DATE);
        
INSERT INTO LECTORES (NOMBRE, FECHA_REGISTRO) VALUES ('JUSTO LÁZARO', '2024-01-15');
INSERT INTO LECTORES (NOMBRE, FECHA_REGISTRO) VALUES ('YOLANDA MÉNDEZ', '2024-03-22');
INSERT INTO LECTORES (NOMBRE, FECHA_REGISTRO) VALUES ('CÉSAR BRERA', '2024-01-15');
INSERT INTO LECTORES (NOMBRE, FECHA_REGISTRO) VALUES ('JAVIER ALONSO', '2024-05-10');
INSERT INTO LECTORES (NOMBRE, FECHA_REGISTRO) VALUES ('JAVIER ALLONA', '2024-06-01');  

CREATE TABLE PRESTAMOS (
		IDPRESTAMO INT PRIMARY KEY AUTO_INCREMENT,
        LIBRO INT,
        LECTOR INT,
        FECHA_PRESTAMO DATE,
        FECHA_DEVOL_TEORICA DATE,
        FECHA_DEVOL_REAL DATE,
        FOREIGN KEY (LIBRO) REFERENCES LIBROS (IDLIBRO),
        FOREIGN KEY (LECTOR) REFERENCES LECTORES (IDLECTOR));
        
INSERT INTO PRESTAMOS (LIBRO, LECTOR, FECHA_PRESTAMO, FECHA_DEVOL_TEORICA, FECHA_DEVOL_REAL) VALUES (1, 1, '2024-01-20', '2024-02-20', '2024-01-15');
INSERT INTO PRESTAMOS (LIBRO, LECTOR, FECHA_PRESTAMO, FECHA_DEVOL_TEORICA, FECHA_DEVOL_REAL) VALUES (4, 1, '2024-02-01', '2024-03-01', '2024-02-28');
INSERT INTO PRESTAMOS (LIBRO, LECTOR, FECHA_PRESTAMO, FECHA_DEVOL_TEORICA, FECHA_DEVOL_REAL) VALUES (3, 2, '2024-02-10', '2024-03-10', '2024-03-05');
INSERT INTO PRESTAMOS (LIBRO, LECTOR, FECHA_PRESTAMO, FECHA_DEVOL_TEORICA, FECHA_DEVOL_REAL) VALUES (4, 3, '2024-03-15', '2024-04-15', '2024-04-20');


CREATE TABLE AUTORIAS (
	   IDAUTORLIBRO INT PRIMARY KEY AUTO_INCREMENT,
       AUTOR INT,
       LIBRO INT,
       FOREIGN KEY (AUTOR) REFERENCES AUTORES (IDAUTOR),
       FOREIGN KEY (LIBRO) REFERENCES LIBROS (IDLIBRO));
       
INSERT INTO AUTORIAS (AUTOR, LIBRO) VALUES (1, 1);
INSERT INTO AUTORIAS (AUTOR, LIBRO) VALUES (1, 2);
INSERT INTO AUTORIAS (AUTOR, LIBRO) VALUES (2, 3);
INSERT INTO AUTORIAS (AUTOR, LIBRO) VALUES (2, 4);

-- ===========================================================================================================

-- 1) Contar el número de libros registrados en la base de datos.
SELECT COUNT(IDLIBRO) AS CANTIDAD_LIBRO
FROM LIBROS;

-- 2) Contar cuántos libros aún no han sido devueltos (es decir, libros que no
--    tienen fecha de devolución).
SELECT COUNT(LIBRO) AS LIBROS_NO_DEVUELTOS
FROM  PRESTAMOS
WHERE FECHA_DEVOL_REAL IS NULL;
                        
-- 3) Para cada género, muestre el nombre del género y el número de libros de
--    ese género.
SELECT GENERO, COUNT(IDLIBRO) AS "LIBROS NO DEVUELTOS"
FROM LIBROS
GROUP BY GENERO;

-- 4) Para cada país, muestre su nombre y el número de autores asociados a él.
SELECT NACIONALIDAD AS PAIS, COUNT(IDAUTOR) AS "CANTIDAD AUTOR"
FROM AUTORES
GROUP BY PAIS;

-- 5) Para cada género, muestre cuatro columnas: el nombre del género, el
-- 	  número mínimo y máximo de páginas de los libros de ese género, y la
-- 	  diferencia entre el mayor y el menor número de páginas de cada género.
SELECT GENERO, MAX(PAGINAS) AS MAXIMO, MIN(PAGINAS) AS MINIMO, MAX(PAGINAS) - MIN(PAGINAS) AS DIFERENCIA
FROM LIBROS
GROUP BY GENERO; 

-- 6) Para cada género, muestre el número medio de páginas de todos los
-- 	  libros de ese género. Sólo muestre los géneros en los que el libro medio
--    tiene más de 250 páginas. 
SELECT GENERO, AVG(PAGINAS) AS MEDIA_PAGINAS
FROM LIBROS
GROUP BY GENERO
HAVING AVG(PAGINAS) > 250;

-- 7) Muestre el año medio de publicación para cada género de libros.
--    Redondee el año a un número entero. Muestre sólo los géneros cuyo año
--    medio de publicación sea posterior a 1940.
SELECT GENERO, ROUND(AVG(AÑO_PUBLI)) AS AÑO_MEDIO_PUBLI
FROM LIBROS
GROUP BY GENERO
HAVING ROUND(AVG(AÑO_PUBLI)) > 1940;

-- 8) Para los libros que han sido escritos por más de un autor, muestre el título
--    de cada libro y el número de autores.
SELECT L.TITULO, COUNT(A.AUTOR) AS CANTIDAD_AUTORES
FROM LIBROS L
INNER JOIN AUTORIAS A ON A.LIBRO = L.IDLIBRO
GROUP BY TITULO;

-- 9) Para cada libro, muestre su título y la fecha más reciente en que fue
--    prestado. Nombre la segunda columna ULTIMO_PRESTAMO.
--    Muestre NULL en la segunda columna para todos los libros que nunca
--    han sido prestados. NO CE
SELECT L.TITULO, MAX(P.FECHA_PRESTAMO) AS ULTIMO_PRESTAMO
FROM LIBROS L
LEFT JOIN PRESTAMOS P ON L.IDLIBRO = P.LIBRO
GROUP BY L.IDLIBRO;

-- 10) Muestre cuántos préstamos de libros se emitieron cada mes de cada año.
--     Muestre tres columnas:
--     		- La parte del año y del mes de FECHA_PRESTAMO como números en las dos
--            primeras columnas. Nómbralas AÑO_PRESTAMO y MES_PRESTAMO. Una
-- 			  tercera columna contando cuántos libros se prestaron ese mes.
-- 			- Ordena el resultado por el año y luego por el mes, mostrando primero las fechas
-- 			  más antiguas.
SELECT YEAR(FECHA_PRESTAMO) AS AÑO_PRESTAMO, MONTH(FECHA_PRESTAMO) AS MES_PRESTAMO, COUNT(LIBRO) AS LIBROS_PRESTADOS
FROM PRESTAMOS
GROUP BY FECHA_PRESTAMO, FECHA_PRESTAMO; 

-- 11) Para cada libro, muestre su título, el número de veces que ha sido
--     prestado y el número de usuarios diferentes que han tomado prestado el
--     libro. Nombra las dos últimas columnas VECES_PRESTADO y LECTORES_DIFERENTES.
SELECT TITULO, COUNT(IDLIBRO) AS VECES_PRESTADO, COUNT(DISTINCT LECTOR) AS LECTORES_DIFERENTES
FROM LIBROS L
INNER JOIN PRESTAMOS P ON P.LIBRO = L.IDLIBRO
GROUP BY TITULO;

-- 12) Para cada cliente, muestre su nombre y la cantidad de libros que tiene
--     (tenían) atrasados (es decir, con fecha de devolución posterior a la fecha
--     de vencimiento).
SELECT NOMBRE, COUNT(LIBRO)
FROM LECTORES L
INNER JOIN PRESTAMOS P ON P.LECTOR = L.IDLECTOR
WHERE FECHA_DEVOL_REAL > FECHA_DEVOL_TEORICA
GROUP BY NOMBRE;

-- 13) Para cada género, muestre su nombre y el número medio de autores que
--     tienen los libros de ese género. Nombra la segunda columna
--     NUMERO_AUTORES_GENERO
SELECT GENERO, AVG(NUMERO_AUTORES) AS "MEDIA DE AUTORES POR GENERO"
FROM (SELECT LIBRO, COUNT(AUTOR) AS NUMERO_AUTORES
	  FROM AUTORIAS
      GROUP BY LIBRO) NA
INNER JOIN LIBROS L ON L.IDLIBRO = NA.LIBRO
GROUP BY GENERO;

-- 14) Para cada cliente, muestre su nombre y el número total de páginas que
--     ha leído (es decir, el número de páginas de todos los libros que ha tomado
--     prestados). Suponemos que han leído todos los libros. Incluya todos los
--     libros, incluso los que aún no han devuelto.
-- 			- Mostrar sólo los resultados de los usuarios que hayan leído más de 1.000
-- 			  páginas
-- 			- eS NORMAL QUE NO SALGA NINGUNO, ES ASI EL EJERCICIO
SELECT NOMBRE, SUM(PAGINAS) AS PAGINAS_LEIDAS
FROM LECTORES LE
INNER JOIN PRESTAMOS P ON LE.IDLECTOR = P.LECTOR
INNER JOIN LIBROS L ON L.IDLIBRO = P.LIBRO
GROUP BY NOMBRE
HAVING PAGINAS_LEIDAS > 1000
ORDER BY PAGINAS_LEIDAS DESC;

-- 15) Mostrar el número total de usuarios que nunca han tomado libros
--     prestados.
SELECT COUNT(IDLECTOR) AS LECTORES_SIN_PRESTAMOS
FROM LECTORES LE
WHERE IDLECTOR NOT IN (SELECT LECTOR 
					   FROM PRESTAMOS);

-- 16) Para cada autor, muestre cuántos usuarios diferentes han tomado
--     prestado sus libros.
SELECT NOMBRE, COUNT(DISTINCT LECTOR) AS LECTORES_DIFERENTES
FROM AUTORES A 
INNER JOIN AUTORIAS AUS ON A.IDAUTOR = AUS.AUTOR
INNER JOIN LIBROS L ON L.IDLIBRO = AUS.LIBRO
INNER JOIN PRESTAMOS P ON P.LIBRO = L.IDLIBRO
GROUP BY NOMBRE;

-- 17) Encuentre el libro o libros más antiguos de la base de datos (es decir, el
--     libro o libros con el año de publicación más antiguo). Muestre sólo dos
--     columnas: Título y Año de publicación.
-- 			- Recuerde que puede haber más de un libro con el año de publicación más
-- 			  antiguo.
SELECT TITULO, AÑO_PUBLI AS AÑO_PUBLICACION
FROM LIBROS
WHERE AÑO_PUBLI = (SELECT MIN(AÑO_PUBLI) 
				   FROM LIBROS);

-- 18) Encuentre los nombres de todos los usuarios que han tomado prestados
--     un número de libros superior a la media. Indique el número de libros
--     prestados junto con su nombre (el del lector).
SELECT NOMBRE, COUNT(P.LIBRO) AS NUM_LIBROS
FROM LECTORES L
INNER JOIN PRESTAMOS P ON L.IDLECTOR = P.LECTOR
GROUP BY L.NOMBRE
HAVING COUNT(P.LIBRO) > (SELECT AVG(LIBROS_PRESTADOS)
						 FROM (SELECT COUNT(P.LIBRO) AS LIBROS_PRESTADOS
							   FROM PRESTAMOS P
                               GROUP BY P.LECTOR)LP);

-- 19) Encontrar el autor que escribió más libros.
SELECT A.NOMBRE, COUNT(LIBRO) AS LIBROS_ESCRITOS
FROM AUTORES A
INNER JOIN AUTORIAS AU ON A.IDAUTOR = AU.AUTOR
GROUP BY A.NOMBRE
HAVING COUNT(LIBRO) >= ALL (SELECT COUNT(LIBRO) AS LIBROS_ESCRITOS
							FROM AUTORIAS
                            GROUP BY AUTOR);





















