CREATE DATABASE TestDB
GO

USE TestDB
GO

CREATE TABLE Distrito(
    DistritoID CHAR(2) NOT NULL,
    NombreDistrito VARCHAR(32) NOT NULL,
    CONSTRAINT PK_Distrito_DistritoID PRIMARY KEY CLUSTERED (DistritoID)
)

CREATE TABLE Proveedor(
    ProveedorID INT NOT NULL,
    Nombre VARCHAR(30) NOT NULL,
    Direccion VARCHAR(30) NOT NULL,
    Ciudad VARCHAR(30) NOT NULL,
    DistritoID CHAR(2) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    CONSTRAINT PK_Distrito_ProveedorID PRIMARY KEY CLUSTERED (ProveedorID),
    CONSTRAINT FK_Distrito_Proveedor FOREIGN KEY (DistritoID) REFERENCES Distrito(DistritoID) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE PartesInventario(
    CodigoBarras INT NOT NULL,
    Nombre VARCHAR(40) NOT NULL,
    ProveedorID INT NOT NULL,
    Descripcion VARCHAR(80) NOT NULL,
    Costo DECIMAL(8,2) NOT NULL,
    Precio DECIMAL(8,2) NOT NULL,
    Cantidad INT NOT NULL,
    CONSTRAINT PK_PartesInventario_CodigoBarras PRIMARY KEY CLUSTERED (CodigoBarras),
    CONSTRAINT FK_Proveedor_PartesInventario FOREIGN KEY (ProveedorID) REFERENCES Proveedor(ProveedorID) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE TipoCuenta(
    CuentaID CHAR(2) NOT NULL,
    TipoCuenta VARCHAR(20) NOT NULL,
    CONSTRAINT PK_TipoCuenta_CuentaID PRIMARY KEY CLUSTERED (CuentaID)
)

CREATE TABLE Cliente(
    ClienteID INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(30) NOT NULL,
    DistritoID CHAR(2) NOT NULL,
    Telefono VARCHAR(12) NOT NULL,
    CuentaID CHAR(2) NOT NULL,
    CONSTRAINT PK_Cliente_ClienteID PRIMARY KEY CLUSTERED (ClienteID),
    CONSTRAINT FK_Distrito_Cliente FOREIGN KEY (DistritoID) REFERENCES Distrito(DistritoID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_TipoCuenta_Cliente FOREIGN KEY (CuentaID) REFERENCES TipoCuenta(CuentaID) ON DELETE CASCADE ON UPDATE CASCADE,
)


CREATE TABLE CodigoTransaccion(
    TransaccionID CHAR(2) NOT NULL,
    Descripcion VARCHAR(30) NOT NULL,
    CONSTRAINT PK_CodigoTransaccion_TransaccionID PRIMARY KEY CLUSTERED (TransaccionID)
)

CREATE TABLE CuentaCliente(
    ClienteID INT NOT NULL,
    UltimaCompra DATE,
    UltimaPago DATE,
    TransaccionID CHAR(2),
    EstadoCuenta DECIMAL(8,2),
    CONSTRAINT PK_CuentaCliente_ClienteID PRIMARY KEY CLUSTERED (ClienteID),
    CONSTRAINT FK_Cliente_CuentaCliente FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_CodigoTransaccion_CuentaCliente FOREIGN KEY (TransaccionID) REFERENCES CodigoTransaccion(TransaccionID) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE HistorialCuentaCliente(
    ClienteID INT NOT NULL,
    FechaTransaccion DATE NOT NULL,
    TransaccionID CHAR(2) NOT NULL,
    AntiguoEstadoCuenta DECIMAL(8,2) NOT NULL,
    NuevoEstadoCuenta DECIMAL(8,2) NOT NULL,
    CONSTRAINT PK_HistorialCuentaCliente_ClienteID PRIMARY KEY CLUSTERED (ClienteID),
    CONSTRAINT FK_Cliente_HistorialCuentaCliente FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_CodigoTransaccion_HistorialCuentaCliente FOREIGN KEY (TransaccionID) REFERENCES CodigoTransaccion(TransaccionID) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Bicicleta(
    ModeloID VARCHAR(20) NOT NULL,
    NombreModelo VARCHAR(40),
    PrecioInventario DECIMAL(8,2),
    PrecioVenta DECIMAL(8,2),
    Descripcion VARCHAR(100),
    CONSTRAINT FK_Bicleta_ModeloID PRIMARY KEY CLUSTERED (ModeloID)
)

CREATE TABLE OrdenCompra(
    PedidoID INT NOT NULL,
    FechaCompra DATE NOT NULL,
    ClienteID INT NOT NULL,
    CodigoBarras INT NOT NULL,
    NumeroSerial INT NOT NULL,
    ModeloID VARCHAR(20) NOT NULL,
    Cantidad INT NOT NULL,
    Precio INT NOT NULL,
    CONSTRAINT PK_OrdenCompra_PedidoID PRIMARY KEY CLUSTERED (PedidoID),
    CONSTRAINT FK_Cliente_OrdenCompra FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_PartesInventario_OrdenCompra FOREIGN KEY (CodigoBarras) REFERENCES PartesInventario(CodigoBarras) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Bicicleta_OrdenCompra FOREIGN KEY (ModeloID) REFERENCES Bicicleta(ModeloID) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE InventarioBicicletas(
    InventarioID INT NOT NULL,
    CodigoSerial VARCHAR(20) NOT NULL,
    ProveedorID INT NOT NULL,
    Fecha Date NOT NULL,
    ModeloID VARCHAR(20) NOT NULL,
    CONSTRAINT PK_InventarioBiciletas_InventarioID PRIMARY KEY CLUSTERED (InventarioID), 
    CONSTRAINT PK_Proveedor_InventarioBiciletas FOREIGN KEY (ProveedorID) REFERENCES Proveedor(ProveedorID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_Bicicleta_InventarioBiciletas FOREIGN KEY (ModeloID) REFERENCES Bicicleta(ModeloID)  ON DELETE CASCADE ON UPDATE CASCADE
)


-- Verificar las tablas creadas

SELECT *
FROM INFORMATION_SCHEMA.TABLES;
    

SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;