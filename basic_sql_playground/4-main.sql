/*
 * ===---SQL Playground 4-------------------------------------------------------===
 *  SQL Script for SQL Playground Project, by Guillaume
 *
 *  by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

-- Inserting eyes color of Jon Snow and Arya Snor to EyesColor table:
INSERT INTO EyesColor(person_id, color) VALUES ((SELECT id FROM Person WHERE first_name="Jon"), 'Brown');
INSERT INTO EyesColor(person_id, color) VALUES ((SELECT id FROM Person WHERE first_name="Arya"), 'Green');

-- Creating the Table TVShow:
CREATE TABLE TVShow (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name char(128) NOT NULL
);

-- Creating the Table TVShowPerson:
CREATE TABLE TVShowPerson (
    tvshow_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    FOREIGN KEY(tvshow_id) REFERENCES TVShow(id),
    FOREIGN KEY(person_id) REFERENCES Person(id)
);
-- Inserting data in TVShow table:
INSERT INTO TVShow (name) VALUES ("Homeland");
INSERT INTO TVShow (name) VALUES ("The big bang theory");
INSERT INTO TVShow (name) VALUES ("Game of Thrones");
INSERT INTO TVShow (name) VALUES ("Breaking bad");

-- Adding all TVShow link to Person in TVShowPerson:
INSERT INTO TVShowPerson (tvshow_id, person_id) VALUES (
    (SELECT id FROM TVShow WHERE name='Breaking bad'),
    (SELECT id FROM Person WHERE first_name='Walter Junior')
);

INSERT INTO TVShowPerson (tvshow_id, person_id) VALUES (
    (SELECT id FROM TVShow WHERE name='Game of Thrones'),
    (SELECT id FROM Person WHERE first_name='Jaime')
);

INSERT INTO TVShowPerson (tvshow_id, person_id) VALUES (
    (SELECT id FROM TVShow WHERE name='The big bang theory'),
    (SELECT id FROM Person WHERE first_name='Sheldon')
);

INSERT INTO TVShowPerson (tvshow_id, person_id) VALUES (
    (SELECT id FROM TVShow WHERE name='Game of Thrones'),
    (SELECT id FROM Person WHERE first_name='Tyrion')
);

INSERT INTO TVShowPerson (tvshow_id, person_id) VALUES (
    (SELECT id FROM TVShow WHERE name='Game of Thrones'),
    (SELECT id FROM Person WHERE first_name='Jon')
);

INSERT INTO TVShowPerson (tvshow_id, person_id) VALUES (
    (SELECT id FROM TVShow WHERE name='Game of Thrones'),
    (SELECT id FROM Person WHERE first_name='Arya')
);

SELECT * FROM Person;
SELECT * FROM EyesColor;
SELECT * FROM TVShow;
SELECT * FROM TVShowPerson;
