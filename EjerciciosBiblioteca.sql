/*CREAR LECTORES*/
CREATE TABLE LECTORES (
  NUMLECTOR INT PRIMARY KEY AUTO_INCREMENT,
  NOMLECTOR VARCHAR(45),
  TIPOLECTOR INT);

/*INSERTAR LECTORES*/  
INSERT INTO LECTORES VALUES (1,	'Posadas Gil, Inés', 3);
INSERT INTO LECTORES VALUES (2,	'Sánchez Pons, José', 3);
INSERT INTO LECTORES VALUES (3,	'Gómez Sáez, Miguel', 3);
INSERT INTO LECTORES VALUES (8,	'Ana Blanco', 4);
INSERT INTO LECTORES VALUES (10, 'Santana Páez, Eva', 4);
INSERT INTO LECTORES VALUES (11, 'Betancor Díaz, Yolanda', 4);
INSERT INTO LECTORES VALUES (20, 'Blasco Ulla, Juan Luis', 1);
INSERT INTO LECTORES VALUES (22, 'Marín Gómez, Ana', 1);
INSERT INTO LECTORES VALUES (30, 'Plaza Ortiz, Juan', 8);

/*CREAR LIBROS*/
CREATE TABLE LIBROS (
  CODLIBRO INT PRIMARY KEY AUTO_INCREMENT,
  TITULO VARCHAR(30),
  NUMPAG INT,
  EDITORIAL VARCHAR(20),
  AUTOR VARCHAR(30));
  
/*INSERTAR LIBROS*/
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('12','Don Quijote I','517','Anaya','Cervantes');
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('13','Don Quijote II','611','Anaya','Cervantes');
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('20','El principito','120','Andina','Saint_Exupery');
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('35','Fortunata y Jacinta','625','PlazaJanes','Pérez-Galdós');
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('40','Caperucuta en Manhattan','310','Salamandra','Martín GAite');
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('41','La piel del tambor','280','Circulo','Pérez-Reverte');
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('42','Afrodita','421','Espasa','Isabel Allende');
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('50','Viajar','675','BBVA',null);
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('51','España en sus caminos','534','BBVA',null);
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('52','Aeroguía del litoral','340','Planeta',null);
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('65','Don Quijote I','578','Planeta','Cervantes');
Insert into LIBROS (CODLIBRO,TITULO,NUMPAG,EDITORIAL,AUTOR) values ('66','Don Quijote II','600','Planeta','Cervantes');

/*CREAR PRESTAMOS*/
CREATE TABLE PRESTAMOS (
  CODLIBRO INT,
  NUMLECTOR INT,
  FPRESTA DATE,
  PRIMARY KEY (CODLIBRO,NUMLECTOR,FPRESTA), 
  FOREIGN KEY (CODLIBRO) REFERENCES LIBROS(CODLIBRO),
  FOREIGN KEY (NUMLECTOR) REFERENCES LECTORES(NUMLECTOR));
  
/*INSERTAR PRESTAMOS*/
Insert into PRESTAMOS (CODLIBRO,NUMLECTOR,FPRESTA) values ('12','20','20-09-04');
Insert into PRESTAMOS (CODLIBRO,NUMLECTOR,FPRESTA) values ('20','11','20-10-24');
Insert into PRESTAMOS (CODLIBRO,NUMLECTOR,FPRESTA) values ('35','1','20-09-07');
Insert into PRESTAMOS (CODLIBRO,NUMLECTOR,FPRESTA) values ('40','3','20-03-25');
Insert into PRESTAMOS (CODLIBRO,NUMLECTOR,FPRESTA) values ('51','20','20-09-28');
Insert into PRESTAMOS (CODLIBRO,NUMLECTOR,FPRESTA) values ('52','22','20-09-28');

/*CREAR DEVOLUCIONES*/
CREATE TABLE DEVOLUCIONES (
  CODLIBRO INT,
  NUMLECTOR INT,
  FPRESTA DATE,
  FDEVOL DATE,
  PRIMARY KEY (CODLIBRO,NUMLECTOR,FPRESTA),
  FOREIGN KEY (CODLIBRO) REFERENCES LIBROS(CODLIBRO),
  FOREIGN KEY (NUMLECTOR) REFERENCES LECTORES(NUMLECTOR));
  
/*INSERTAR DEVOLUCIONES*/
Insert into DEVOLUCIONES (CODLIBRO,NUMLECTOR,FPRESTA,FDEVOL) values ('13','11','20-10-02','20-10-12');
Insert into DEVOLUCIONES (CODLIBRO,NUMLECTOR,FPRESTA,FDEVOL) values ('42','30','20-09-27','20-10-05');
Insert into DEVOLUCIONES (CODLIBRO,NUMLECTOR,FPRESTA,FDEVOL) values ('50','20','20-06-28','20-09-01');

-- ===================================================================================================
-- ===================================================================================================
-- 1) Crea un procedimiento llamado MEDIA_DIAS_PRESTADOS que muestre la media de días
--    que llevan los libros prestados. Trata adecuadamente los decimales.
CALL MEDIA_DIAS_PRESTADOS;

-- 2) Crea un procedimiento llamado CONSULTA_LECTOR, al cual se le dará un número de
--    lector y mostrará el nombre del lector y el total de libros que tiene prestados, y de éstos
--    cuántos llevan más de 15 días. Este último dato debe dejarlo en el último parámetro del
--    procedimiento, llamado reclamar.
CALL CONSULTA_LECTOR(20, @RECLAMAR);
SELECT @RECLAMAR;

-- 3) Crea un procedimiento LIBROS_POR_TIPO_LECTOR que muestre cuántos lectores hay de
--    cada tipo de lector, sabiendo que el tipo de lector es un número entero entre 1 y 10.
CALL LIBROS_POR_TIPO_LECTOR;

-- 4) Crea una función que dado el código de un libro devuelva un cero si el libro está en la
--    biblioteca, si está prestado, el nº de días que lleva prestado y -1 si el libro no existe.
CALL Ejercicio_4(13, @resultado);
Select @resultado;

-- 5) Crea un procedimiento CONSULTA_LIBRO que permita consultar el estado de un libro. Se
--    le dará un código de un libro y mostrará un mensaje si el libro no existe; en caso de que sí
--    exista, mostrará el título y si está prestado mostrará el nombre del lector que lo tiene o en
--    caso de no estar prestado, avisará de que se encuentra disponible en la biblioteca.
CALL CONSULTA_LIBRO(13);


























