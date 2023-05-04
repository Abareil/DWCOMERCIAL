USE [DW_COMERCIAL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_carga_int_DIM_VENDEDOR]
AS
BEGIN

TRUNCATE TABLE [DW_COMERCIAL].[dbo].INT_DIM_VENDEDOR 

INSERT INTO [DW_COMERCIAL].[dbo].INT_DIM_VENDEDOR (
    COD_VENDEDOR, 
    NOMBRE,
    APELLIDO,
    FLAG
)

SELECT  COD_VENDEDOR, 
CONCAT(SUBSTRING(DESC_VENDEDOR, 0, CHARINDEX(' ', DESC_VENDEDOR)),
SUBSTRING(DESC_VENDEDOR, CHARINDEX(' ', DESC_VENDEDOR), 
CHARINDEX(' ', SUBSTRING(DESC_VENDEDOR,CHARINDEX(' ', DESC_VENDEDOR)+1, 20))))   AS nombre,
SUBSTRING(DESC_VENDEDOR,CHARINDEX(' ', DESC_VENDEDOR)+CHARINDEX(' ', SUBSTRING(DESC_VENDEDOR,CHARINDEX(' ', DESC_VENDEDOR) +1, 20))
,20) AS apellido,
    CASE 
    WHEN rep > 1 OR flag = '-1' THEN 'N'
    ELSE 'S' 
    END AS FLAG
FROM (
    SELECT COD_VENDEDOR, DESC_VENDEDOR,
        CASE
        WHEN [DESC_VENDEDOR] IS NULL OR [COD_VENDEDOR] IS NULL
        THEN '-1'
        ELSE '1'
        END AS flag,
    ROW_NUMBER() OVER ( PARTITION BY COD_VENDEDOR, DESC_VENDEDOR ORDER BY COD_VENDEDOR DESC) AS rep    
    FROM [DW_COMERCIAL].[dbo].STG_DIM_VENDEDOR) AS SUB

END