-- Proyecto: Sistema de Gestión de Tienda en Línea
-- Incluye creación de tablas, inserción de datos, consultas avanzadas y mantenimiento.

-- ===================================
-- CREACIÓN DE TABLAS
-- ===================================

-- Tabla de clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Correo VARCHAR(50) UNIQUE NOT NULL,
    Telefono VARCHAR(15),
    Direccion VARCHAR(100)
);

-- Tabla de productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    Categoria VARCHAR(50)
);

-- Tabla de pedidos
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT NOT NULL,
    Fecha DATE NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    Estado VARCHAR(20) DEFAULT 'Pendiente',
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabla de detalles de pedidos
CREATE TABLE DetallesPedido (
    DetalleID INT PRIMARY KEY AUTO_INCREMENT,
    PedidoID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- ===================================
-- INSERCIÓN DE REGISTROS
-- ===================================

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (Nombre, Correo, Telefono, Direccion) VALUES
('Juan Pérez', 'juanperez@gmail.com', '555123456', 'Calle Principal 123'),
('Ana López', 'analopez@hotmail.com', '555654321', 'Av. Secundaria 45'),
('Carlos Gómez', 'carlosgomez@yahoo.com', '555987654', 'Plaza Central 78'),
('María Fernández', 'mariaf@gmail.com', '555456789', 'Camino Real 12');

-- Insertar datos en la tabla Productos
INSERT INTO Productos (Nombre, Precio, Stock, Categoria) VALUES
('Laptop', 1500.00, 10, 'Electrónica'),
('Smartphone', 800.00, 20, 'Electrónica'),
('Auriculares', 50.00, 50, 'Accesorios'),
('Teclado', 25.00, 30, 'Accesorios'),
('Mouse', 15.00, 40, 'Accesorios'),
('Monitor', 200.00, 15, 'Electrónica');

-- Insertar datos en la tabla Pedidos
INSERT INTO Pedidos (ClienteID, Fecha, Total, Estado) VALUES
(1, '2025-01-10', 1650.00, 'Completado'),
(2, '2025-01-11', 850.00, 'Pendiente'),
(3, '2025-01-12', 215.00, 'Completado');

-- Insertar datos en la tabla DetallesPedido
INSERT INTO DetallesPedido (PedidoID, ProductoID, Cantidad, Subtotal) VALUES
(1, 1, 1, 1500.00), -- Laptop
(1, 3, 3, 150.00),  -- Auriculares
(2, 2, 1, 800.00), -- Smartphone
(2, 4, 2, 50.00),  -- Teclado
(3, 4, 5, 125.00), -- Teclado
(3, 5, 6, 90.00);  -- Mouse

-- ===================================
-- CONSULTAS ÚTILES
-- ===================================

-- 1. Consultar todos los clientes registrados
SELECT * FROM Clientes;

-- 2. Ver todos los productos disponibles con su stock y categoría
SELECT * FROM Productos WHERE Stock > 0;

-- 3. Listar pedidos con el nombre del cliente y su estado
SELECT 
    Pedidos.PedidoID,
    Clientes.Nombre AS Cliente,
    Pedidos.Fecha,
    Pedidos.Total,
    Pedidos.Estado
FROM Pedidos
INNER JOIN Clientes ON Pedidos.ClienteID = Clientes.ClienteID;

-- 4. Ver detalles de un pedido específico
SELECT 
    DetallesPedido.PedidoID,
    Productos.Nombre AS Producto,
    DetallesPedido.Cantidad,
    DetallesPedido.Subtotal
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.ProductoID = Productos.ProductoID
WHERE DetallesPedido.PedidoID = 1;

-- 5. Calcular el total de ventas realizadas
SELECT SUM(Total) AS TotalVentas FROM Pedidos WHERE Estado = 'Completado';

-- 6. Ver productos con menos de 10 unidades en stock
SELECT Nombre, Stock FROM Productos WHERE Stock < 10;

-- 7. Buscar clientes que han realizado más de un pedido
SELECT 
    Clientes.Nombre AS Cliente, 
    COUNT(Pedidos.PedidoID) AS CantidadPedidos
FROM Pedidos
INNER JOIN Clientes ON Pedidos.ClienteID = Clientes.ClienteID
GROUP BY Clientes.ClienteID, Clientes.Nombre
HAVING COUNT(Pedidos.PedidoID) > 1;

-- ===================================
-- MANTENIMIENTO Y ACTUALIZACIONES
-- ===================================

-- Actualizar el stock de un producto después de un pedido
UPDATE Productos
SET Stock = Stock - 1
WHERE ProductoID = 1; -- Ejemplo: Reduce el stock de la Laptop

-- Cambiar el estado de un pedido a "Enviado"
UPDATE Pedidos
SET Estado = 'Enviado'
WHERE PedidoID = 2;

-- Eliminar un pedido y sus detalles relacionados
DELETE FROM DetallesPedido WHERE PedidoID = 3;
DELETE FROM Pedidos WHERE PedidoID = 3;

-- ===================================
-- CONSULTAS AVANZADAS
-- ===================================

-- 1. Productos más vendidos (Top 3)
SELECT 
    Productos.Nombre,
    SUM(DetallesPedido.Cantidad) AS TotalVendido
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.ProductoID = Productos.ProductoID
GROUP BY Productos.Nombre
ORDER BY TotalVendido DESC
LIMIT 3;

-- 2. Clientes con mayor gasto total
SELECT 
    Clientes.Nombre,
    SUM(Pedidos.Total) AS GastoTotal
FROM Pedidos
INNER JOIN Clientes ON Pedidos.ClienteID = Clientes.ClienteID
GROUP BY Clientes.Nombre
ORDER BY GastoTotal DESC;

-- 3. Ingresos diarios
SELECT 
    Fecha,
    SUM(Total) AS IngresosDiarios
FROM Pedidos
GROUP BY Fecha
ORDER BY Fecha;
