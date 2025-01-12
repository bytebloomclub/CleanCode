-- Sistema de Gestión de Biblioteca
-- Incluye creación de tablas, inserción de datos, consultas avanzadas y mantenimiento.

-- ===================================
-- CREACIÓN DE TABLAS
-- ===================================

-- Tabla de autores
CREATE TABLE Autores (
    AutorID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Nacionalidad VARCHAR(50),
    FechaNacimiento DATE
);

-- Tabla de libros
CREATE TABLE Libros (
    LibroID INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(150) NOT NULL,
    Genero VARCHAR(50),
    Publicacion DATE,
    AutorID INT NOT NULL,
    Disponibles INT NOT NULL,
    FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
);

-- Tabla de usuarios
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL,
    FechaRegistro DATE DEFAULT CURRENT_DATE
);

-- Tabla de préstamos
CREATE TABLE Prestamos (
    PrestamoID INT PRIMARY KEY AUTO_INCREMENT,
    UsuarioID INT NOT NULL,
    LibroID INT NOT NULL,
    FechaPrestamo DATE DEFAULT CURRENT_DATE,
    FechaDevolucion DATE,
    Devuelto BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (LibroID) REFERENCES Libros(LibroID)
);

-- ===================================
-- INSERCIÓN DE REGISTROS
-- ===================================

-- Insertar datos en la tabla Autores
INSERT INTO Autores (Nombre, Nacionalidad, FechaNacimiento) VALUES
('Gabriel García Márquez', 'Colombiana', '1927-03-06'),
('J.K. Rowling', 'Británica', '1965-07-31'),
('George Orwell', 'Británica', '1903-06-25'),
('Isabel Allende', 'Chilena', '1942-08-02');

-- Insertar datos en la tabla Libros
INSERT INTO Libros (Titulo, Genero, Publicacion, AutorID, Disponibles) VALUES
('Cien Años de Soledad', 'Realismo Mágico', '1967-05-30', 1, 5),
('Harry Potter y la Piedra Filosofal', 'Fantasía', '1997-06-26', 2, 8),
('1984', 'Distopía', '1949-06-08', 3, 4),
('La Casa de los Espíritus', 'Realismo Mágico', '1982-09-15', 4, 3);

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (Nombre, Correo) VALUES
('Juan Pérez', 'juanperez@gmail.com'),
('Ana López', 'analopez@hotmail.com'),
('Carlos Gómez', 'carlosgomez@yahoo.com'),
('María Fernández', 'mariaf@gmail.com');

-- Insertar datos en la tabla Prestamos
INSERT INTO Prestamos (UsuarioID, LibroID, FechaDevolucion) VALUES
(1, 1, '2025-01-15'),
(2, 2, '2025-01-20'),
(3, 3, NULL),
(4, 4, '2025-01-25');

-- ===================================
-- CONSULTAS ÚTILES
-- ===================================

-- 1. Consultar todos los libros con su autor
SELECT 
    Libros.Titulo, 
    Libros.Genero, 
    Libros.Publicacion, 
    Autores.Nombre AS Autor
FROM Libros
INNER JOIN Autores ON Libros.AutorID = Autores.AutorID;

-- 2. Ver usuarios y los libros que han prestado
SELECT 
    Usuarios.Nombre AS Usuario, 
    Libros.Titulo AS Libro, 
    Prestamos.FechaPrestamo, 
    Prestamos.FechaDevolucion, 
    Prestamos.Devuelto
FROM Prestamos
INNER JOIN Usuarios ON Prestamos.UsuarioID = Usuarios.UsuarioID
INNER JOIN Libros ON Prestamos.LibroID = Libros.LibroID;

-- 3. Libros disponibles (stock mayor a 0)
SELECT Titulo, Disponibles FROM Libros WHERE Disponibles > 0;

-- 4. Autores con más de un libro registrado
SELECT 
    Autores.Nombre AS Autor, 
    COUNT(Libros.LibroID) AS CantidadLibros
FROM Libros
INNER JOIN Autores ON Libros.AutorID = Autores.AutorID
GROUP BY Autores.Nombre
HAVING COUNT(Libros.LibroID) > 1;

-- 5. Usuarios con préstamos activos
SELECT 
    Usuarios.Nombre AS Usuario, 
    COUNT(Prestamos.PrestamoID) AS PrestamosActivos
FROM Prestamos
INNER JOIN Usuarios ON Prestamos.UsuarioID = Usuarios.UsuarioID
WHERE Prestamos.Devuelto = FALSE
GROUP BY Usuarios.Nombre;

-- ===================================
-- MANTENIMIENTO Y ACTUALIZACIONES
-- ===================================

-- Registrar la devolución de un libro
UPDATE Prestamos
SET Devuelto = TRUE
WHERE PrestamoID = 3;

-- Reducir la cantidad de libros disponibles tras un préstamo
UPDATE Libros
SET Disponibles = Disponibles - 1
WHERE LibroID = 2;

-- Aumentar la cantidad de libros disponibles tras una devolución
UPDATE Libros
SET Disponibles = Disponibles + 1
WHERE LibroID = 2;

-- Eliminar un usuario y todos sus préstamos
DELETE FROM Prestamos WHERE UsuarioID = 4;
DELETE FROM Usuarios WHERE UsuarioID = 4;

-- ===================================
-- CONSULTAS AVANZADAS
-- ===================================

-- 1. Libros más prestados (Top 3)
SELECT 
    Libros.Titulo, 
    COUNT(Prestamos.PrestamoID) AS VecesPrestado
FROM Prestamos
INNER JOIN Libros ON Prestamos.LibroID = Libros.LibroID
GROUP BY Libros.Titulo
ORDER BY VecesPrestado DESC
LIMIT 3;

-- 2. Usuarios con mayor número de préstamos
SELECT 
    Usuarios.Nombre AS Usuario, 
    COUNT(Prestamos.PrestamoID) AS TotalPrestamos
FROM Prestamos
INNER JOIN Usuarios ON Prestamos.UsuarioID = Usuarios.UsuarioID
GROUP BY Usuarios.Nombre
ORDER BY TotalPrestamos DESC;

-- 3. Ingresos por fecha de devolución (simulando una tarifa por préstamo)
SELECT 
    FechaDevolucion, 
    COUNT(Prestamos.PrestamoID) * 10 AS Ingresos
FROM Prestamos
WHERE Devuelto = TRUE
GROUP BY FechaDevolucion;
