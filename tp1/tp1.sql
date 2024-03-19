//CREATE SYNONYM ACTIVITE FOR ffioren.ACTIVITE

SELECT nomcamping, a.nomactivite FROM camping C
INNER JOIN ACTICAMPING AC ON AC.numcamping = c.numcamping
INNER JOIN ACTIVITE A ON a.numactivite = ac.numactivite
WHERE ac.prixactivite < 3;

SELECT MAX(prixActivite) AS actiPlusChere
FROM acticamping AC
INNER JOIN CAMPING C ON c.numcamping = ac.numcamping
INNER JOIN ACTIVITE A ON a.numactivite = ac.numactivite
WHERE c.nomcamping = 'La Forêt';

SELECT DISTINCT nomActivite FROM ACTIVITE A
INNER JOIN ACTICAMPING AC ON ac.numactivite = a.numactivite
INNER JOIN CAMPING C ON c.numcamping = ac.numcamping
WHERE c.nbetoiles =3;

SELECT nomActivite FROM ACTIVITE A
INNER JOIN ACTICAMPING AC ON a.numactivite = A.numactivite
INNER JOIN CAMPING C ON C.numcamping = AC.numcamping
WHERE c.numcamping IN (SELECT c.numcamping 
                        FROM camping C
                        INNER JOIN ACTICAMPING AC ON ac.numactivite = A.numactivite
                        INNER JOIN CAMPING C ON C.numcamping = AC.numcamping
                        WHERE c.NbEtoiles =3);