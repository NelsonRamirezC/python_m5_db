CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL
);

CREATE TABLE cuentas(
	id SERIAL PRIMARY KEY,
	balance INTEGER NOT NULL DEFAULT 0 CHECK(balance >=0),
	id_cliente INTEGER NOT NULL REFERENCES clientes(id)
);

CREATE TABLE transacciones(
	id SERIAL PRIMARY KEY,
	cuenta_remitente INTEGER NOT NULL REFERENCES cuentas(id),
	id_remitente INTEGER NOT NULL REFERENCES clientes(id),
	cuenta_destinatario INTEGER NOT NULL REFERENCES cuentas(id),
	id_destinatario INTEGER NOT NULL REFERENCES clientes(id),
	glosa VARCHAR(255),
	monto INTEGER NOT NULL CHECK(monto > 0),
	tipo_transaccion VARCHAR(50)
);


SELECT * FROM clientes;
SELECT * FROM cuentas;
SELECT * FROM transacciones;

-- REGISTRAR CLIENTES
INSERT INTO clientes(nombre, apellido) VALUES
('Pedro', 'Osorio'), ('Carla', 'Madariaga');


INSERT INTO cuentas(balance, id_cliente) VAlUES
(100000, 1), (200000, 2);

-- JOIN DE TABLA CLIENTES CON SUS CUENTAS
SELECT cl.id cliente_, cl.nombre, cl.apellido, cu.id cuenta_id, cu.balance FROM clientes cl
JOIN cuentas cu
ON cl.id = cu.id_cliente;


-- PRIMERA TRANSACCIÓN SIN SAVEPOINT
-- CASO: CLIENTE 1 REMITE 20.000 A CLIENTE 2.
-- REMITENTE: ID 1
-- DESTINATARIO: ID 2
-- GLOSA: PAGO DE DEUDA
-- TIPO TRANSACCIÓN: TRANSFERENCIA A TERCEROS

BEGIN;
-- 1.- DESCONTAR DINERO AL REMITENTE
SELECT * FROM CUENTAS;
UPDATE cuentas SET balance = balance - 20000 WHERE ID = 1 RETURNING *;

-- 2.- SUMAR DINERO AL DESTINATARIO
UPDATE cuentas SET balance = balance + 20000 WHERE ID = 2 RETURNING *;

-- 3.- REGISTRAR LA TRANSACCIÓN
SELECT * FROM transacciones;
INSERT INTO transacciones(cuenta_remitente, id_remitente, cuenta_destinatario, id_destinatario, glosa, monto, tipo_transaccion)
VALUES
(1, 1, 2, 2, 'PAGO DE DEUDA', 20000, 'TRANSFERENCIA A TERCEROS') RETURNING *;

COMMIT;
ROLLBACK;



-- segundo caso
-- CASO: CLIENTE 2 REMITE 5.000 A CLIENTE 1.
-- REMITENTE: ID 2
-- DESTINATARIO: ID 1
-- GLOSA: DEVOLUCIÓN DINERO
-- TIPO TRANSACCIÓN: TRANSFERENCIA A TERCEROS

BEGIN;
-- 1.- DESCONTAR DINERO AL REMITENTE
SELECT * FROM CUENTAS;
UPDATE cuentas SET balance = balance - 5000 WHERE ID = 2 RETURNING *;

-- 2.- SUMAR DINERO AL DESTINATARIO
UPDATE cuentas SET balance = balance + 5000 WHERE ID = 1 RETURNING *;

-- 3.- REGISTRAR LA TRANSACCIÓN
SELECT * FROM transacciones;
INSERT INTO transacciones(cuenta_remitente, id_remitente, cuenta_destinatario, id_destinatario, glosa, monto, tipo_transaccion)
VALUES
(2, 2, 1, 1, 'DEVOLUCIÓN DINERO', 5000, 'TRANSFERENCIA A TERCEROS') RETURNING *;

COMMIT;
ROLLBACK;


-- CASO: CLIENTE 1 REMITE 100.000 A CLIENTE 2.
-- REMITENTE: ID 1
-- DESTINATARIO: ID 2
-- GLOSA: PAGO ARRIENDO
-- TIPO TRANSACCIÓN: TRANSFERENCIA A TERCEROS

BEGIN;
-- 1.- DESCONTAR DINERO AL REMITENTE
SELECT * FROM CUENTAS;
UPDATE cuentas SET balance = balance - 100000 WHERE ID = 1 RETURNING *;

-- 2.- SUMAR DINERO AL DESTINATARIO
UPDATE cuentas SET balance = balance + 100000 WHERE ID = 2 RETURNING *;

-- 3.- REGISTRAR LA TRANSACCIÓN
SELECT * FROM transacciones;
INSERT INTO transacciones(cuenta_remitente, id_remitente, cuenta_destinatario, id_destinatario, glosa, monto, tipo_transaccion)
VALUES
(1, 1, 2, 2, 'PAGO ARRIENDO', 100000, 'TRANSFERENCIA A TERCEROS') RETURNING *;

COMMIT;
ROLLBACK;


UPDATE cuentas SET balance = balance - 5000 WHERE ID = 1 RETURNING *;

ROLLBACK;



SELECT * FROM CLIENTES;
SELECT * FROM CUENTAS;
SELECT * FROM TRANSACCIONES;


-- CREAR UN GRUPO EJECUTIVOS -> TODOS LOS PERMISOS

CREATE GROUP ejecutivos;

CREATE USER ejecutivo1 WITH PASSWORD '123456' IN GROUP ejecutivos;
CREATE USER ejecutivo2 WITH PASSWORD '123456' IN GROUP ejecutivos;

-- CREAR UN GRUPO ADMINISTRATIVOS -> PERMISOS DE SÓLO LECTURA
CREATE GROUP administrativos;
CREATE USER administrador1 WITH PASSWORD '123456' IN GROUP administrativos;
CREATE USER administrador2 WITH PASSWORD '123456' IN GROUP administrativos;


GRANT SELECT, INSERT ON clientes TO ejecutivos;

GRANT USAGE, SELECT, UPDATE ON clientes_id_seq, cuentas_id_seq TO ejecutivos;


GRANT ALL PRIVILEGES ON DATABASE m5_s5_transacciones TO ejecutivos;

GRANT ALL ON clientes, cuentas, transacciones TO ejecutivos;


REVOKE ALL PRIVILEGES ON clientes, cuentas, transacciones FROM ejecutivos;



CREATE TABLE finanzas.clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL
);



SELECT * FROM clientes;

