USE [DW_COMERCIAL]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_carga_DIM_CATEGORIA]
@usu NVARCHAR(10)
AS 
BEGIN

DECLARE @fecha SMALLDATETIME
SET @fecha = GETDATE()

UPDATE DC
SET  DC.[COD_CATEGORIA] = IDC.COD_CATEGORIA
    ,DC.[DESC_CATEGORIA] = IDC.DESC_CATEGORIA
    ,DC.FECHA_UPDATE = @fecha
    ,dc.USUARIO_UPDATE = @usu
FROM [DW_COMERCIAL].[dbo].DIM_CATEGORIA AS DC
JOIN [DW_COMERCIAL].[dbo].INT_DIM_CATEGORIA AS IDC 
ON DC.COD_CATEGORIA = IDC.COD_CATEGORIA

INSERT INTO [DW_COMERCIAL].[dbo].DIM_CATEGORIA(
     [COD_CATEGORIA]
    ,[DESC_CATEGORIA]
    ,[FECHA_ALTA]
    ,[USUARIO_ALTA]
    ,[FECHA_UPDATE]
    ,[USUARIO_UPDATE]
)

SELECT 
     IC.[COD_CATEGORIA]
    ,IC.[DESC_CATEGORIA]
    ,CASE WHEN FECHA_ALTA IS NULL THEN @fecha
    END
    ,CASE WHEN USUARIO_ALTA IS NULL THEN @usu
    END
    ,@fecha
    ,@usu

FROM [DW_COMERCIAL].[dbo].INT_DIM_CATEGORIA AS IC
    LEFT JOIN DIM_CATEGORIA AS C
    ON C.COD_CATEGORIA = IC.COD_CATEGORIA
WHERE IC.FLAG = 'S'
AND C.COD_CATEGORIA IS NULL ;
END