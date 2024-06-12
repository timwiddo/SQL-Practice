-- https://en.wikibooks.org/wiki/SQL_Exercises/Movie_theatres


-- 4.1 Select the title of all movies.

SELECT
	Title
FROM
	Movies

-- 4.2 Show all the distinct ratings in the database.

SELECT DISTINCT
	Rating
FROM
	Movies

-- 4.3  Show all unrated movies.

SELECT
	Title
FROM
	Movies
WHERE
	Rating 
IS NULL

-- 4.4 Select all movie theaters that are not currently showing a movie.

SELECT 
	* 
FROM 
	MovieTheaters
WHERE 
	Movie 
IS NULL

-- 4.5 Select all data from all movie theaters 
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).

SELECT 
	*
FROM
	MovieTheaters t
LEFT JOIN
	Movies m
ON
	m.Code = t.Movie

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.

SELECT 
	*
FROM 
	MovieTheaters t
RIGHT JOIN 
	Movies m
ON 
	t.Movie = m.Code

-- 4.7 Show the titles of movies not currently being shown in any theaters.

SELECT 
	m.Title
FROM
	MovieTheaters t
RIGHT JOIN 
	Movies m
ON 
	t.Movie = m.Code
WHERE
	t.Movie 
IS NULL
	

-- 4.8 Add the unrated movie "One, Two, Three".

INSERT INTO 
	Movies(Title,Rating) 
VALUES
	('One, Two, Three',NULL)

-- 4.9 Set the rating of all unrated movies to "G".

UPDATE 
	Movies
SET 
	Rating = 'G'
WHERE 
	Rating is NULL

-- 4.10 Remove movie theaters projecting movies rated "NC-17".

DELETE FROM
    MovieTheaters
WHERE
    Movie IN (	--Movie here is just a placeholder variable we could also name it 'x'
        SELECT
            Code
        FROM
            Movies
        WHERE
            Rating = 'NC-17'
    )
	 
