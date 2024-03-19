DROP TABLE VISIONNAGE;
DROP TABLE CLIENTS;

CREATE TABLE CLIENTS(
    idClient NUMBER(10) PRIMARY KEY,
    prenomClient VARCHAR2(100),
    nomClient VARCHAR2(100) NOT NULL,
    planClient VARCHAR2(50) NOT NULL CHECK (planClient IN ('Essentiel avec publicité', 'Essentiel', 'Standard', 'Supérieur', 'Premium'))
);

CREATE TABLE VISIONNAGE(
    idClient NUMBER(10) REFERENCES CLIENTS,
    horoDatageDebut TIMESTAMP,
    idFilm NUMBER(10),
    numVersion NUMBER(1),
    minuteStop NUMBER(10),
    horoDatageFin TIMESTAMP,
    PRIMARY KEY (idClient, horoDatageDebut),
    CONSTRAINT horoDatage_check CHECK (horoDatageDebut < horoDatageFin)
);

-- Question b

INSERT INTO clients(idClient, prenomClient, nomClient, planClient)
VALUES (882213, 'William', 'Blake', 'Essentiel avec publicité');

INSERT INTO clients(idClient, prenomClient, nomClient, planClient)
VALUES (114455, 'Helena', 'Lovett', 'Supérieur');

INSERT INTO clients(idClient, prenomClient, nomClient, planClient)
VALUES (446672, 'Jeanne', 'Moreau', 'Premium');

-- Question c

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, minuteStop, horoDatageFin)
VALUES (882213, TO_TIMESTAMP('08-02-2024 00:06:00', 'DD-MM-YYYY HH24:MI:SS'), 792307, 1, 31, TO_TIMESTAMP('08-02-2024 00:41:00', 'DD-MM-YYYY HH24:MI:SS'));

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, horoDatageFin)
VALUES (882213, TO_TIMESTAMP('08-02-2024 20:41:00', 'DD-MM-YYYY HH24:MI:SS'), 792307, 1, TO_TIMESTAMP('08-02-2024 23:49:00', 'DD-MM-YYYY HH24:MI:SS'));

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, horoDatageFin)
VALUES (114455, TO_TIMESTAMP('14-02-2024 22:23:00', 'DD-MM-YYYY HH24:MI:SS'), 398818, 4, TO_TIMESTAMP('15-02-2024 00:34:00', 'DD-MM-YYYY HH24:MI:SS'));

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, minuteStop, horoDatageFin)
VALUES (114455, TO_TIMESTAMP('15-02-2024 19:16:00', 'DD-MM-YYYY HH24:MI:SS'), 398818, 2, 86, TO_TIMESTAMP('15-02-2024 19:32:00', 'DD-MM-YYYY HH24:MI:SS'));

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, minuteStop, horoDatageFin)
VALUES (114455, SYSTIMESTAMP - INTERVAL '2' HOUR, 7345, 3, 120, SYSTIMESTAMP);

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, horoDatageFin)
VALUES (114455, SYSTIMESTAMP, 7345, 3, SYSTIMESTAMP + INTERVAL '1' HOUR);

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, horoDatageFin)
VALUES (446672, SYSTIMESTAMP, 496243, 5, SYSTIMESTAMP + INTERVAL '1' HOUR);

--EX2
SELECT * FROM bdFilm.equipefilm;
--a
DROP VIEW vvFilm;
CREATE VIEW vvFilm AS SELECT idFilm, COUNT(numVersion) AS nbVersions
FROM bdfilm.VERSION
GROUP BY idFilm;

SELECT * FROM vvFilm;

DROP VIEW vRealisateur;
CREATE VIEW vRealisateur AS SELECT DISTINCT ef.idPersonne, prenomPersonne, nomPersonne FROM bdFilm.equipefilm ef
INNER JOIN bdFilm.personne P ON P.idPersonne = ef.idPersonne
WHERE job ='Director';

SELECT * FROM vrealisateur;

DROP VIEW vvAuj;