CREATE TABLE employee (
    id serial primary key,
    name varchar(50) not null  
);


CREATE TABLE hierarchy (
    id integer references employee ON DELETE CASCADE not null unique,
    parent integer references employee ON DELETE SET NULL not null 
);


INSERT INTO employee (id, name) VALUES
    (1, 'Angela Westbrook'),
    (2, 'Javier Robicheaux'),
    (3, 'Millard Gillins'),
    (4, 'Robert Curry'),
    (5, 'Jordon Gipson'),
    (6, 'Gregory Stene'),
    (7, 'Julie Rodgers'),
    (8, 'Dane Larrow'),
    (9, 'John Raybuck'),
    (10, 'Larry Seals'),
    (11, 'James Riddick'),
    (12, 'Jeffrey Storey'),
    (13, 'Mary Jiggetts'),
    (14, 'Kevin Hyde'),
    (15, 'Irving Rivera'),
    (16, 'Margaret Proper'),
    (17, 'Dale Ahrens'),
    (18, 'James Owen'),
    (19, 'Clarita Guerra'),
    (20, 'Mary Cole');

ALTER SEQUENCE employee_id_seq RESTART WITH 21;

INSERT INTO hierarchy (id, parent) VALUES
--    (1, -1), 
    (2,  1),
    (3,  1),
    (4,  1),
    (5,  2),
    (6,  2),
    (7,  3),
    (8,  3),
    (9,  3),
    (10, 3),
    (11, 4),
    (12, 4),
    (13, 4),
    (14, 4),
    (15, 4),
    (16, 5),
    (17, 6),
    (18, 7),
    (19, 9),
    (20, 9);
