CREATE TABLE categorias(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100)
);

CREATE TABLE productos(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100),
	precio INTEGER NOT NULL,
	stock INTEGER NOT NULL,
	id_categoria INTEGER REFERENCES categorias(id) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE categorias, productos;


insert into categorias(nombre) values
('alimentos'),
('aseo'),
('confites'),
('libreria'),
('ferreteria');

insert into productos values
(default ,'Fideos #5',100,100,1),
(default ,'Detergente OMO',6000,100,2),
(default ,'Chocolate Trencito',1200,100,3),
(default ,'Resma papel A4',5500,100,4),
(default ,'Martillo 3',21000,100,5);

SELECT * FROM PRODUCTOS;
SELECT * FROM CATEGORIAS;

-- INNER JOIN / JOIN
SELECT p.id, p.nombre nombre, p.precio, p.stock, p.id_categoria, c.nombre categoria FROM PRODUCTOS p
JOIN CATEGORIAS c
ON P.id_categoria = c.id;

CREATE VIEW productos_con_cagtegoria AS
SELECT p.id, p.nombre nombre, p.precio, p.stock, p.id_categoria, c.nombre categoria FROM PRODUCTOS p
JOIN CATEGORIAS c
ON P.id_categoria = c.id;


SELECT * FROM PRODUCTOS;
insert into productos values
(default ,'Chocolate Capri Naranja',1000,50,NULL);


-- LEFT JOIN
SELECT * FROM PRODUCTOS p
LEFT JOIN CATEGORIAS c
ON P.id_categoria = c.id;

--MOSTRAR TODOS LOS PRODUCTOS SIN CATEGORIA

SELECT * FROM PRODUCTOS p
LEFT JOIN CATEGORIAS c
ON P.id_categoria = c.id
WHERE c.id ISNULL;

SELECT * FROM PRODUCTOS WHERE id_categoria ISNULL;



-- INGRESAR CATEGORIA NUEVA
insert into categorias(nombre) values
('Chocolates');

SELECT * FROM PRODUCTOS p
RIGHT JOIN CATEGORIAS c
ON P.id_categoria = c.id


SELECT C.id, c.nombre FROM CATEGORIAS c
LEFT JOIN PRODUCTOS p
ON P.id_categoria = c.id
WHERE p.id IS NOT NULL;


SELECT * FROM CATEGORIAS c
FULL OUTER JOIN PRODUCTOS p
ON P.id_categoria = c.id
WHERE c.id ISNULL OR P.ID ISNULL;

UPDATE PRODUCTOS SET id_categoria = 6 WHERE id = 6;




SELECT * FROM CATEGORIAS c
JOIN PRODUCTOS p
ON P.id_categoria = c.id
ORDER BY c.nombre ASC;

INSERT INTO productos VALUES (DEFAULT, 'Papas fritas lays', 850, 10, 3);


-- LISTAR CATEGORÍA QUE TIENE EL PRODUCTO MÁS CARO

SELECT c.id, c.nombre FROM CATEGORIAS c
JOIN PRODUCTOS p
ON P.id_categoria = c.id
ORDER BY p.precio DESC
LIMIT 1;

SELECT id_categoria FROM PRODUCTOS WHERE precio = (SELECT MAX(precio) FROM PRODUCTOS);

SELECT * FROM categorias WHERE ID =
(SELECT id_categoria FROM PRODUCTOS WHERE precio = (SELECT MAX(precio) FROM PRODUCTOS));


INSERT INTO productos VALUES (DEFAULT, 'Chocolate CARO', 21000, 2, 6);


SELECT * FROM CATEGORIAS c
JOIN PRODUCTOS p
ON P.id_categoria = c.id
WHERE p.precio = (SELECT MAX(precio) FROM PRODUCTOS);

SELECT * FROM PRODUCTOS
ORDER BY PRECIO;


SELECT * FROM categorias WHERE ID 
IN((SELECT id_categoria FROM PRODUCTOS WHERE precio = (SELECT MAX(precio) FROM PRODUCTOS)));

/*

SELECT COLUMNA1, COLUMNA2 -> SELECCIÓN DE COLUMNAS
FROM CATEGORIAS   -> DE DÓNDE SACAMOS LOS DATOS
[JOIN PRODUCTOS] -> DE FORMA ALTERNATIVA PODEMOS UNIR DIFERENTES TABLAS
WHERE PRECIO > 500 -> FILTRO REGISTRO A REGISTRO 
[GROUP BY COLUMNA1, COLUMNA2] -> AGRUPAR POR COLUMNAS
[HAVING ] -> LO MISMO QUE EL WHERE PERO CON GRUPOS
[ORDER BY ] -> ORDENAR POR ALGUNA COLUMNA
*/


SELECT id_categoria, id, nombre, precio, stock FROM PRODUCTOS
WHERE precio > 1500
ORDER BY precio DESC;



SELECT c.nombre, count(*), sum(stock), min(stock), max(stock) FROM CATEGORIAS c
JOIN PRODUCTOS p
ON P.id_categoria = c.id
GROUP BY c.nombre
ORDER BY c.nombre;


SELECT * FROM PRODUCTOS WHERE STOCK = (SELECT MIN(STOCK) FROM PRODUCTOS);


SELECT c.nombre, count(*) FROM CATEGORIAS c
JOIN PRODUCTOS p
ON P.id_categoria = c.id
GROUP BY c.nombre
HAVING count(*) >=2
ORDER BY c.nombre;

SELECT c.nombre, count(*) FROM CATEGORIAS c
JOIN PRODUCTOS p
ON P.id_categoria = c.id
WHERE c.id NOT IN(1,2)
GROUP BY c.nombre;

SELECT c.nombre, count(*) FROM CATEGORIAS c
JOIN PRODUCTOS p
ON P.id_categoria = c.id
GROUP BY c.nombre
HAVING C.NOMBRE NOT IN('alimentos', 'aseo');





CREATE TABLE clientes1(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50),
	email VARCHAR(125)
);

CREATE TABLE clientes2(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50),
	email VARCHAR(125)
);

CREATE TABLE empleados(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50),
	email VARCHAR(125)
);

INSERT INTO clientes1 VALUES 
(DEFAULT, 'Pedro Soto', 'pedro.soto@gmail.com'),
(DEFAULT, 'Marta Godoy', 'marta.godoy@gmail.com');

INSERT INTO clientes2 VALUES 
(DEFAULT, 'Carolina Meza', 'carolina_meza@gmail.com'),
(DEFAULT, 'Pedro Soto', 'pedro.soto@gmail.com');
 
INSERT INTO empleados VALUES 
(DEFAULT, 'Marta Godoy', 'marta.godoy@gmail.com'),
(DEFAULT, 'Carolina Meza', 'carolina_meza@gmail.com');

SELECT nombre, count(*) FROM
(SELECT nombre FROM clientes1
UNION ALL
SELECT nombre FROM clientes2) clientes_temp
GROUP BY nombre
HAVING count(*) = 1;
 
 

SELECT nombre, email FROM clientes1
UNION
SELECT nombre, email FROM clientes2



CREATE TABLE customers(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50),
	email VARCHAR(125)
);

INSERT INTO customers(nombre, email)
SELECT nombre, email FROM
(SELECT nombre, email FROM clientes1
UNION
SELECT nombre, email FROM clientes2) as clientes_temporales;


SELECT * FROM CUSTOMERS;

/*
INSERT INTO clientes1 VALUES 
(DEFAULT, 'Pedro Soto', 'pedro.soto@gmail.com'),
(DEFAULT, 'Marta Godoy', 'marta.godoy@gmail.com');

INSERT INTO clientes2 VALUES 
(DEFAULT, 'Carolina Meza', 'carolina_meza@gmail.com'),
(DEFAULT, 'Pedro Soto', 'pedro.soto@gmail.com');
*/


SELECT nombre, email FROM clientes1
INTERSECT
SELECT nombre, email FROM clientes2



SELECT nombre, email FROM clientes1
EXCEPT
SELECT nombre, email FROM clientes2


SELECT nombre, email FROM clientes2
EXCEPT
SELECT nombre, email FROM empleados
