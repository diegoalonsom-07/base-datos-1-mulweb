/*---------- GENERAR LA TABLA PROFESORES ----------*/
CREATE TABLE PROFESORES(
	dni varchar(10) PRIMARY KEY,
    nombre varchar(15) UNIQUE KEY,
    apellido1 varchar(15) UNIQUE KEY,
    apellido2 varchar(15) UNIQUE KEY,
    direccion varchar(30),
    titulo varchar(30),
    gana double NOT NULL
);

/*---------- INSERTAR TUPLAS EN PROFESORES ----------*/
INSERT INTO PROFESORES VALUES ('32432455', 'Juan', 'Arch', 'López', 'Puerta Negra, 4', 'Ing. Informática', 7500);
INSERT INTO PROFESORES VALUES ('43215643', 'María', 'Olivia', 'Rubio', 'Juan Alfonso, 32 ', 'Lda. Fil. Inglesa', 5400);
INSERT INTO PROFESORES (nombre, apellido1, apellido2, dni, direccion, titulo, gana) VALUES ('Juan', 'Arch', 'López', '32432455', 'Puerta Negra, 4', 'Ing. Informática', NULL); -- Ya esta creado esta tupla, abajo se modifica
UPDATE PROFESORES SET nombre = 'Juan', apellido1 = 'Arch', apellido2 = 'López', direccion = 'Puerta Negra, 4', titulo = 'Ing. Informática', gana = NULL WHERE dni = '32432455'; -- solucion de la linea anterior



/*---------- AÑADIR CAMPOS EN PROFESORES ----------*/
ALTER TABLE PROFESORES ADD (
	edad tinyint
);

/*---------- AÑADIR RESTRICCIONES EN PROFESORES ----------*/
ALTER TABLE PROFESORES ADD CONSTRAINT res_edad_prof CHECK (edad BETWEEN 18 AND 65);
ALTER TABLE PROFESORES DROP PRIMARY KEY; -- No se puede eliminar ya que esta siendo utilizada por otras tablas
ALTER TABLE PROFESORES ADD CONSTRAINT PROFESORES_PK PRIMARY KEY (nombre, apellido1, apellido2); -- No se puede añadir ya que no se pueden tener dos claves primarias.
ALTER TABLE PROFESORES ADD CONSTRAINT unique_dni UNIQUE (dni); -- No se puede ejecutar ya que ya es clave primaria

/*---------- QUITAR RESTRICCIONES EN PROFESORES ----------*/
ALTER TABLE PROFESORES MODIFY gana INT NULL;
ALTER TABLE PROFESORES DROP PRIMARY KEY; -- No se puede quitar ya que se estan utilizando en otras tablas


/*---------- VER EL CONTENIDO DE PROFESORES ----------*/
SELECT * FROM PROFESORES;



/*----------------------------------------------------------------------------------------------------------------------------------------------*/



/*---------- GENERAR LA TABLA CURSOS ----------*/
CREATE TABLE CURSOS (
	cod int AUTO_INCREMENT,
    nombre_curso varchar(30) UNIQUE KEY,
    maximo_alumnos int,
	fecha_inicio date,
    fecha_fin date,
    num_horas int NOT NULL,
    dni_profesor varchar (10),
    
	CHECK (fecha_fin > fecha_inicio),
    
    CONSTRAINT COD_PK PRIMARY KEY (cod),
    CONSTRAINT DNI_PROFESOR_FK FOREIGN KEY (dni_profesor) REFERENCES PROFESORES (dni)
);

/*---------- INSERTAR TUPLAS EN CURSOS ----------*/
INSERT INTO CURSOS VALUES ('1', 'Inglés básico', 15, '19/11/1', '19/12/22', '120', '43215643');
INSERT INTO CURSOS (nombre_curso, fecha_inicio, num_horas, dni_profesor) VALUES ('Administración Linux', '19/9/1', '80', '32432455');

/*---------- AÑADIR RESTRICCIONES EN CURSOS ----------*/
ALTER TABLE CURSOS ADD CONSTRAINT res_numalu_curs CHECK (maximo_alumnos >= 10);
ALTER TABLE CURSOS ADD CONSTRAINT res_minhora_curs CHECK (num_horas >= 100);
ALTER TABLE CURSOS MODIFY FECHA_INICIO DATE NOT NULL;
ALTER TABLE CURSOS ADD CONSTRAINT fk_dni_profesor FOREIGN KEY (dni_profesor) REFERENCES PROFESORES(dni); -- Esta ya creada

/*---------- MODIFICAR TUPLAS DE CURSOS ----------*/
UPDATE CURSOS SET num_horas = 100 WHERE cod = 2; -- Solución al minimo de horas

/*---------- VER EL CONTENIDO DE CURSOS ----------*/
SELECT * FROM CURSOS;



/*----------------------------------------------------------------------------------------------------------------------------------------------*/



/*---------- GENERAR LA TABLA ALUMNOS ----------*/
CREATE TABLE ALUMNOS(
	dni varchar(10),
    nombre varchar(15),
    apellido1 varchar(15),
    apellido2 varchar(15),
    direccion varchar(30),
    sexo enum ('H', 'M'),
    fecha_nacimiento date,
    curso int NOT NULL,
	
    CONSTRAINT DNI_PK PRIMARY KEY (dni),
    CONSTRAINT CURSO_FK FOREIGN KEY (curso) REFERENCES CURSOS (cod)
);

/*---------- INSERTAR TUPLAS EN ALUMNOS ----------*/
INSERT INTO ALUMNOS VALUES ('123523', 'Lucas', 'Manilva', 'López', 'Alhamar, 3', 'H', '1979/1/1', 1);
INSERT INTO ALUMNOS VALUES ('4896765', 'Jose', 'Pérez', 'Caballar', 'Jarcha, 5', 'H', '1977/2/3', 1);
INSERT INTO ALUMNOS (dni, nombre, apellido1, apellido2, direccion, sexo, curso) VALUES ('2567567', 'Antonia', 'Lopez', 'Alcántara', 'Maniquí, 21', 'M', 1);
INSERT INTO ALUMNOS (dni, nombre, apellido1, apellido2, direccion, curso) VALUES ('3123689', 'Manuel', 'Alcántara', 'Pedroso', 'Julián, 2', 2);
INSERT INTO ALUMNOS (dni, nombre, apellido1, apellido2, sexo, curso) VALUES ('6532934', 'Sergio', 'Navas', 'Retal', 'H', 2);
INSERT INTO ALUMNOS VALUES ('789678', 'María', 'Jaén', 'Sevilla', 'Martos, 5', 'M', '1977/3/10', 3); -- Al haber eliminado la clave foranea, te deja poner curso 3, si no no.

/*---------- MODIFICAR RESTRICCIONES EN ALUMNOS ----------*/
ALTER TABLE ALUMNOS MODIFY sexo VARCHAR(10);
ALTER TABLE ALUMNOS ADD CONSTRAINT unique_curso UNIQUE (curso); -- Esto da un error ya que no puede ser unique ya que eso te indica que a un alumno le pertenece un unico curso(no se puede repetir en toda la tabla)
ALTER TABLE ALUMNOS DROP CONSTRAINT CURSO_FK;

/*---------- VER EL CONTENIDO DE ALUMNOS ----------*/
SELECT * FROM ALUMNOS;



/*----------------------------------------------------------------------------------------------------------------------------------------------*/



/*---------- CREAR TABLA NOMBRE_DE_ALUMNOS ----------*/
CREATE  TABLE NOMBRE_DE_ALUMNOS (
    nombre_completo VARCHAR(60)
);

/*---------- INSERTAR TUPLAS EN NOMBRE_DE_ALUMNOS ----------*/
INSERT INTO NOMBRE_DE_ALUMNOS (nombre_completo) SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) FROM ALUMNOS;

/*---------- ELEMINIR LA TABLA NOMBRE_DE_ALUMNOS ----------*/
SELECT * FROM NOMBRE_DE_ALUMNOS;

/*---------- ELEMINIR LA TABLA NOMBRE_DE_ALUMNOS ----------*/
DROP TABLE NOMBRE_DE_ALUMNOS;


