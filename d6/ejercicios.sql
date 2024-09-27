SELECT * FROM actor;
SELECT * FROM customer;

SELECT * FROM rental;
SELECT * FROM staff;


SELECT * FROM actor_info;

SELECT * FROM language;


-- TIEMPO DE DURACIÓN DE LAS PELÍCULAS

SELECT rental_duration  FROM film
ORDER BY rental_duration DESC LIMIT 1;

SELECT MAX(rental_duration) FROM FILM;

SELECT film_id, title, rental_duration FROM film WHERE rental_duration = (SELECT MAX(rental_duration) FROM FILM);


-- FECHA DE RETORNO DE UNA PELÍCULA POR PARTE DEL CLIENTE

-- conocer las peliculas no devueltas
SELECT r.rental_id, r.rental_date, r.return_date, f.title, c.first_name, c.last_name FROM rental r
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON f.film_id = i.film_id
JOIN customer c
ON c.customer_id = r.customer_id
WHERE return_date ISNULL
ORDER BY c.first_name;



SELECT c.customer_id, c.first_name, c.last_name FROM rental r
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON f.film_id = i.film_id
JOIN customer c
ON c.customer_id = r.customer_id
WHERE return_date ISNULL
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.first_name

CREATE TABLE blacklist(
	customer_id INTEGER PRIMARY KEY,
	first_name VARCHAR(45),
	last_name VARCHAR(45)
);

-- CREAR LISTA NEGRA CON CLIENTES QUE NO HAN DEVUELTO LAS PELÍCULAS

INSERT INTO blacklist (customer_id, first_name, last_name)
SELECT c.customer_id, c.first_name, c.last_name FROM rental r
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON f.film_id = i.film_id
JOIN customer c
ON c.customer_id = r.customer_id
WHERE return_date ISNULL
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.first_name

-- UNIÓN DE TABLAS ENTRE BLACKLIST Y CUSTOMER
SELECT b.customer_id, b.first_name, b.last_name, c.email FROM blacklist b
JOIN customer c
ON b.customer_id = c.customer_id;


-- PELICULAS CON MEJOR RATING

select film_id, title, rental_rate from film
where rental_rate = (select max(rental_rate) from film);

-- PELICULAS MÁS ARRENDADAS

SELECT f.title, count(*) cantidad FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title
HAVING count(*) >=30
ORDER BY count(*) DESC;

SELECT f.title, count(*) cantidad FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title
HAVING count(*) >= (SELECT MAX(cantidad) FROM
(SELECT count(*) cantidad FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title) AS contar)
ORDER BY count(*) DESC;




-- CREAR VISTA PELICULA MÁS ARRENDADA

CREATE VIEW public.pelicula_mas_arrendada
 AS
SELECT f.title, count(*) cantidad FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title
HAVING count(*) >= (SELECT MAX(cantidad) FROM
(SELECT count(*) cantidad FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title) AS contar)
ORDER BY count(*) DESC;

SELECT * FROM pelicula_mas_arrendada;


-- filtrar arrendamientos efectuados en un mes

SELECT * FROM rental WHERE rental_date BETWEEN '2005-05-01' AND '2005-06-20';

SELECT rental_date FROM rental WHERE rental_date::TEXT LIKE '2005-08%'
ORDER BY rental_date;






