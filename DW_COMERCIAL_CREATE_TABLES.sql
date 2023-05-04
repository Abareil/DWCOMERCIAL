USE DW_COMERCIAL
/*********************************/
--------------INT-----------------
/*********************************/
CREATE TABLE INT_DIM_CATEGORIA (
    [DESC_CATEGORIA] [varchar](500) NOT NULL,
	[COD_CATEGORIA] [varchar](500) NOT NULL
)
-------------------
--------------------
CREATE TABLE INT_DIM_CLIENTE (
COD_CLIENTE Varchar(500) NOT NULL,
NOMBRE Varchar(500) NOT NULL,
APELLIDO Varchar(500) NOT NULL
)
-------------------
--------------------
CREATE TABLE INT_DIM_VENDEDOR(
    COD_VENDEDOR Varchar(500) NOT NULL, 
    NOMBRE Varchar(500) NOT NULL,
    APELLIDO Varchar(500) NOT NULL
)
-------------------
--------------------
CREATE TABLE INT_DIM_PAIS(
    COD_PAIS Varchar(3) NOT NULL,
    DESC_PAIS Varchar(500) NOT NULL
)

------------------
----------------
CREATE TABLE INT_DIM_PRODUCTO(
    COD_PRODUCTO Varchar(500) NOT NULL,
    DESC_PRODUCTO Varchar(500) NOT NULL
)

------------------
----------------
CREATE TABLE INT_DIM_SUCURSAL(
    COD_SUCURSAL Varchar(500) NOT NULL,
    DESC_SUCURSAL Varchar(500) NOT NULL
)
-----------------------
------------------------
CREATE TABLE INT_FACT_VENTAS(
    COD_PRODUCTO Varchar(100) NOT NULL,
    COD_CATEGORIA Varchar(100) NOT NULL,
    COD_CLIENTE Varchar(100)NOT NULL,
    COD_PAIS Varchar(100)NOT NULL,
    COD_VENDEDOR Varchar(100)NOT NULL,
    COD_SUCURSAL Varchar(100)NOT NULL,
    Fecha smalldatetime NOT NULL,
    CANTIDAD_VENDIDA decimal(18,2) NOT NULL,
    MONTO_VENDIDO decimal(18,2) NOT NULL,
    PRECIO decimal(18,2) NOT NULL,
    COMISION_COMERCIAL decimal(18,2) NOT NULL    
)

/*********************************/
--------------DIM-----------------
/*********************************/

CREATE TABLE DIM_CATEGORIA (
    CATEGORIA_KEY Integer PRIMARY KEY IDENTITY(1,1) NOT NULL, 
    COD_CATEGORIA Varchar(500),
    DESC_CATEGORIA Varchar(500),
    FECHA_ALTA Datetime,
    USUARIO_ALTA Varchar(500),
    FECHA_UPDATE Datetime,
    USUARIO_UPDATE Varchar(500)
)
-------------------
--------------------
CREATE TABLE DIM_CLIENTE (
    CLIENTE_KEY Integer PRIMARY KEY IDENTITY(1,1) NOT NULL, 
    COD_CLIENTE Varchar(500),
    NOMBRE Varchar(500),
    APELLIDO Varchar(500),
    FECHA_ALTA Datetime,
    USUARIO_ALTA Varchar(500),
    FECHA_UPDATE Datetime,
    USUARIO_UPDATE Varchar(500)
)
-------------------
--------------------
CREATE TABLE DIM_VENDEDOR(
    VENDEDOR_KEY Integer PRIMARY KEY IDENTITY(1,1) NOT NULL,
    COD_VENDEDOR VARCHAR(500),
    NOMBRE Varchar(500),
    APELLIDO Varchar(500),
    FECHA_ALTA Datetime,
    USUARIO_ALTA Varchar(500),
    FECHA_UPDATE Datetime,
    USUARIO_UPDATE Varchar(500)
)
-------------------
--------------------
CREATE TABLE DIM_PAIS(
    PAIS_KEY Integer PRIMARY KEY IDENTITY(1,1) NOT NULL,
    COD_PAIS Varchar(3),
    DESC_PAIS Varchar(500),
    FECHA_ALTA Datetime,
    USUARIO_ALTA Varchar(500),
    FECHA_UPDATE Datetime,
    USUARIO_UPDATE Varchar(500)
)

------------------
----------------
CREATE TABLE DIM_PRODUCTO(
    PRODUCTO_KEY Integer PRIMARY KEY IDENTITY(1,1) NOT NULL,
    COD_PRODUCTO Varchar(500),
    DESC_PRODUCTO Varchar(500),
    FECHA_ALTA Datetime,
    USUARIO_ALTA Varchar(500),
    FECHA_UPDATE Datetime,
    USUARIO_UPDATE Varchar(500)
)

------------------
----------------
CREATE TABLE DIM_SUCURSAL(
    SUCURSAL_KEY Integer PRIMARY KEY IDENTITY(1,1) NOT NULL,
    COD_SUCURSAL Varchar(500),
    DESC_SUCURSAL Varchar(500),
    FECHA_ALTA Datetime,
    USUARIO_ALTA Varchar(500),
    FECHA_UPDATE Datetime,
    USUARIO_UPDATE Varchar(500)
)
-----------------------
------------------------
CREATE TABLE FACT_VENTAS(
    PRODUCTO_KEY Integer,
    CATEGORIA_KEY Integer,
    CLIENTE_KEY Integer,
    PAIS_KEY Integer,
    VENDEDOR_KEY Integer,
    SUCURSAL_KEY Integer,
    TIEMPO_KEY smalldatetime,
    CANTIDAD_VENDIDA decimal(18,2),
    MONTO_VENDIDO decimal(18,2),
    PRECIO decimal(18,2),
    COMISION_COMERCIAL decimal(18,2),
    FECHA_ALTA Datetime,
    USUARIO_ALTA Varchar(500)   
)

CREATE TABLE DIM_TIEMPO(
    TIEMPO_KEY smalldatetime PRIMARY KEY NOT NULL,
    ANIO integer,
    MES_NRO integer,
    MES_NOMBRE varchar(15),
    SEMESTRE integer,
    TRIMESTRE integer,
    SEMANA_ANIO integer,
    SEMANA_NRO_MES integer,
    DIA integer,
    DIA_NOMBRE varchar(20),
    DIA_SEMANA_NRO integer,
    FECHA_ALTA Datetime,
    USUARIO_ALTA Varchar(500),
    FECHA_UPDATE Datetime,
    USUARIO_UPDATE Varchar(500)
)