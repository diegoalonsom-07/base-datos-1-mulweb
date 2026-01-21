/*---------- EJERCICIO CENAS DE NOCHEBUENA ----------*/

/*---------- GENERAR LA TABLA PERSONAS ----------*/
CREATE TABLE PERSONAS (
	id_pers int AUTO_INCREMENT,
    nombre_completo varchar(30),
    telefono varchar(9),
	lugar_cena int,
    
    
    CONSTRAINT ID_PERSONAS_PK PRIMARY KEY (id_pers),
    CONSTRAINT TELEFONO_UK UNIQUE KEY (telefono),
    CONSTRAINT LUGAR_CENA_FK FOREIGN KEY (lugar_cena) REFERENCES LUGARES (id_lugar) ON DELETE SET NULL ON UPDATE CASCADE
);

/*---------- GENERAR LA TABLA LUGARES ----------*/
CREATE TABLE LUGARES (
	id_lugar int AUTO_INCREMENT,
    descripción varchar(50),
	dirección varchar(30),
    localidad int,
    
    
    CONSTRAINT ID_LUGAR_PK PRIMARY KEY (id_lugar),
    CONSTRAINT LOCALIDAD_FK FOREIGN KEY (localidad) REFERENCES LOCALIDADES (id_localidad) ON DELETE SET NULL ON UPDATE CASCADE
);

/*---------- GENERAR LA TABLA LOCALIDADES ----------*/
CREATE TABLE LOCALIDADES (
	id_localidad int AUTO_INCREMENT,
    nombre varchar(20),
	provincia int,
    
    
    CONSTRAINT ID_LOCALIDAD_PK PRIMARY KEY (id_localidad),
    CONSTRAINT PROVINCIA_FK FOREIGN KEY (provincia) REFERENCES PROVINCIAS (id_provincia) ON DELETE SET NULL ON UPDATE CASCADE
);

/*---------- GENERAR LA TABLA PROVINCIAS ----------*/
CREATE TABLE PROVINCIAS (
	id_provincia int AUTO_INCREMENT,
    nombre varchar(20) NOT NULL,

    
    CONSTRAINT ID_PROVINCIA_PK PRIMARY KEY (id_provincia)
);

/*---------- GENERAR LA TABLA ALLEGADOS ----------*/
CREATE TABLE ALLEGADOS (
    id_Persona1 INT,
    id_Persona2 INT,
    relacion ENUM('Pareja', 'Familia', 'Amigos'),
    
    
    PRIMARY KEY (id_Persona1, id_Persona2),
    CONSTRAINT ID_PERSONA1_FK FOREIGN KEY (id_Persona1) REFERENCES PERSONAS (id_pers) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ID_PERSONA2_FK FOREIGN KEY (id_Persona2) REFERENCES PERSONAS (id_pers) ON DELETE CASCADE ON UPDATE CASCADE
);

/*---------- MODIFICACIONES DE TABLAS ----------*/
ALTER TABLE Personas MODIFY nombreCompleto varchar(30) NOT NULL;
ALTER TABLE PROFESORES ADD CONSTRAINT unique_dni UNIQUE (dni);
ALTER TABLE PROFESORES ADD CONSTRAINT unique_dni UNIQUE (dni);
ALTER TABLE PROFESORES ADD CONSTRAINT unique_dni UNIQUE (dni);






/*---------- EJERCICIO CENAS DE NOCHEBUENA ----------*/

/*---------- TABLA COMUNIDADES AUTONOMAS ----------*/
CREATE TABLE COMUNIDADES_AUTONOMAS (
    id_comunidad INT,
    nombre VARCHAR(100) NOT NULL,
    
    CONSTRAINT ID_COMUNIDAD_PK PRIMARY KEY (id_comunidad)
);

/*---------- TABLA VACUNAS ----------*/
CREATE TABLE VACUNAS (
    id_vacuna INT,
    nombre VARCHAR(100) NOT NULL,
    
    CONSTRAINT ID_VACUNA_PK PRIMARY KEY (id_vacuna)
);

/*---------- TABLA COMPRAS ----------*/
CREATE TABLE COMPRAS (
    id_compra INT,
    fecha DATE,
    tipo_vacuna INT NOT NULL,
    cantidad_comprada INT NOT NULL,
    precio DECIMAL(10,2),
	
    CONSTRAINT ID_COMPRA_PK PRIMARY KEY (id_compra),
    CONSTRAINT fk_compra_vacuna FOREIGN KEY (tipo_vacuna) REFERENCES VACUNAS(id_vacuna) ON UPDATE CASCADE
);

/*---------- TABLA CENTROS DE SALUD ----------*/
CREATE TABLE CENTROS_DE_SALUD (
    id_centro INT,
    nombre VARCHAR(100) NOT NULL,
    comunidad INT,

    CONSTRAINT ID_CENTRO_PK PRIMARY KEY (id_centro),
    CONSTRAINT fk_centro_comunidad FOREIGN KEY (comunidad) REFERENCES COMUNIDADES_AUTONOMAS(id_comunidad) ON UPDATE CASCADE ON DELETE SET NULL
);

/*---------- TABLA PERSONAS ----------*/
CREATE TABLE PERSONAS (
    id_persona INT,
    nombre VARCHAR(100) NOT NULL,
    edad INT CHECK (edad >= 0),
    sexo ENUM('Hombre', 'Mujer', 'Otro'),
    centro_de_salud INT NOT NULL,

    CONSTRAINT ID_PERSONA_PK PRIMARY KEY (id_persona),
    CONSTRAINT fk_persona_centro FOREIGN KEY (centro_de_salud) REFERENCES CENTROS_DE_SALUD(id_centro) ON UPDATE CASCADE ON DELETE CASCADE
);

/*---------- TABLA VACUNAS_PERSONAS ----------*/
CREATE TABLE VACUNAS_PERSONAS (
    persona INT,
    vacuna INT,
    fecha DATE,
    orden INT CHECK (orden IN (1,2)),

    CONSTRAINT ID_VP_PK PRIMARY KEY (persona, vacuna, fecha),
    CONSTRAINT fk_vp_persona FOREIGN KEY (persona) REFERENCES PERSONAS(id_persona) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_vp_vacuna FOREIGN KEY (vacuna) REFERENCES VACUNAS(id_vacuna) ON UPDATE CASCADE ON DELETE CASCADE
);

/*---------- MODIFICACIONES DE TABLAS ----------*/
ALTER TABLE COMPRAS DROP FOREIGN KEY fk_compra_vacuna;
ALTER TABLE CENTROS_DE_SALUD DROP FOREIGN KEY fk_centro_comunidad;
ALTER TABLE PERSONAS DROP FOREIGN KEY fk_persona_centro;
ALTER TABLE VACUNAS_PERSONAS DROP FOREIGN KEY fk_vp_persona;
ALTER TABLE VACUNAS_PERSONAS DROP FOREIGN KEY fk_vp_vacuna;






/*---------- EJERCICIO SERVICIOS DE LAS QUITANIEVES ----------*/

/*---------- TABLA CENTROS ----------*/
CREATE TABLE CENTROS (
    id_centro INT,
    nombre VARCHAR(100) NOT NULL,
    
    CONSTRAINT ID_CENTRO_PK PRIMARY KEY (id_centro)
);

/*---------- TABLA QUITANIEVES ----------*/
CREATE TABLE QUITANIEVES (
    id_maquina INT,
    matricula VARCHAR(20) UNIQUE,
    añocompra INT,
    centro INT NOT NULL,
    
    CONSTRAINT ID_MAQUINA_PK PRIMARY KEY (id_maquina),
    FOREIGN KEY (centro) REFERENCES CENTROS(id_centro) ON UPDATE CASCADE ON DELETE CASCADE
);

/*---------- TABLA PUEBLOS ----------*/
CREATE TABLE PUEBLOS (
    id_pueblo INT,
    nombre VARCHAR(100) NOT NULL,
    centro INT NOT NULL,
    distancia INT,
    
    CONSTRAINT ID_PUEBLO_PK PRIMARY KEY (id_pueblo),
    FOREIGN KEY (centro) REFERENCES CENTROS(id_centro) ON UPDATE CASCADE ON DELETE CASCADE
);

/*---------- TABLA VOLUNTARIOS ----------*/
CREATE TABLE VOLUNTARIOS (
    id_voluntario INT,
    nombre VARCHAR(100) NOT NULL,
    edad INT,
    
    CONSTRAINT ID_VOLUNTARIO_PK PRIMARY KEY (id_voluntario)
);

/*---------- TABLA SERVICIOS ----------*/
CREATE TABLE SERVICIOS (
    maquina INT,
    voluntario INT,
    pueblo INT,
    fecha DATE,
    hora_inicio TIME,
    hora_fin TIME,
    observaciones TEXT,

    FOREIGN KEY (maquina) REFERENCES QUITANIEVES(id_maquina),
    FOREIGN KEY (voluntario) REFERENCES VOLUNTARIOS(id_voluntario),
    FOREIGN KEY (pueblo) REFERENCES PUEBLOS(id_pueblo)
);

/*---------- MODIFICACIONES DE TABLAS ----------*/
ALTER TABLE SERVICIOS ADD CONSTRAINT PK_Servicios PRIMARY KEY (maquina, voluntario, fecha, hora_inicio);
