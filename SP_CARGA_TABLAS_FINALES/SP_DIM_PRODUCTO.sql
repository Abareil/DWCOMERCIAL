USE [DW_COMERCIAL]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_carga_DIM_PRODUCTO]

@usu NVARCHAR(10)
AS
BEGIN 

DECLARE @fecha SMALLDATETIME
SET @fecha = GETDATE()

UPDATE DP
SET  DP.[COD_PRODUCTO] = IDP.COD_PRODUCTO
    ,DP.[DESC_PRODUCTO] = IDP.DESC_PRODUCTO
    ,DP.FECHA_UPDATE = @fecha
    ,DP.USUARIO_UPDATE = @usu
FROM [DW_COMERCIAL].[dbo].DIM_PRODUCTO AS DP
JOIN [DW_COMERCIAL].[dbo].INT_DIM_PRODUCTO AS IDP 
ON DP.COD_PRODUCTO = IDP.COD_PRODUCTO

INSERT INTO [DW_COMERCIAL].[dbo].DIM_PRODUCTO(
    [COD_PRODUCTO]
    ,[DESC_PRODUCTO]
    ,[FECHA_ALTA]
    ,[USUARIO_ALTA]
    ,[FECHA_UPDATE]
    ,[USUARIO_UPDATE]
)

SELECT
    IDP.[COD_PRODUCTO]
    ,IDP.[DESC_PRODUCTO]
    ,CASE WHEN FECHA_ALTA IS NULL THEN @fecha
    END
    ,CASE WHEN USUARIO_ALTA IS NULL THEN @usu
    END
    ,@fecha
    ,@usu
    
FROM [DW_COMERCIAL].[dbo].INT_DIM_PRODUCTO AS IDP
LEFT JOIN [DW_COMERCIAL].[dbo].DIM_PRODUCTO AS DP
ON IDP.COD_PRODUCTO = DP.COD_PRODUCTO
WHERE IDP.FLAG = 'S'
AND DP.COD_PRODUCTO IS NULL

END