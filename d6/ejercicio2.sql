-- TABLA DEPARTAMENTOS 
-- ID, NOMBRE DEPARTAMENTO


-- TABLA EMPLEADOS
-- ID, RUN, NOMBRE, APELLIDO, EMAIL, FECHA_NACIMIENTO, REMUNERACION

-- AGREGAR 3 DEPARTAMENTOS

-- AGREGAR 5 EMPLEADOS, DEJANDO 1 DEPARTAMENTO SIN EMPLEADOS

-- ACTIVIDAD:
-- ASISTENCIA: 21:30
-- TERMINADA LA LISTA REVISAMOS LA CRREACIÓN DE TABLAS E INSERCIÓN DE REGISTROS.


create table departamentos(
	id serial primary key,
	nombre varchar(100) not null
);
 
create table empleados(
	id serial primary key,
	run varchar(12) not null unique,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	email varchar(100) not null unique,
	fecha_nacimiento date not null,
	departamento_id integer REFERENCES departamentos(id) ON DELETE SET NULL ON UPDATE CASCADE,
	remuneracion integer default(0) CHECK(remuneracion >= 0)
);
 
insert into departamentos (nombre) values
('administracion'),('contabilidad'),('operaciones'),('finanzas');
 
insert into empleados (run, nombre, apellido, email, fecha_nacimiento, departamento_id) 
values
('11.111.111-1','Juan','Perez','juan.perez@empresa.com','1985-09-15', 2),
('22.222.222-2','Rosa','Castillo','rosa.castillo@empresa.com','1986-07-12', 3),
('33.333.333-3','Pablo','Jerez','pablo.jerez@empresa.com','1985-09-15', 3),
('44.444.444-4','Maria','Perez','maria.perez@empresa.com','1985-09-15', 4);
 
select * from empleados;
select * from departamentos;


DELETE FROM departamentos WHERE id = 2;


DROP TABLE empleados, departamentos;


-- TODOS LOS EMPLEADOS QUE NO TIENEN UN DEPARTAMENTO ASIGNADO

select * from empleados WHERE departamento_id ISNULL;

SELECT * FROM departamentos d
LEFT JOIN empleados e
ON e.departamento_id = d.id
WHERE e.id ISNULL;

SELECT * FROM departamentos d
FULL OUTER JOIN empleados e
ON e.departamento_id = d.id;

SELECT * FROM departamentos d
RIGHT JOIN empleados e
ON e.departamento_id = d.id


SELECT id, nombre, fecha_nacimiento, AGE(fecha_nacimiento) FROM EMPLEADOS;

SELECT id, nombre, fecha_nacimiento, EXTRACT(YEAR FROM AGE(fecha_nacimiento)) ANIO,
EXTRACT(MONTH FROM AGE(fecha_nacimiento)) mes, 
EXTRACT(DAY FROM AGE(fecha_nacimiento)) dia
FROM EMPLEADOS;

 


SELECT id, nombre, concat(substring(nombre for 1)::TEXT,  substring(NOMBRE from 2)) FROM EMPLEADOS;



CREATE TABLE vehiculos(
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	marca VARCHAR(50) NOT NULL
);

SELECT * FROM VEHICULOS;

INSERT INTO VEHICULOS(marca) VALUES
('Toyota'), ('Nissan'), ('Chevrolet');
