USE AdventureWorks2019
--ELIEZER BENJAMIN DIAZ SEGOVIA SMIS022521
--FUNCION QUE CALCULA LA EDAD DE UNA PERSONA

CREATE OR ALTER FUNCTION Teneredad(
    @date DATETIME
)
RETURNS INT
AS
BEGIN RETURN (
    DATEDIFF(YY, @date, GETDATE())
    )
END;


--LA MISMA FUNCION QUE CALCULA LA EDAD PERO EN LA TABLA HumanResources.Employee
SELECT BirthDate 'Fecha de nacimiento', dbo.Teneredad(BirthDate) 'Edad'
FROM HumanResources.Employee;


-- FUNCIÓN QUE DEVUELVA LOS PRODUCTOS FILTRADO POR FECHA DE MODIFICACIÓN
CREATE OR ALTER FUNCTION Datosproductos()
RETURNS @pDatos TABLE(name VARCHAR(50), ProductNumber NVARCHAR(25), ListPrice MONEY, ModifiedDate DATETIME)
AS
BEGIN
	INSERT INTO @pDatos
		SELECT Name, ProductNumber, ListPrice, ModifiedDate FROM Production.Product 
		ORDER BY ModifiedDate ASC;
RETURN
END;

SELECT * FROM Datosproductos();

