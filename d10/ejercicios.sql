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

