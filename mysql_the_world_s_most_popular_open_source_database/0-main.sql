/* ===---MySQL-----------------------------------------------------=== *
 *	Task 0 - Create a script with queries as requested.
 *
 *	by Alexandro de Oliveira
 * ===-------------------------------------------------------------=== */

\! echo "\nList of all tables?"
SHOW TABLES;

SHOW CREATE TABLE TVShow;
SHOW CREATE TABLE Genre;
SHOW CREATE TABLE TVShowGenre;

\! echo "\nList of TVShows, only id and name ordered by name (A-Z)?"
SELECT id, name FROM TVShow ORDER BY name;

\! echo "\nList of Genres, only id and name ordered by name (Z-A)?"
SELECT id, name FROM Genre ORDER BY name DESC;

\! echo "\nList of Network, only id and name?"
SELECT id, name FROM Network;

\! echo "\nNumber of episodes in the database?"
SELECT COUNT(id) from Episode;

