CREATE DATABASE Daspo;
USE Daspo;
CREATE TABLE Respuesta_Usuario(
	ID INT PRIMARY KEY IDENTITY, 
	Respuesta text NULL,
	Fecha_Respuesta DATETIME, 
	ID_usuario INT,
	ID_test INT, 
	ID_pregunta INT, 
	FOREIGN KEY ID_usuario REFERENCES usuario(ID), 
	FOREIGN KEY ID_test REFERENCES test_de_valoracion(ID_Test), 
	FOREIGN KEY ID_pregunta REFERENCES pregunta_test(ID)
);
--Tabla: Rol
CREATE TABLE Rol(ID INT PRIMARY KEY IDENTITY, 
	Nombre_Rol NVARCHAR(50) NULL,
	ID_usuario INT , 
	FOREIGN KEY(ID_usuario) REFERENCES usuario(ID)
);
-- Tabla: usuario
CREATE TABLE usuario (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  Nombre VARCHAR(50) NULL,
  Nombre_de_Usuario VARCHAR(50) NULL,
  Apellido VARCHAR(50) NULL,
  Correo VARCHAR(100) NULL,
  Contraseña VARCHAR(255) NULL,
  Telefono VARCHAR(15) NULL,
  Rol INT NULL,
  activo BIT DEFAULT 1
);

-- Tabla: test_de_valoracion
CREATE TABLE test_de_valoracion (
  ID_Test INT IDENTITY(1,1) PRIMARY KEY,
  Nombre VARCHAR(100) NULL,
  Descripcion VARCHAR(MAX) NULL
);

-- Tabla: articulo
CREATE TABLE articulo (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  Titulo VARCHAR(100) NULL,
  Contenido VARCHAR(MAX) NULL,
  Imagen VARCHAR(255) NULL,
  Hora TIME NULL,
  Fecha_Publicacion DATETIME NULL,
  activo BIT DEFAULT 1
);

-- Tabla: comentario
CREATE TABLE comentario (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  ID_Articulo INT NULL,
  Contenido VARCHAR(MAX) NULL,
  Fecha_Comentario DATETIME NULL,
  Hora TIME NULL,
  ID_Comentario INT NULL,
  ID_Usuario INT NULL,
  activo BIT DEFAULT 1,
  FOREIGN KEY (ID_Articulo) REFERENCES articulo(ID),
  FOREIGN KEY (ID_Usuario) REFERENCES usuario(ID)
);

-- Tabla: foro
CREATE TABLE foro (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  Titulo VARCHAR(100) NULL,
  Contenido VARCHAR(MAX) NULL,
  Fecha_Publicacion DATETIME NULL,
  Hora TIME NULL,
  Estado VARCHAR(20) NULL,
  ID_Usuario INT NULL,
  activo BIT DEFAULT 1,
  FOREIGN KEY (ID_Usuario) REFERENCES usuario(ID)
);

-- Tabla: comentarios_foro
CREATE TABLE comentarios_foro (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  ID_Foro INT NULL,
  ID_Usuario INT NULL,
  Contenido VARCHAR(MAX) NULL,
  Fecha_Comentario DATETIME NULL,
  activo BIT DEFAULT 1,
  FOREIGN KEY (ID_Foro) REFERENCES foro(ID),
  FOREIGN KEY (ID_Usuario) REFERENCES usuario(ID)
);

-- Tabla: datos_personas
CREATE TABLE datos_personas (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  Nombre VARCHAR(50) NULL,
  Apellido VARCHAR(50) NULL,
  Correo VARCHAR(100) NULL,
  Telefono VARCHAR(15) NULL,
  id_usuario INT NULL,
  FOREIGN KEY (ID) REFERENCES usuario(ID)
);

-- Tabla: pregunta_test
CREATE TABLE pregunta_test (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  Texto_Pregunta VARCHAR(MAX) NULL,
  Tipo_Respuesta VARCHAR(50) NULL,
  Opciones_Respuesta VARCHAR(MAX) NULL,
  ID_Test INT NULL,
  activo BIT DEFAULT 1,
  FOREIGN KEY (ID_Test) REFERENCES test_de_valoracion(ID_Test)
);

-- Tabla: recursos_apoyo
CREATE TABLE recursos_apoyo (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  Nombre VARCHAR(100) NULL,
  Tipo VARCHAR(50) NULL,
  Descripcion VARCHAR(MAX) NULL,
  URL VARCHAR(255) NULL,
  Documento VARCHAR(255) NULL,
  Fecha_Publicacion DATETIME NULL
);

-- Tabla: publica
CREATE TABLE publica (
  ID_Usuario INT NOT NULL,
  ID_Articulo INT NOT NULL,
  activo BIT DEFAULT 1,
  PRIMARY KEY (ID_Usuario, ID_Articulo),
  FOREIGN KEY (ID_Usuario) REFERENCES usuario(ID),
  FOREIGN KEY (ID_Articulo) REFERENCES articulo(ID)
);