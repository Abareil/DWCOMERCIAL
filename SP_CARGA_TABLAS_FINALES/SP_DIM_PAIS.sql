USE [DW_COMERCIAL]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_carga_DIM_PAIS]
@usu NVARCHAR(10)
AS 
BEGIN 

DECLARE @fecha SMALLDATETIME
SET @fecha = GETDATE()

UPDATE DP
SET  DP.[COD_PAIS] = IDP.COD_PAIS
    ,DP.[DESC_PAIS] = IDP.DESC_PAIS
    ,DP.FECHA_UPDATE = @fecha
    ,DP.USUARIO_UPDATE = @usu
FROM [DW_COMERCIAL].[dbo].DIM_PAIS AS DP
JOIN [DW_COMERCIAL].[dbo].INT_DIM_PAIS AS IDP 
ON DP.COD_PAIS = IDP.COD_PAIS

INSERT INTO [DW_COMERCIAL].[dbo].DIM_PAIS(
    [COD_PAIS]
    ,[DESC_PAIS]
    ,[FECHA_ALTA]
    ,[USUARIO_ALTA]
    ,[FECHA_UPDATE]
    ,[USUARIO_UPDATE]
)
SELECT 
     IDP.[COD_PAIS]
    ,IDP.[DESC_PAIS]
    ,CASE WHEN FECHA_ALTA IS NULL THEN @fecha
    END
    ,CASE WHEN USUARIO_ALTA IS NULL THEN @usu
    END
    ,@fecha
    ,@usu

FROM [DW_COMERCIAL].[dbo].INT_DIM_PAIS AS IDP
LEFT JOIN [DW_COMERCIAL].[dbo].DIM_PAIS AS DP 
ON IDP.COD_PAIS = DP.COD_PAIS
WHERE IDP.FLAG = 'S'
AND DP.COD_PAIS IS NULL

END