USE [DW_COMERCIAL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_carga_int_FACT_VENTAS]
AS

TRUNCATE TABLE [DW_COMERCIAL].[dbo].[INT_FACT_VENTAS] 

INSERT INTO [DW_COMERCIAL].[dbo].[INT_FACT_VENTAS](
    COD_PRODUCTO,
    COD_CATEGORIA ,
    COD_CLIENTE,
    COD_PAIS,
    COD_VENDEDOR,
    COD_SUCURSAL,
    Fecha,
    CANTIDAD_VENDIDA,
    MONTO_VENDIDO,
    PRECIO,
    COMISION_COMERCIAL,
    FLAG
)
SELECT COD_PRODUCTO,
        COD_CATEGORIA ,
        COD_CLIENTE,
        COD_PAIS,
        COD_VENDEDOR,
        COD_SUCURSAL,
        CONVERT(smalldatetime, FECHA, 103) AS Fecha,
        CAST(CANTIDAD_VENDIDA AS decimal(18,2)) AS CANTIDAD_VENDIDA,
        CAST(REPLACE(MONTO_VENDIDO, '.' , '') AS decimal(18,2)) AS MONTO_VENDIDO,
        CAST(REPLACE(PRECIO, ',' , '.') AS decimal(18,2)) AS PRECIO,
        CAST(REPLACE(REPLACE(COMISION_COMERCIAL, '.' , ''), ',','.') AS decimal(18,2)) AS COMISION_COMERCIAL,
        CASE 
        WHEN rep > 1 OR flag = '-1' THEN 'N'
        ELSE 'S' 
        END AS FLAG

    FROM (
        SELECT COD_PRODUCTO,
                COD_CATEGORIA ,
                COD_CLIENTE,
                COD_PAIS,
                COD_VENDEDOR,
                COD_SUCURSAL,
                Fecha,
                CANTIDAD_VENDIDA,
                MONTO_VENDIDO,
                PRECIO,
                COMISION_COMERCIAL,
                CASE 
                WHEN [COD_CLIENTE] IS NULL
                OR [COD_VENDEDOR] IS NULL
                OR [COD_SUCURSAL] IS NULL
                OR [FECHA] IS NULL
                OR [CANTIDAD_VENDIDA] IS NULL
                OR [PRECIO] IS NULL
                OR [MONTO_VENDIDO] IS NULL
                OR [COMISION_COMERCIAL] IS NULL
                THEN '-1'
                ELSE '1'
                END AS flag,
        ROW_NUMBER() OVER (PARTITION BY COD_CLIENTE, fecha, COD_VENDEDOR, COD_PRODUCTO, MONTO_VENDIDO ORDER BY COD_CLIENTE) AS rep
        FROM [DW_COMERCIAL].[dbo].STG_FACT_VENTAS) AS subquery