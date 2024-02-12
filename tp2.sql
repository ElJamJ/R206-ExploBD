//Question a
SELECT DISTINCT nomVoyage FROM ffioren.voyage V
INNER JOIN ffioren.ETAPE E ON e.numvoyage = v.numvoyage
INNER JOIN ffioren.ville Vi ON vi.numville = e.numville
INNER JOIN ffioren.pays P ON p.numpays = vi.numpays
WHERE nompays='France';

//Question b
SELECT DISTINCT nomVoyage FROM ffioren.pays P1
INNER JOIN ffioren.ville Vi ON vi.numpays = p1.numpays
INNER JOIN ffioren.ETAPE E1 ON e1.numville = vi.numville
INNER JOIN ffioren.voyage V ON v.numvoyage = E1.numvoyage
WHERE nomVoyage NOT IN (
                        SELECT nomvoyage FROM voyage V1
                        INNER JOIN ffioren.ETAPE E1 ON e1.numvoyage = v1.numvoyage
                        INNER JOIN ffioren.VILLE VI1 ON vi1.numville = e1.numville
                        INNER JOIN ffioren.pays P2 ON p2.numpays = vi1.numpays
                        WHERE p2.nompays != 'France'
                        );

//Question c
SELECT DISTINCT nomVoyage FROM ffioren.pays P1
INNER JOIN ffioren.ville Vi ON vi.numpays = p1.numpays
INNER JOIN ffioren.ETAPE E1 ON e1.numville = vi.numville
INNER JOIN ffioren.voyage V ON v.numvoyage = E1.numvoyage
WHERE nomVoyage NOT IN (
                        SELECT nomvoyage FROM voyage V1
                        INNER JOIN ffioren.ETAPE E1 ON e1.numvoyage = v1.numvoyage
                        INNER JOIN ffioren.VILLE VI1 ON vi1.numville = e1.numville
                        INNER JOIN ffioren.pays P2 ON p2.numpays = vi1.numpays
                        WHERE p2.nompays = 'France'
                        );
                        
//Question d
SELECT DISTINCT nomVoyage FROM ffioren.pays P1
INNER JOIN ffioren.ville Vi ON vi.numpays = p1.numpays
INNER JOIN ffioren.ETAPE E1 ON e1.numville = vi.numville
INNER JOIN ffioren.voyage V ON v.numvoyage = E1.numvoyage
WHERE nomVoyage IN (
                        SELECT nomvoyage FROM voyage V1
                        INNER JOIN ffioren.ETAPE E1 ON e1.numvoyage = v1.numvoyage
                        INNER JOIN ffioren.VILLE VI1 ON vi1.numville = e1.numville
                        INNER JOIN ffioren.pays P2 ON p2.numpays = vi1.numpays
                        WHERE p2.nompays != 'France'
                        );
                        
//Question e
SELECT DISTINCT nomVoyage,Vi.numville, nomVille FROM voyage V
INNER JOIN ffioren.ETAPE E ON e.numvoyage = v.numvoyage
INNER JOIN ffioren.VILLE Vi ON vi.numville = e.numville
WHERE duree = (SELECT MAX(duree)FROM etape
                WHERE numvoyage = V.numvoyage);

//Question f
SELECT nomVoyage FROM VOYAGE v
INNER JOIN ffioren.ETAPE E1 ON e1.numvoyage = v1.numvoyage
INNER JOIN ffioren.VILLE VI1 ON vi1.numville = e1.numville
WHERE etat = 'California'
GROUP BY v.numvoyage, nomVoyage
HAVING COUNT (*) > (SELECT COUNT(*)FROM etape
                    NATURAL JOIN ville
                    WHERE etat ='Arizona'
                    AND numvoyage = v.numvoyage);

/*
SELECT nomVoyage, etat FROM ffioren.VILLE v
INNER JOIN ETAPE E ON E.numville = v.numville
INNER JOIN  ffioren.VOYAGE V1 ON v1.numvoyage = e.numvoyage
WHERE etat = 'Arizona';
*/

