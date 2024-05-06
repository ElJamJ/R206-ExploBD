CREATE OR REPLACE TABLE TRACE (

CREATE OR REPLACE TRIGGER Trigger1
AFTER INSERT OR UPDATE OF horoDatageFin
ON Visionnage FOR EACH ROW
BEGIN
IF INSERTING THEN INSERT INTO Trace VALUES
(nbLignes+1, 'Trigger 1 (AFTER/FOR EACH ROW) : Nouveau visionnage pour le client '||:NEW.idClient);
END IF;
IF UPDATING THEN INSERT INTO Trace VALUES
(nbLignes+1, 'Trigger 1 (AFTER/FOR EACH ROW) : Mise à jour de fin de visionnage le pour le client '||
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
(nbLignes+1, 'Trigger 3 (BEFORE/FOR EACH ROW) : Mise à jour de fin de visionnage le pour le client '||
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

DROP TABLE TRACE;