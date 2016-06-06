/*
 * ===---SQL Playground 1-------------------------------------------------------===
 *  SQL Script for SQL Playground Project, by Guillaume
 *
 *  by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

 -- List all first_name atrributes of Person Table.
 SELECT first_name FROM Person;

 -- List of first_name and age:
 SELECT first_name, age FROM Person;

 -- List of distinct(unique) Eyescolor:
 SELECT DISTINCT color FROM Eyescolor;

 -- List of first_name, last_name and age, ordered by Age(ascendant):
 SELECT first_name, last_name, age FROM Person ORDER BY age ASC;
