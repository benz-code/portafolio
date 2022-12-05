CREATE DATABASE Northwind;

USE Northwind;

CREATE PROCEDURE customersList
AS
BEGIN -- opcional, perp es buena practica 
     SELECT CompanyName, ContactName  
	 FROM Customers ORDER BY CompanyName
END; --finaliza la declaracion 

--ejecutar procedimiento
EXECUTE customersList;
EXEC customersList;

ALTER PROCEDURE customersList
@city NVARCHAR(5),
@cName NVARCHAR(5)
AS
BEGIN -- opcional, perp es buena practica 
     SELECT CompanyName, ContactName  
	 FROM Customers 
	 WHERE City LIKE @CITY+'%' 
	 AND CompanyName LIKE @cName+'%'
	 ORDER BY CompanyName
END; --finaliza la declaracion 

EXEC customersList @cName='A', @city='M'
EXEC customersList 'M', 'A'

--Insertar registro a traves de un procedimiento 
--Colocar parametros en parentesis (buena practica)
CREATE PROCEDURE saveCustomers(
@cID NVARCHAR(5), @cName NVARCHAR (40)
)
AS
    IF(SELECT COUNT(*)FROM Customers
	WHERE CustomerID=@cID OR CompanyName=@cName)=0
	--Si el resultado es 0 entonces guardara el registro 
	INSERT INTO Customers(CustomerID, CompanyName)
	     VALUES(@cID, @cName)
	ELSE
	    PRINT 'El cliente ya se registro'

EXEC saveCustomers 'C01N', 'Customer 1';
EXEC saveCustomers 'ANTON', 'Customer 2';
EXEC saveCustomers 'C02N', 'Around the Horn';

--1. Crear un procedimiento que guarde un nuevo registro 
--en la tabla region.
CREATE PROCEDURE Ben(
@Cid NVARCHAR(50)
)
AS
IF(SELECT COUNT(*) FROM Region
WHERE RegionDescription=@Cid) = 0
INSERT INTO  Region(RegionDescription)
VALUES (@Cid)
ELSE
PRINT 'El cliente esta registrado'


EXEC Ben 'Eastern' ;



--Continuidad 
--Obtener parametro de salida
CREATE PROCEDURE getProducts(
@nProduct AS NVARCHAR(10),
@totalP INT OUTPUT --parametro de salida 
) AS 
    SELECT ProductName, UnitPrice FROM Products
	WHERE ProductName LIKE @nProduct+'%'
	SELECT @totalP=@@ROWCOUNT 
--dEFINIR UNA VARIABLE PARA ALMACENAR EL VALOR DE RETORNO 
DECLARE @total INT;
EXECUTE getProducts 'e', @total OUTPUT;
SELECT @total AS 'Cantidad de productos';

--2. Motrar a traves de un parametro de salida
--cuantos empleados viven en London

ALTER PROCEDURE getRegion(
@nCiudad AS NVARCHAR(10),
@totalP INT OUTPUT --parametro de salida 
) AS 
    SELECT City FROM Employees
	WHERE City = @nCiudad
	SELECT @totalP=@@ROWCOUNT 
--DEFINIR UNA VARIABLE PARA ALMACENAR EL VALOR DE RETORNO 
DECLARE @total INT;
EXECUTE getRegion 'London', @total OUTPUT;
SELECT @total 
