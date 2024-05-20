DROP TABLE VISIONNAGE;
DROP TABLE CLIENTS1;
DROP TABLE TRACE;

CREATE TABLE CLIENT(
    idClient NUMBER(10) PRIMARY KEY,
    prenomClient VARCHAR2(100),
    nomClient VARCHAR2(100) NOT NULL,
    planClient VARCHAR2(50) NOT NULL CHECK (planClient IN ('Essentiel avec publicit�', 'Essentiel', 'Standard', 'Sup�rieur', 'Premium'))
);

CREATE TABLE TRACE( 
    numLigne NUMBER(10),
    message VARCHAR2(100)
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
VALUES (882213, 'William', 'Blake', 'Essentiel avec publicit�');

INSERT INTO clients(idClient, prenomClient, nomClient, planClient)
VALUES (114455, 'Helena', 'Lovett', 'Sup�rieur');

INSERT INTO clients(idClient, prenomClient, nomClient, planClient)
VALUES (446672, 'Jeanne', 'Moreau', 'Premium');

-- Question c

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, minuteStop, horoDatageFin)
VALUES (882213, TO_TIMESTAMP('08-02-2024 00:06:00', 'DD-MM-YYYY HH24:MI:SS'), 792307, 1, 31, TO_TIMESTAMP('08-02-2024 00:41:00', 'DD-MM-YYYY HH24:MI:SS'));

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, horoDatageFin)
VALUES (882213, TO_TIMESTAMP('08-02-2024 20:41:00', 'DD-MM-YYYY HH24:MI:SS'), 792307, 1, TO_TIMESTAMP('08-02-2024 23:49:00', 'DD-MM-YYYY HH24:MI:SS'));

INSERT INTO Visionnage (idClient, horoDatageDebut, idFilm, numVersion, horoDatageFin)
VALUES (114455, TO_TIMESTAMP('14-02-2024 22:23:00', 'DD-MM-YYYY HH24:MI:SS'), 398818, 4, TO_TIMESTAMP('15-02-2024 00:34:00', 'DD-MM-YYYY HH24:MI:SS'));

CREATE OR REPLACE FUNCTION nbLignes RETURN NUMBER AS
nb NUMBER;
BEGIN
SELECT COUNT(*) INTO nb FROM Trace;
RETURN nb;
END nbLignes;
/

CREATE OR REPLACE TRIGGER Trigger1
AFTER INSERT OR UPDATE OF horoDatageFin
ON Visionnage FOR EACH ROW
BEGIN
IF INSERTING THEN INSERT INTO Trace VALUES
(nbLignes+1, 'Trigger 1 (AFTER/FOR EACH ROW) : Nouveau visionnage pour le client '||:NEW.idClient);
END IF;
IF UPDATING THEN INSERT INTO Trace VALUES
(nbLignes+1, 'Trigger 1 (AFTER/FOR EACH ROW) : Mise � jour de fin de visionnage le pour le client '||
:OLD.idClient);
END IF;
END trigger1;
/

CREATE OR REPLACE TRIGGER Trigger2
AFTER INSERT OR UPDATE OF horoDatageFin
ON Visionnage
BEGIN
INSERT INTO Trace VALUES (nbLignes+1, 'Trigger 2 (AFTER) : Modification dans Visionnage');
END trigger2;
/

CREATE OR REPLACE TRIGGER Trigger3
BEFORE INSERT OR UPDATE OF horoDatageFin
ON Visionnage FOR EACH ROW
BEGIN
IF INSERTING THEN INSERT INTO Trace VALUES
(nbLignes+1, 'Trigger 3 (BEFORE/FOR EACH ROW) : Nouveau visionnage pour le client '||:NEW.idClient);
END IF;
IF UPDATING THEN INSERT INTO Trace VALUES
(nbLignes+1, 'Trigger 3 (BEFORE/FOR EACH ROW) : Mise � jour de fin de visionnage le pour le client '||
:OLD.idClient);
END IF;
END trigger3;
/

CREATE OR REPLACE TRIGGER Trigger4
BEFORE INSERT OR UPDATE OF horoDatageFin
ON Visionnage
BEGIN
INSERT INTO Trace VALUES (nbLignes+1, 'Trigger 4 (BEFORE) : Modification dans Visionnage');
END trigger4;
/

--e

INSERT INTO Visionnage VALUES (882213, SYSDATE-3/24, 792307, 1, NULL, SYSDATE); 

/*
Trigger 3 (BEFORE/FOR EACH ROW) : Nouveau visionnage pour le client 882213
Trigger 4 (BEFORE) : Modification dans Visionnage
Trigger 1 (AFTER/FOR EACH ROW) : Nouveau visionnage pour le client 882213
Trigger 2 (AFTER) : Modification dans Visionnage
*/

--f

UPDATE Visionnage
SET horoDatageFin = NULL
WHERE idClient = 882213
AND TRUNC(horoDatageDebut) = TRUNC(SYSDATE) ;

/*
Trigger 3 (BEFORE/FOR EACH ROW) : Mise à jour de fin de visionnage pour le client 882213
Trigger 4 (BEFORE) : Modification dans Visionnage
Trigger 1 (AFTER/FOR EACH ROW) : Mise à jour de fin de visionnage pour le client 882213
Trigger 2 (AFTER) : Modification dans Visionnage
*/

--g

UPDATE Visionnage
SET horoDatageFin = horoDatageFin+1/(24*60)
WHERE idClient = 114455
AND minuteStop IS NOT NULL ;

/*
Trigger 3 (BEFORE/FOR EACH ROW) : Mise à jour de fin de visionnage pour le client 114455
Trigger 4 (BEFORE) : Modification dans Visionnage
Trigger 1 (AFTER/FOR EACH ROW) : Mise à jour de fin de visionnage pour le client 114455
Trigger 2 (AFTER) : Modification dans Visionnage
*/

--h

/*

Les déclencheurs de type BEFORE s'exécutent avant ceux de type AFTER. Les déclencheurs de niveau ROW s'exécutent pour chaque ligne affectée, tandis que les déclencheurs de niveau STATEMENT s'exécutent une seule fois par opération.

*/

-------------------------------------------
--------------------EX2--------------------
-------------------------------------------
/*
CREATE OR REPLACE TRIGGER verifStop
BEFORE INSERT OR UPDATE ON Visionnage
FOR EACH ROW
BEGIN
  IF :NEW.minuteStop IS NOT NULL AND :NEW.horoDatageFin IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'minuteStop est renseigné mais horoDatageFin ne l\'est pas.');
  END IF;
END verifStop;
/
*/

-------------------------------------------
--------------------EX3--------------------
-------------------------------------------

CREATE OR REPLACE TRIGGER verifVisio
BEFORE INSERT ON Visionnage
FOR EACH ROW
DECLARE
  nbEnCours NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO nbEnCours
  FROM Visionnage
  WHERE idClient = :NEW.idClient
  AND horoDatage
