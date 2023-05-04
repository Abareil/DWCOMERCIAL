USE [DW_COMERCIAL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_carga_int_DIM_CLIENTE]
AS
BEGIN

TRUNCATE TABLE [DW_COMERCIAL].[dbo].INT_DIM_CLIENTE 

INSERT INTO [DW_COMERCIAL].[dbo].INT_DIM_CLIENTE (
    COD_CLIENTE,
    NOMBRE,
    APELLIDO,
    FLAG
)

SELECT COD_CLIENTE, SUBSTRING(DESC_CLIENTE, 0, CHARINDEX(' ', DESC_CLIENTE)) AS nombre,
SUBSTRING(DESC_CLIENTE, CHARINDEX(' ', DESC_CLIENTE), 20) AS apellido,
    CASE 
    WHEN rep > 1 OR flag = '-1' THEN 'N'
    ELSE 'S' 
    END AS FLAG

FROM (
    SELECT COD_CLIENTE, DESC_CLIENTE, 
        CASE 
        WHEN [COD_CLIENTE] IS NULL OR [DESC_CLIENTE] IS NULL
        THEN '-1'
        ELSE '1'
        END AS flag,
        ROW_NUMBER() OVER ( PARTITION BY COD_CLIENTE, DESC_CLIENTE ORDER BY COD_CLIENTE DESC) AS rep
    FROM [DW_COMERCIAL].[dbo].STG_DIM_CLIENTE
) AS SUB

END