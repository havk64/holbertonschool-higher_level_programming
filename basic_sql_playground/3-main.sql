/*
 * ===---SQL Playground 3-------------------------------------------------------===
 *  SQL Script for SQL Playground Project, by Guillaume
 *
 *  by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

 -- Updating age of Jon Snow to 27:
 UPDATE Person SET age=27 WHERE last_name='Snow';

 -- Updating age of Walter Junior While to 18:
 UPDATE Person SET age=18 WHERE first_name='Walter Junior';
 -- Deleting the person Walter White and Eyescolor:
 DELETE from EyesColor WHERE person_id=(SELECT id FROM Person WHERE first_name='Walter');
 DELETE from Person WHERE first_name="Walter";

 -- List all Person with all attributes, ordered by first_name:
 SELECT * from Person ORDER BY first_name;
