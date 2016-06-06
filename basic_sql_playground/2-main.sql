/*
 * ===---SQL Playground 2-------------------------------------------------------===
 *  SQL Script for SQL Playground Project, by Guillaume
 *
 *  by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

 -- Adding two new persons:
 INSERT INTO Person (first_name, last_name, age) VALUES ('Jon', 'Snow', 26);
 INSERT INTO Person (first_name, last_name, age) VALUES ('Arya', 'Stark', 12);

 -- List all Persons ordered by last_name(A-Z);
  SELECT * FROM Person ORDER BY last_name ASC;
