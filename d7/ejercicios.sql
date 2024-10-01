CREATE TABLE usuarios(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL
);

-- AGREGAR UN 3 REGISTROS
INSERT INTO usuarios VALUES
(DEFAULT, 'Marta', 'Pereira'),
(DEFAULT, 'Pedro', 'Navarro'),
(DEFAULT, 'Carla', 'García');


-- AGREGAR EL CAMPO EMAIL A LA TABLA USUARIOS
ALTER TABLE usuarios ADD COLUMN email VARCHAR(150) UNIQUE;

-- AGREGAR RESTRICCIÓN DE VALORES NULOS EN EL CAMPO EMAIL
UPDATE usuarios SET email = 'marta@gmail.com' WHERE id = 1;
UPDATE usuarios SET email = 'pedro@gmail.com' WHERE id = 2;
UPDATE usuarios SET email = 'carla@gmail.com' WHERE id = 3;

ALTER TABLE usuarios ALTER COLUMN email SET NOT NULL;


-- CAMBIAR CORREO DE Carla -> id: 3
UPDATE usuarios SET email = 'carla_garcia@gmail.com' WHERE id = 3 RETURNING *;

--
SELECT * FROM USUARIOS;

-- CAMBIAR DE NOMBRE A LA TABLA USUARIOS -> CLIENTES

ALTER TABLE usuarios RENAME TO clientes;
SELECT * FROM clientes;

-- CAMBIAR NOMBRE DE COLUMNA DE EMAIL A CORREO

ALTER TABLE clientes RENAME COLUMN email TO correo;

SELECT * FROM clientes;

-- AGREGAR UNA COLUMNA DE fecha_nacimiento
ALTER TABLE clientes DROP COLUMN fecha_nacimiento;

ALTER TABLE clientes ADD fecha_nacimiento VARCHAR(50);

UPDATE clientes SET fecha_nacimiento = '01_01_2000' WHERE id = 1;
UPDATE clientes SET fecha_nacimiento = '01_01_2000' WHERE id = 2;
UPDATE clientes SET fecha_nacimiento = '01_01_2000' WHERE id = 3;

-- CAMBIAR TIPO DE DATO FECHA_NACIMIENTO DE VARCHAR A DATE

UPDATE clientes SET fecha_nacimiento = '2000-01-01' WHERE id = 1;
UPDATE clientes SET fecha_nacimiento = '2000-01-01' WHERE id = 2;
UPDATE clientes SET fecha_nacimiento = '2000-01-01' WHERE id = 3;


alter table clientes alter fecha_nacimiento type date using(fecha_nacimiento::date);

SELECT * FROM CLIENTES;

SELECT *, EXTRACT(YEAR FROM AGE(fecha_nacimiento)) edad FROM CLIENTES;


-- FILTRAR CLIENTES NACIDOS EL AÑO 2000

SELECT * FROM CLIENTES WHERE fecha_nacimiento BETWEEN '2000-01-01' AND '2000-12-31';

SELECT * FROM CLIENTES WHERE fecha_nacimiento::TEXT LIKE '2000%';

-- AGREGAR UN CAMPO LLAMADO ESTADO

ALTER TABLE CLIENTES ADD COLUMN estado BOOLEAN NOT NULL DEFAULT TRUE;

SELECT * FROM CLIENTES;


-- ELIMINAR LA COLUMNA ESTADO

ALTER TABLE CLIENTES DROP estado;

ALTER TABLE CLIENTES DROP FECHA_NACIMIENTO, DROP ESTADO; 


SELECT * FROM CLIENTES;

TRUNCATE TABLE clientes; -- ELIMINA TODOS LOS REGISTROS



-- volver A REGISTRAR CLIENTES

SELECT * FROM CLIENTES;

INSERT INTO clientes VALUES
(DEFAULT, 'Marta', 'Pereira', 'marta@outlook.com'),
(DEFAULT, 'Pedro', 'Navarro', 'pedro@hotmail.com'),
(DEFAULT, 'Carla', 'García', 'carla@gmail.com');

CREATE TABLE sucursal(
	id SMALLSERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO sucursal(nombre) VALUES
('Apoquindo'), ('Santiago Centro');

ALTER TABLE sucursal RENAME TO sucursales;


SELECT * FROM CLIENTES;
SELECT * FROM SUCURSALES;

-- VINCULAR LOS CLIENTES A UNA SUCURSAL

ALTER TABLE clientes ADD COLUMN id_sucursal SMALLINT NOT NULL DEFAULT 2 REFERENCES sucursales(id);

-- CLIENTE MARTA Y CARLA PASARAN A LA SUCURSAL APOQUINTO
UPDATE clientes SET id_sucursal = 1 WHERE id IN(5, 7);

UPDATE clientes SET id_sucursal = 1 WHERE id = 5 or id = 7;


-- AGRUPACIÓN + UNIÓN DE TABLAS

SELECT S.ID id_sucursal, S.NOMBRE sucursal, C.id id_cliente, 
C.nombre nombre_cliente, C.apellido, C.correo correo_cliente FROM SUCURSALES S
JOIN CLIENTES C
ON S.ID = C.ID_SUCURSAL;


SELECT S.ID, S.nombre SUCURSAL, COUNT(*) cantidad_clientes FROM SUCURSALES S
JOIN CLIENTES C
ON S.ID = C.ID_SUCURSAL
GROUP BY S.ID, S.nombre
ORDER BY COUNT(*) DESC;


SELECT id_sucursal, COUNT(*) cantidad FROM CLIENTES
GROUP BY id_sucursal


-- CREACIÓN / MODIFICACIÓN Y ELIMINACIÓN DE USUARIOS
CREATE USER usuario1;
ALTER USER usuario1 WITH PASSWORD '123456';


ALTER USER usuario1 WITH SUPERUSER;

ALTER USER usuario1 WITH NOSUPERUSER;

ALTER USER usuario1 WITH CREATEDB;


DROP DATABASE db_usuario1;
DROP USER usuario1;

CREATE USER usuario1 WITH PASSWORD '123456' SUPERUSER;


CREATE USER usuario1 WITH PASSWORD '123456' VALID UNTIL '2024-10-05';

ALTER USER usuario1 WITH VALID UNTIL '2024-11-05';

-- COMPLEMENTARLO CON LOS PERMISOS GRANT - REVOKE