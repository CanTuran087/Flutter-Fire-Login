/*CREATE DATABASE LOGINDATABASE

GO

USE LOGINDATABASE

GO

CREATE TABLE LOGIN(
	user_id NVARCHAR(250),
	NAME VARCHAR(35),
	NAME2 VARCHAR(35),
	SURNAME VARCHAR(35),
	USERNAME VARCHAR(30),
	PASSWORD NVARCHAR(30),
	EMAIL VARCHAR(28),
	CREATEDBY VARCHAR(30),
	CREATEDAT DATETIME,
	CHANGEDBY VARCHAR(30),
	CHANGEDAT DATETIME
)

INSERT INTO LOGIN VALUES (NEWID(),'CAN','','TURAN','CANTURAN','C12345T','c@gmail.com','FLUTTER',GETDATE(),'FLUTTER',GETDATE())
*/

SELECT * FROM LOGIN