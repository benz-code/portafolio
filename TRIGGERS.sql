USE Hotel

--Tabla de reservas
CREATE TABLE RESERVA.reservas(
idReserva INT IDENTITY(1,1) PRIMARY KEY,
FechaDeEntrada VARCHAR(20),
FechaDeSalida VARCHAR(20)
);

--Tabla que almacena los cambios en RESERVA.reserva
CREATE TABLE RESERVA.cambios(
	changeID INT IDENTITY(1,1) PRIMARY KEY,
	idReserva INT NOT NULL,
	fechadeentrada VARCHAR(20),
	fechadesalida VARCHAR(20),
	dateUpdate DATETIME NOT NULL,
	actionE VARCHAR(10),
	CHECK(actionE='INSERT' OR actionE='DELETE')
);

--Trigger 
CREATE OR ALTER TRIGGER RESERVA.cambios
ON RESERVA.reservas
AFTER INSERT, DELETE
AS 
	BEGIN 
		SET NOCOUNT ON;
		INSERT INTO RESERVA.cambios(idReserva, fechadeentrada, fechadesalida, dateUpdate, actionE)
		
		SELECT 
				i.idReserva,
				fechadeentrada,
				fechadesalida,
				GETDATE(),
				'INSERT'
		FROM inserted i
		
		UNION ALL 
		SELECT 
			d.idReserva,
			fechadeentrada,
			fechadesalida,
			GETDATE()
			'DELETE'
		FROM deleted d
	END;


CREATE TRIGGER RESERVAupdate
ON RESERVA.reserva
AFTER UPDATE
AS 
	IF UPDATE(fechadeentrada)
	BEGIN 
		PRINT 'Se actualizo la fecha de entreda del cliente'
	END;

INSERT INTO RESERVA.reserva(fechadeentrada,fechadesalida)
VALUES('20.08.2022','05.09.2022')

UPDATE RESERVA.reserva SET fechadeentrada='30.08.2022', fechadesalida='05.09.2022' WHERE idReserva=251

SELECT * FROM RESERVA.reserva
