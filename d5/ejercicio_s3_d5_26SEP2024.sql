CREATE TABLE contabilidad.clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL
 );


CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL
 );


SELECT * FROM clientes;

DROP TABLE contabilidad.clientes;


CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	estado BOOLEAN NOT NULL DEFAULT FALSE,
	salario INTEGER NOT NULL DEFAULT 0,
	direccion VARCHAR(100) NOT NULL DEFAULT 'SIN DIRECCIÓN',
);


CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL
 );
 
 DROP TABLE  clientes;
 
 INSERT INTO clientes (apellido, nombre) VALUES
 ('Soto', 'Carlos');
 
 INSERT INTO clientes  VALUES
 (DEFAULT, 'Pedro', 'Pereira') RETURNING *;
 
 SELECT * FROM clientes;
 
 
 CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	password VARCHAR(500) NOT NULL
 );


DROP TABLE CLIENTES;
 
 INSERT INTO clientes VALUES
 (DEFAULT, 'Carlos', 'Soto', '123456');
 
 SELECT id, nombre, apellido FROM clientes;
 
 
 CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	password VARCHAR(500) NOT NULL,
	email VARCHAR(150) CONSTRAINT email_unique_clientes UNIQUE
 );
 
 DROP TABLE clientes;
 
 
 CREATE TABLE productos(
 	 id SERIAL PRIMARY KEY,
	 nombre VARCHAR(100) NOT NULL,
	 precio INTEGER NOT NULL CHECK(precio > 0) DEFAULT 99999999,
	 stock INTEGER NOT NULL DEFAULT 0 CHECK(stock >=0),
	 id_categoria INTEGER REFERENCES categorias(id)
 );
 
 CREATE TABLE categorias(
 	 id SERIAL PRIMARY KEY,
	 nombre VARCHAR(100) NOT NULL UNIQUE
 );

INSERT INTO productos VALUES
(DEFAULT, 'Chocolate Capri Frutilla', 1000, 100, NULL);

INSERT INTO productos VALUES
(DEFAULT, 'Chocolate Capri Naranja', 1000, 100, NULL),
(DEFAULT, 'Chocolate Capri Menta', 1000, 100, NULL);

SELECT * FROM productos;

-- CREANDO CATEGORIAS

INSERT INTO categorias (nombre) VALUES
('Chocolates'),
('Galletas'),
('Abarrotes'),
('Art. de aseo');

SELECT * FROM categorias;

-- ASIGNAR A LOS CHOCOLATES LA CATEGORÍA DE CHOCOLATES.

UPDATE productos SET id_categoria = 1 WHERE id IN(1,2,3);

SELECT * FROM productos;

UPDATE productos SET id_categoria = 1 WHERE nombre ILIKE '%menta%';

-- agregar productos de aseo

INSERT INTO productos (nombre, precio, stock, id_categoria) VALUES
('Cloro 1 litro Clorinda', 1500, 25, 4),
('Cloro 3 litros Clorinda', 2500, 10, 4),
('Cloro 5 litros Acuenta', 3500, 5, 4);

SELECT *, (precio * stock) total FROM productos;

-- TRAE TODOS LOS PRODUCTOS CON STOCK MENOR O IGUAL A 50 UNIDADES
SELECT * FROM productos WHERE stock <= 50;

-- TRAE TODOS LOS PRODUCTOS CON STOCK MAYOR A 50 UNIDADES
SELECT * FROM productos WHERE stock > 50;

-- TRAE TODOS LOS PRODUCTOS QUE TENGAN UN STOCK ENTRE 10 Y 40 UNIDADES
SELECT * FROM productos WHERE stock >= 10 AND stock <= 40;
SELECT * FROM productos WHERE stock BETWEEN 10 AND 40;

--MOSTRAR SÓLO LOS PRODUCTOS QUE TENGAN UN PRECIO DE 1000 Y 1500
SELECT * FROM productos WHERE precio IN(1000, 1500);
SELECT * FROM productos WHERE precio = 1000 OR precio = 1500;

-- MOSTRAR TODOS LOS PRODUCTOS QUE NO SEA CHOCOLATES

SELECT * FROM productos WHERE nombre  NOT ILIKE '%chocolate%';

-- MOSTRAR TODOS LOS PRODUCTOS QUE SEAN CHOCOLATES

SELECT * FROM productos WHERE nombre  ILIKE '%chocolate%';

-- AGREGAMOS UN PRODUCTO SI CATEGORÍA
INSERT INTO productos(nombre, precio, stock) VALUES
('Mesa redonda madera nativa', 350000, 1);

-- MOSTRAR LOS PRODUCTOS SIN CATEGORÍA 
SELECT * FROM productos WHERE id_categoria ISNULL;

-- CREAR CATEGORÍA PARA PRODUCTOS SIN CATEGORÍA DEFINIDA
SELECT * FROM categorias;
INSERT INTO categorias(nombre) VALUES('Sin categiría');

-- ACTUALIZAMOS TODOS LOS REGISTROS CON CATEGORÍA NULA A LA CATEGORÍA "SIN CATEGORÍA -> 5"

UPDATE productos SET id_categoria = 5 WHERE id_categoria ISNULL RETURNING *;

-- ORDERNAR LOS PRODUCTOS POR EL STOCK
SELECT * FROM PRODUCTOS
ORDER BY id ASC;


SELECT * FROM productos ORDER BY id;

UPDATE productos SET stock = 90 WHERE ID = 1;


INSERT INTO productos (nombre, precio, stock) VALUES
('Paño de cocina mediano 20x20', 1000, 15),
('Paño de cocina grande 40x40', 1800, 15);

SELECT * FROM PRODUCTOS;
 
SELECT * FROM CATEGORIAS;


-- CONOCER LOS PRODUCTOS

SELECT p.id, p.nombre, p.precio, p.stock, p.id_categoria, c.nombre FROM PRODUCTOS P
JOIN CATEGORIAS C
ON P.id_categoria = c.id;


-- CATEGORIAS QUE NO TENGAN PRODUCTOS ASOCIADOS

SELECT C.id, C. nombre FROM CATEGORIAS C
LEFT JOIN PRODUCTOS P
ON P.id_categoria = c.id
WHERE P.id ISNULL;

-- PRODUCTOS QUE NO ESTÁN ASIGNADOS A NINGUNA CATEGORÍA

SELECT * FROM PRODUCTOS P
LEFT JOIN CATEGORIAS C
ON P.id_categoria = c.id
WHERE C.id ISNULL;


SELECT MAX(precio) FROM PRODUCTOS; -- precio más caro en productos
SELECT MIN(precio) FROM PRODUCTOS; -- precio más BAjo en productos
SELECT AVG(precio) FROM PRODUCTOS; -- precio promedio


SELECT SUM((PRECIO * STOCK)) AS TOTAL FROM PRODUCTOS;
