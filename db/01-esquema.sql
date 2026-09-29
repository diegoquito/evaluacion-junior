IF DB_ID('Cartera') IS NOT NULL
BEGIN
    ALTER DATABASE Cartera SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Cartera;
END
GO
CREATE DATABASE Cartera;
GO
USE Cartera;
GO
CREATE TABLE Cliente (
    ClienteId       INT IDENTITY(1,1) PRIMARY KEY,
    Identificacion  VARCHAR(13)   NOT NULL UNIQUE,
    Nombres         NVARCHAR(150) NOT NULL
);

CREATE TABLE ClienteContacto (
    ContactoId   INT IDENTITY(1,1) PRIMARY KEY,
    ClienteId    INT NOT NULL REFERENCES Cliente(ClienteId),
    Tipo         VARCHAR(10)   NOT NULL,   -- TELEFONO | EMAIL
    Valor        NVARCHAR(100) NOT NULL,
    EsPrincipal  BIT NOT NULL DEFAULT 0
);

CREATE TABLE Contrato (
    ContratoId      INT IDENTITY(1,1) PRIMARY KEY,
    ClienteId       INT NOT NULL REFERENCES Cliente(ClienteId),
    NumeroContrato  VARCHAR(20)   NOT NULL,
    Producto        NVARCHAR(100) NOT NULL,
    Estado          VARCHAR(10)   NOT NULL,  -- ACTIVO | CANCELADO | ANULADO
    FechaFirma      DATE NOT NULL
);

CREATE TABLE Cuota (
    CuotaId           INT IDENTITY(1,1) PRIMARY KEY,
    ContratoId        INT NOT NULL REFERENCES Contrato(ContratoId),
    NumeroCuota       INT NOT NULL,
    FechaVencimiento  DATE NOT NULL,
    Monto             DECIMAL(12,2) NOT NULL,
    SaldoPendiente    DECIMAL(12,2) NOT NULL,
    Pagada            BIT NOT NULL DEFAULT 0
);
GO
