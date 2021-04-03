--Creando Base de datos
CREATE DATABASE peliculas;
--Creando tabla peliculas
CREATE TABLE peliculas(id INT, peliculas VARCHAR(100), año_estreno INT,director VARCHAR(100));
--agregando primary key
ALTER TABLE peliculas ADD PRIMARY KEY (id); 
--agregando clave foranea
ALTER TABLE reparto ADD FOREIGN KEY (id) REFERENCES peliculas(id);
--Copiando tabla desde archivo csv
\copy peliculas FROM '/Users/eruiz/Desktop/peliculas.csv' csv header;
--Creando TABLA reparto
CREATE TABLE reparto (id INT, actores VARCHAR(100));
--Copiando tabla desde archivo csv reparto
\copy reparto FROM '/Users/eruiz/Desktop/reparto.csv' csv;
--Pregunta 4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto. 
SELECT peliculas, año_estreno,director, reparto.actores FROM peliculas INNER JOIN reparto ON peliculas.id = reparto.id WHERE peliculas.peliculas = 'Titanic';
--Pregunta 5. Listar los titulos de las películas donde actúe Harrison Ford.
SELECT actores AS nombres,peliculas AS resultado FROM peliculas INNER JOIN reparto ON peliculas.id = reparto.id WHERE  reparto.actores= 'Harrison Ford';
--Pregunta 6 Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.
SELECT director, COUNT(peliculas) FROM peliculas GROUP BY director ORDER BY COUNT DESC LIMIT 10;
-- Pregunta 7 Indicar cuantos actores distintos hay
SELECT COUNT(DISTINCT actores) FROM reparto;
--Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente
SELECT peliculas,año_estreno FROM peliculas WHERE año_estreno >=1990 and año_estreno<=1999 ORDER BY peliculas ASC
--9. Listar el reparto de las películas lanzadas el año 2001 
SELECT peliculas, año_estreno FROM peliculas WHERE año_estreno = 2001;
--10. Listar los actores de la película más nueva
SELECT actores FROM reparto WHERE id IN (SELECT id FROM peliculas WHERE año_estreno =(SELECT MAX(año_estreno) FROM peliculas));