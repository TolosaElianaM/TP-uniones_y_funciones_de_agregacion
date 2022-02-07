-- Micro desafio 1 --

/* a) Utilizando la base de datos de películas queremos conocer, por un lado, los títulos y el
nombre del género de todas las series de la base de datos.  */

SELECT title
FROM series
INNER JOIN genres ON genres.id = series.genre_id

/* b) Por otro lado, necesitamos listar los títulos de los episodios junto con el nombre y apellido de 
los actores que trabajan en cada uno de ellos. */

SELECT e.title, first_name, last_name
FROM episodes AS e
INNER JOIN actor_episode AS ae ON ae.episode_id = e.id
INNER JOIN actors AS a ON a.id = ae.actor_id



-- Micro desafio 2 --

/* Para nuestro próximo desafío necesitamos obtener a todos los actores o actrices (mostrar
nombre y apellido) que han trabajado en cualquier película de la saga de la Guerra de las
galaxias, pero ¡cuidado!: debemos asegurarnos de que solo se muestre una sola vez cada
actor/actriz. */

SELECT DISTINCT first_name, last_name
FROM actors
INNER JOIN actor_movie AS am ON actors.id = am.actor_id
INNER JOIN movies AS m ON m.id = am.movie_id
WHERE m.title LIKE UPPER("%guerra%galaxias%")



-- Micro desafio 3 --

/* Debemos listar los títulos de cada película con su género correspondiente. En el caso de
que no tenga género, mostraremos una leyenda que diga "no tiene género". Como ayuda
podemos usar la función COALESCE() que retorna el primer valor no nulo de una lista. */

SELECT title, COALESCE(name, "No tiene género")
FROM movies
LEFT JOIN genres ON movies.genre_id = genres.id



-- Micro desafio 4 --

/* Necesitamos mostrar, de cada serie, la cantidad de días desde su estreno hasta su fin, con
la particularidad de que a la columna que mostrará dicha cantidad la renombraremos: “Duración”. */

SELECT title, DATEDIFF(end_date, release_date) 
FROM series



-- Micro desafio 5 --

/* a) Listar los actores ordenados alfabéticamente cuyo nombre sea mayor a 6 caracteres. */

SELECT * 
FROM actors
WHERE LENGTH(first_name) > 6
ORDER BY first_name

/* b) Debemos mostrar la cantidad total de los episodios guardados en la base de datos.*/

SELECT COUNT(*) AS "Cantidad de episodios guardados"
FROM episodes

/* c) Para el siguiente desafío nos piden que obtengamos el título de todas las series y el total de 
temporadas que tiene cada una de ellas. */

SELECT title, COUNT(seasons.id)
FROM series
INNER JOIN seasons ON seasons.serie_id = series.id
GROUP BY series.title

/* d) Mostrar, por cada género, la cantidad total de películas que posee, siempre que sea mayor
o igual a 3. */

SELECT name, COUNT(movies.id)
FROM genres
INNER JOIN movies ON genres.id = movies.genre_id
GROUP BY name
HAVING COUNT(movies.id) > 2