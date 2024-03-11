CREATE TABLE CLIENT(
idClient NUMBER(10) primary key,
prenomClient varchar2(100),
nomClient varchar2(100) not null,
planClient varchar2 not null check (planClient IN('Essentiel
avec publicité', 'Essentiel ', 'Standard ', 'Supérieur ', 'Premium'))
);

CREATE TABLE VISIONNAGE(
idClient NUMBER(10) REFERENCES CLIENT,
horoDatageDebut TIMESTAMP,
idFilm NUMBER(10),
numVersion NUMBER(1),
minuteStop NUMBER(10),
horoDatageFin TIMESTAMP,
PRIMARY KEY (idClient, horodatageDebut),
--FOREIGN KEY (idFilm, numVersion) REFERENCE bdfilm.Version(idFilm, numVersion),
CONSTRAINT horoDatage_check CHECK (horoDatageDebut < horoDatageFin)
);


--Question b

INSERT INTO client(idClient, prenomClient, nomClient, planClient)
VALUES (882213, 'William Blake', 'Essentiel avec publicité');
INSERT INTO client(idClient, prenomClient, nomClient, planClient)
VALUES (114455, 'Helena Lovett', 'Supérieur');
INSERT INTO client(idClient, prenomClient, nomClient, planClient)
VALUES (446672, 'Jeanne Moreau', 'Premium');

--Question c

INSERT INTO client(idClient, horoDatageDebut, idFilm, numVersion, minuteStop, horoDatageFin)
VALUES (882213, TO TIME(08-02-2024 00:06:00, 792307 1 31 08-02-2024 00:41:00)