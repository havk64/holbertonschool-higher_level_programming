/*
 * ===---SQL Playground 6-------------------------------------------------------===
 *  SQL Script for SQL Playground Project, by Guillaume
 *
 *  by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

 -- Listing sums of age by TVShow ordered by the sum (ascending) :
 SELECT DISTINCT TVShow.name, sum(Person.age) FROM TVShow
 JOIN TVShowPerson ON TVShowPerson.tvshow_id = TVShow.id,
 Person ON TVShowPerson.person_id=Person.id
 GROUP BY TVShow.name
 ORDER BY sum(Person.age) ASC;

-- Listing the youngest Person of each TVShow ordered by the age (ascending)
 SELECT TVShow.name, Person.first_name, Person.last_name, min(Person.age) FROM TVShow
 JOIN TVShowPerson ON TVShowPerson.tvshow_id = TVShow.id,
 Person ON TVShowPerson.person_id = Person.id
 GROUP BY TVShow.name
 ORDER BY min(Person.age) ASC;
