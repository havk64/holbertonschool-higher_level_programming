/* ===---MySQL-----------------------------------------------------=== *
 *	Task 3 - Create a script to reply this questions.
 *
 *	by Alexandro de Oliveira
 * ===-------------------------------------------------------------=== */


\! echo "\nList of TVShows ordered by name (A-Z) with more than or equal 4 seasons?"
SELECT name FROM (SELECT TVShow.name, count(Season.tvshow_id) AS nb_seasons 
	FROM TVShow LEFT JOIN Season ON (TVShow.id = Season.tvshow_id) 
	GROUP BY Season.tvshow_id ORDER BY name) AS s WHERE nb_seasons > 3;

\! echo "\nList of TVShows ordered by name (A-Z) with the Genre 'Comedy'?"
SELECT TVShow.name FROM TVShow LEFT JOIN TVShowGenre 
	ON (TVShow.id = TVShowGenre.tvshow_id) LEFT JOIN Genre 
	ON (TVShowGenre.genre_id = Genre.id) WHERE Genre.name = "Comedy" 
	ORDER BY TVShow.name;

\! echo "\nList of Actors ordered by name (A-Z) for the TVShow 'The Big Bang Theory'?"
SELECT Actor.name FROM TVShow LEFT JOIN TVShowActor 
	ON (TVShow.id = TVShowActor.tvshow_id) LEFT JOIN Actor 
	ON (TVShowActor.actor_id = Actor.id) WHERE TVShow.name = "The Big Bang Theory" 
	ORDER BY Actor.name;

\! echo "\nTop 10 of actors by number of TVShows where they are? (without Actor name order => can be random)"
SELECT Actor.name, count(TVShow.id) as nb_tvshows 
	FROM TVShow LEFT JOIN TVShowActor 
	ON (TVShow.id = TVShowActor.tvshow_id) LEFT JOIN Actor 
	ON (TVShowActor.actor_id = Actor.id) GROUP BY Actor.name 
	ORDER BY COUNT(TVShow.id) DESC LIMIT 10;
