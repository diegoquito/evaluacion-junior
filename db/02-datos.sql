USE Cartera;
GO
-- Las fechas se calculan a partir del día en que se ejecuta este script.
DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

SET IDENTITY_INSERT Cliente ON;
INSERT INTO Cliente (ClienteId, Identificacion, Nombres) VALUES
 (1, '0912345678', N'María Andrade'),
 (2, '1712345678', N'Jorge Castillo'),
 (3, '0102345678', N'Lucía Paredes'),
 (4, '1312345678', N'Andrés Mora'),
 (5, '0923456789', N'Roberto Salazar');
SET IDENTITY_INSERT Cliente OFF;

INSERT INTO ClienteContacto (ClienteId, Tipo, Valor, EsPrincipal) VALUES
 (1, 'TELEFONO', N'0991234567', 1),
 (1, 'TELEFONO', N'042345678', 0),
 (1, 'EMAIL',    N'maria.andrade@correo.com', 1),
 (3, 'TELEFONO', N'0987654321', 1),
 (4, 'EMAIL',    N'andres.mora@correo.com', 1);

SET IDENTITY_INSERT Contrato ON;
INSERT INTO Contrato (ContratoId, ClienteId, NumeroContrato, Producto, Estado, FechaFirma) VALUES
 (1, 1, 'CT-2024-0001', N'Plan de previsión familiar',   'ACTIVO',    DATEADD(MONTH, -8,  @hoy)),
 (2, 1, 'CT-2024-0002', N'Lote familiar',                'ANULADO',   DATEADD(MONTH, -7,  @hoy)),
 (3, 1, 'CT-2023-0003', N'Servicio exequial',            'CANCELADO', DATEADD(MONTH, -20, @hoy)),
 (4, 2, 'CT-2024-0004', N'Nicho',                        'ACTIVO',    DATEADD(MONTH, -6,  @hoy)),
 (5, 3, 'CT-2024-0005', N'Plan de previsión individual', 'ACTIVO',    DATEADD(MONTH, -5,  @hoy)),
 (6, 4, 'CT-2024-0006', N'Lote familiar',                'ACTIVO',    DATEADD(MONTH, -6,  @hoy));
SET IDENTITY_INSERT Contrato OFF;

-- Columnas: ContratoId, NumeroCuota, meses respecto a hoy, Monto, Pagada
INSERT INTO Cuota (ContratoId, NumeroCuota, FechaVencimiento, Monto, SaldoPendiente, Pagada)
SELECT ContratoId, NumeroCuota, DATEADD(MONTH, Meses, @hoy), Monto,
       CASE WHEN Pagada = 1 THEN 0 ELSE Monto END, Pagada
FROM (VALUES
 (1,1,-6,150.00,1),(1,2,-5,150.00,1),(1,3,-4,150.00,1),
 (1,4,-3,150.00,0),(1,5,-2,150.00,0),(1,6,-1,150.00,0),
 (1,7, 1,150.00,0),(1,8, 2,150.00,0),
 (2,1,-4,200.00,0),(2,2,-3,200.00,0),(2,3,-2,200.00,0),(2,4,-1,200.00,0),
 (3,1,-20,100.00,1),(3,2,-19,100.00,1),(3,3,-18,100.00,1),
 (3,4,-17,100.00,1),(3,5,-16,100.00,1),(3,6,-15,100.00,1),
 (4,1,-4,120.00,0),(4,2,-3,120.00,0),(4,3,-2,120.00,0),(4,4,-1,120.00,0),
 (4,5, 1,120.00,0),(4,6, 2,120.00,0),
 (5,1,-4,90.00,1),(5,2,-3,90.00,1),(5,3,-2,90.00,0),(5,4,-1,90.00,0),
 (5,5, 0,90.00,0),(5,6, 1,90.00,0),
 (6,1,-3,180.00,0),(6,2,-2,180.00,0),(6,3,-1,180.00,0),(6,4, 1,180.00,0)
) AS v(ContratoId, NumeroCuota, Meses, Monto, Pagada);

DECLARE @i INT = 1;
WHILE @i <= 12
BEGIN
    INSERT INTO Contrato (ClienteId, NumeroContrato, Producto, Estado, FechaFirma)
    VALUES (5, CONCAT('CT-2025-', RIGHT('0000' + CAST(100 + @i AS VARCHAR(4)), 4)),
            N'Plan de previsión individual', 'ACTIVO', DATEADD(MONTH, -@i, @hoy));

    INSERT INTO Cuota (ContratoId, NumeroCuota, FechaVencimiento, Monto, SaldoPendiente, Pagada)
    VALUES (SCOPE_IDENTITY(), 1, DATEADD(MONTH, 1, @hoy), 75.00, 75.00, 0);

    SET @i += 1;
END
GO
