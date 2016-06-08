/*
 * ===---SQL Playground 5-------------------------------------------------------===
 *  SQL Script for SQL Playground Project, by Guillaume
 *
 *  by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

-- Listing all distinct last_name of TVShow = Game of Thrones ord by last_name:
SELECT DISTINCT last_name FROM Person, TVShowPerson
WHERE Person.id = TVShowPerson.person_id
AND TVShowPerson.tvshow_id = (
    SELECT id FROM TVShow WHERE name="Game of Thrones"
) ORDER BY last_name ASC;

-- Listing the number of Person where the age is greater than 30:
SELECT count(age) FROM Person WHERE age > 30;

-- Listing all Person records with all information from other tables:
SELECT Person.id, first_name, last_name, age, Eyescolor.color, TVShow.name FROM Person, TVShowPerson
ON Person.id=TVShowPerson.person_id,
TVShow ON TVShowPerson.tvshow_id=TVShow.id,
Eyescolor ON Eyescolor.person_id=Person.id;

-- Listing the sum of column age of all Person:
SELECT SUM(age) FROM Person;
