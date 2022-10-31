/* Código SQL -> Workbench -> MySql */

File -> New Query Tab (Nueva pestaña de Script)
File -> Save script As (Guardar)
Click derecho sobre la DB -> Drop Schema (Eliminar DB)

CREATE DATABASE Clase3;
USE Clase3;
SELECT * FROM Empleado;
SELECT * FROM Producto;
SELECT * FROM Categoria;

CREATE TABLE Empleado (
idEmpleado INT PRIMARY KEY,
nombre VARCHAR(30),
apellido VARCHAR(30),
edad TINYINT,
rfc CHAR(13)
);
CREATE TABLE RespaldoEmpleado (
idEmpleado INT PRIMARY KEY,
nombre VARCHAR(30),
apellido VARCHAR(30),
edad TINYINT,
rfc CHAR(13),
fechaRegistro DATETIME
);

SELECT * FROM Empleado;

CREATE TABLE Categoria (
idCategoria INT PRIMARY KEY,
nombreCategoria VARCHAR(40),
descripcion TEXT
);

CREATE TABLE RespaldoCategoria (
idRespaldoC INT PRIMARY KEY,
nombreCategoria VARCHAR (35),
descripcion TEXT,
fechaRegistro DATETIME
);

CREATE TABLE Compra(
idCompra INT PRIMARY KEY,
nombre VARCHAR (30),
idProducto_FK INT NOT NULL,
FOREIGN KEY (idProducto_FK) REFERENCES Producto (idProducto)
);

DROP TABLE Articulo;

CREATE TABLE Producto (
idProducto INT PRIMARY KEY,
nombreProducto VARCHAR(40) NOT NULL,
precio NUMERIC,
vigente BOOLEAN,
idCategoria_FK INT NOT NULL,
FOREIGN KEY (idCategoria_FK) REFERENCES Categoria (idCategoria)
);

CREATE TABLE Articulo(
idArticulo INT PRIMARY KEY auto_increment,
nombreArticulo VARCHAR(40) NOT NULL,
precio NUMERIC,
stock INT
);

SELECT * FROM Articulo;
INSERT into Articulo Values (6001, 'Audifonos', 30, 60);
INSERT into Articulo Values (6002, 'Tijeras', 20, 80);
INSERT into Articulo Values (6003, 'Carpetas', 10, 90);



SELECT * FROM Categoria;
SELECT * FROM Producto;



/* Insertar registros */
SELECT * FROM Empleado;
INSERT into Empleado Values (2001,'Stephanie', 'Pech', 18, 'PECS030919MYC');
INSERT into Empleado Values (2002,'Samir', 'Molina', 19, 'MOMA620HYNLRS');
INSERT into Empleado Values (2005,'Ivan', 'Arredondo', 32, 'HOMA750HYNLRS');



SELECT * FROM Categoria;
INSERT into Categoria Values (1001,'Bebidas', 'Decripción de Bebidas');
INSERT into Categoria Values (1002,'Embutidos', 'Decripción de Embutidos');
INSERT into Categoria Values (1003,'Lacteos', 'Decripción de Lacteos');

INSERT into Producto Values (1,'Bevi', 9, 1, 1001);
INSERT into Producto Values (2,'Jamon Fud', 38, 1, 1002);
INSERT into Producto Values (3,'Yomi Lala', 11, 0, 1003);
SELECT * FROM Producto;

DROP TABLE Compra;
SELECT * FROM Compra; 
INSERT into Compra Values (3001, 'Compra1', 1 );
INSERT into Compra Values (3002, 'Compra2', 2);
INSERT into Compra Values (3003, 'Compra3', 3);

/* Borrar registros*/
DELETE FROM Producto WHERE idProducto = 3;
DELETE FROM Producto WHERE nombreProducto = 'Yomi Lala';

/* Actualizar registros*/

UPDATE Producto SET Precio = 40  WHERE idProducto= 2;
UPDATE Producto SET nombreProducto = 'Bevi 350 ml'  
WHERE idProducto= 1;

/*Funciones definidas por el usuario en la BD clase3*/

SELECT * FROM Compra;

DELIMITER // 
CREATE FUNCTION DESCUENTO(total DECIMAL)
RETURNS DECIMAL
READS SQL DATA
DETERMINISTIC
BEGIN 
    DECLARE discount DECIMAL;
    SET discount = 0; 
    IF total >= 100 THEN 
    SET discount=  total-22; 
    END IF;
    RETURN discount;
END //

SELECT idCompra, cliente, DESCUENTO(total) AS DESCUENTO
FROM Compra;


  SELECT * FROM Products;
  
DELIMITER @@ 
CREATE FUNCTION IVA (cantidad DECIMAL (12,2))
RETURNS DECIMAL (12,2)
READS SQL DATA
DETERMINISTIC
BEGIN 
   DECLARE resultado DECIMAL (12,2);
   SET resultado = cantidad * 0.16;
   RETURN (resultado);
END @@

SELECT ProductID, ProductName, UnitPrice, IVA(UnitPrice)
FROM Products;

/*Los tres Procedimientos almacenados*/
SELECT * FROM Empleado;

-- Store Procedure INSERTAR --
DELIMITER $
CREATE PROCEDURE insertar (IN i INT, IN nom VARCHAR (35), IN ape VARCHAR (35),
In age TINYINT, In r CHAR(13))
  BEGIN 
      INSERT INTO Empleado (idEmpleado, nombre, apellido, edad, rfc)
      VALUES (i, nom, ape, age, r);
  END $
    DROP PROCEDURE insertar;

  CALL insertar(2004, 'Dennis', 'Pech', 52, 'ADOP290818MBL');
  
  SELECT * FROM Empleado;
  
  
    -- Store Procedure ACTUALIZAR --
  
SELECT * FROM Producto; 

UPDATE Cliente SET edad = 20 WHERE idCliente = 2;

DELIMITER //
CREATE PROCEDURE actualizar (IN idP INT, In pre NUMERIC)
BEGIN 
     UPDATE Producto SET precio=pre WHERE idProducto = idP;
  END //
  
DROP PROCEDURE eliminar;
CALL actualizar(1, 15);

    -- Store Procedure eliminar --

DELIMITER $$
CREATE PROCEDURE eliminar (IN idE INT)
BEGIN 
     DELETE FROM Empleado WHERE idEmpleado=idE;
  END $$

    CALL eliminar(2005);

SELECT * FROM Empleado;

/*Tres funciones sobre la BD Northwind*/

USE northwind;
-- Primera función--

DELIMITER @@
CREATE FUNCTION DESCUENTO(costo DECIMAL)
RETURNS DECIMAL (12,2)
	BEGIN 
		DECLARE descuento DECIMAL(12,2);
        set descuento = 0;
        IF costo >=120 then
        SET descuento=0.4;
        END IF;
        RETURN descuento;
    END @@
    
SELECT OrderID, productID, UnitPrice, DESCUENTO(UnitPrice) AS Descuento FROM orderdetails;
DROP FUNCTION DESCUENTO;

-- Segunda función--
SELECT * FROM Orderdetails;
DELIMITER @@
CREATE FUNCTION SUMA(dato1 DECIMAL)
RETURNS DECIMAL (12,2)
READS SQL DATA
DETERMINISTIC
	BEGIN 
		DECLARE suma DECIMAL(12,2);
        SET suma = 0;
        IF dato1 <= 100 THEN
        SET suma = 50;
        END IF;
        RETURN suma;
    END @@

SELECT OrderID, ProductID, UnitPrice, SUMA(UnitPrice) AS Suma FROM orderdetails;

     -- Tercera Funcion--
DELIMITER //
CREATE FUNCTION DESCUE(costo DECIMAL)
RETURNS DECIMAL 
READS SQL DATA
DETERMINISTIC
BEGIN 
    DECLARE discount DECIMAL;
    SET discount = 0; 
    IF costo <= 70 THEN 
    SET discount=30; 
    END IF;
    RETURN discount;
END //

SELECT ProductID, ProductName, UnitPrice, DESCUE(UnitPrice) AS Descuento
FROM Products;
SELECT * FROM Products;
DROP FUNCTION DESCUE;

/*Los tres Tiggers*/

     -- Primer Tigger--
CREATE TRIGGER RespaldoEmpleado
AFTER INSERT 
ON Empleado
FOR EACH ROW
  INSERT INTO RespaldoEmpleado
  VALUES (new.idEmpleado, new.nombre, new.apellido, new.edad, new.rfc, now() );
  
DROP TRIGGER RespaldoEmpleado;

INSERT INTO Empleado VALUES (1, 'Alejandro','Martin','18','47555dfeg59');
INSERT INTO Empleado VALUES (2, 'Zapata','Martin','19','58855hofr5c');

SELECT * FROM Empleado;
SELECT * FROM RespaldoEmpleado;

          -- Segundo Tigger--
SELECT * FROM Categoria;

CREATE TRIGGER RespaldoDeCategoria
AFTER INSERT
ON Categoria
FOR EACH ROW 
    INSERT INTO RespaldoCategoria
    VALUES (new.idCategoria, new.nombreCategoria, new.descripcion, now());
    
DROP TRIGGER RespaldoCategoria;
    
INSERT INTO Categoria VALUES(4004,'Tecnonología', 'Descripción de Tecno');
INSERT INTO Categoria VALUES (4005,'Dulcería', 'Descripción de Dulces');
INSERT INTO Categoria VALUES(4006,'Ropa', 'Descripción de Ropa');

SELECT * FROM RespaldoCategoria;

     -- Tercer Tigger--

CREATE TABLE Aliado (
idAliado INT PRIMARY KEY,
dueño VARCHAR(35),
Empresa VARCHAR(35)
);

DROP TABLE Aliado;

CREATE TABLE RespaldoAliado (
idRespaldoA INT PRIMARY KEY,
dueño VARCHAR (35),
Empresa VARCHAR(35),
fechaVenta DATETIME
);

DROP TABLE RespaldoAliado;

CREATE TRIGGER RespaldoDeAliado
AFTER INSERT 
ON Aliado
FOR EACH ROW
  INSERT INTO RespaldoAliado
  VALUES (new.idAliado, new.dueño, new.Empresa, now() );
  
INSERT INTO Aliado VALUES (1, 'Alberto May','Samsung Electronics.');
INSERT INTO Aliado VALUES (2, 'Aldo Herrera','Apple');
INSERT INTO Aliado VALUES (3, 'Manuel Montes','Xaiomi');
INSERT INTO Aliado VALUES (4, 'Alejandro Zuares','Logics ML');
INSERT INTO Aliado VALUES (5, 'Daniel Cordova','Armets');
INSERT INTO Aliado VALUES (6, 'José Herrera','Mecatronics');

SELECT * FROM Aliado;
SELECT * FROM RespaldoAliado;
