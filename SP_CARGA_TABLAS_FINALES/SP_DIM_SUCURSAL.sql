USE [DW_COMERCIAL]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_carga_DIM_SUCURSAL]
@usu NVARCHAR(10)
AS 
BEGIN

DECLARE @fecha SMALLDATETIME
SET @fecha = GETDATE()


UPDATE DS
SET  DS.[COD_SUCURSAL] = IDS.COD_SUCURSAL
    ,DS.[DESC_SUCURSAL] = IDS.DESC_SUCURSAL
    ,DS.FECHA_UPDATE = @fecha
    ,DS.USUARIO_UPDATE = @usu
FROM [DW_COMERCIAL].[dbo].DIM_SUCURSAL AS DS
JOIN [DW_COMERCIAL].[dbo].INT_DIM_SUCURSAL AS IDS 
ON DS.COD_SUCURSAL = IDS.COD_SUCURSAL


INSERT INTO [DW_COMERCIAL].[dbo].DIM_SUCURSAL(
[COD_SUCURSAL]
,[DESC_SUCURSAL]
    ,[FECHA_ALTA]
    ,[USUARIO_ALTA]
    ,[FECHA_UPDATE]
    ,[USUARIO_UPDATE]
)

SELECT 
     IDS.[COD_SUCURSAL]
    ,IDS.[DESC_SUCURSAL]
    ,CASE WHEN FECHA_ALTA IS NULL THEN @fecha
    END
    ,CASE WHEN USUARIO_ALTA IS NULL THEN @usu
    END
    ,@fecha
    ,@usu

FROM [DW_COMERCIAL].[dbo].INT_DIM_SUCURSAL AS IDS
LEFT JOIN [DW_COMERCIAL].[dbo].DIM_SUCURSAL AS DS
ON IDS.COD_SUCURSAL = DS.COD_SUCURSAL
WHERE IDS.FLAG = 'S'
AND DS.COD_SUCURSAL IS NULL

END