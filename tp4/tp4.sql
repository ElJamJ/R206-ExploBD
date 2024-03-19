// TP4

// Exercice 1

// a) 
SELECT idfilm,titre
FROM bdfilm.film
WHERE idfilm NOT IN(SELECT idfilm
FROM bdfilm.sortie
WHERE codepays = 'FR');

// b)
SELECT nompersonne,prenompersonne
FROM bdfilm.personne
WHERE idpersonne NOT IN(SELECT idpersonne
FROM bdfilm.rolefilm)
AND idpersonne NOT IN(SELECT idpersonne
FROM bdfilm.equipefilm
WHERE job = 'Director');

// c) 
SELECT p.idpersonne,p.nompersonne
FROM bdfilm.personne p
INNER JOIN bdfilm.equipefilm ef ON ef.idpersonne = p.idpersonne
WHERE ef.job = 'Director'
GROUP BY p.idpersonne, p.nompersonne,p.prenompersonne
HAVING COUNT(*) > (SELECT COUNT(*)
FROM bdfilm.rolefilm
WHERE idpersonne = p.idpersonne);

// d)
SELECT COUNT(DISTINCT idpersonne)
FROM bdfilm.equipefilm
NATURAL JOIN bdfilm.rolefilm
WHERE job = 'Director';


// Exercice 2

// a)
CREATE OR REPLACE VIEW Vfilm(idfilm,nbsorties) AS
SELECT idfilm, count(*)
FROM bdfilm.film
NATURAL JOIN bdfilm.sortie
GROUP BY idfilm;

// b)
CREATE OR REPLACE VIEW Vacteur AS
SELECT DISTINCT idpersonne, nompersonne, prenompersonne
FROM bdfilm.personne
INNER JOIN bdfilm.rolefilm USING(idpersonne);

// c)
SELECT prenompersonne
FROM Vacteur
WHERE nompersonne = 'Howard';
