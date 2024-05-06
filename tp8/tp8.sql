SET SERVEROUTPUT ON;

/*
Exercice 1. On s’intéresse aux films dans lesquels un acteur joue.
a) Ecrire une fonction nbFilms qui, étant donné un acteur (son idPersonne), retourne le nombre de
films dans lesquels il a joué.
Se servir de la fonction nbFilms pour afficher le nombre de films où joue l’acteur n. 880.
*/

CREATE OR REPLACE FUNCTION nbFilms(acteur bdFilm.personne.idPersonne%type) RETURN NUMBER IS
    nb_films NUMBER(5);
BEGIN
    -- Compteur de films
    SELECT COUNT(*)
    INTO nb_films
    FROM bdFilm.roleFilm f
    WHERE idPersonne = acteur;

    RETURN nb_films;
END nbFilms;
/

SET SERVEROUTPUT ON;
DECLARE
    nombre_films_880 NUMBER;
BEGIN
    nombre_films_880 := nbFilms(880);
    DBMS_OUTPUT.put_line('Nombre de films où joue acteur n°880: ' || nombre_films_880);
END;
/

/*
b) On va maintenant afficher les genres des films dans lesquels un acteur joue. Écrire une procé-
dure Afficher qui, étant donné un acteur (son idPersonne), affiche les genres et le nombre de
films par genre dans lesquels il a joué.
Exécuter la procédure Afficher pour les genres des films où joue l’acteur n. 880. (Rappel : Un
film peut avoir plusieurs genres.)
*/
CREATE OR REPLACE PROCEDURE Afficher(acteur bdFilm.personne.idPersonne%type) IS
  cursor C IS
    SELECT nomgenre, COUNT(*) AS nb_films
    FROM bdfilm.roleFilm 
    NATURAL JOIN bdFilm.genrefilm
    NATURAL JOIN bdFilm.genre
    WHERE idPersonne = acteur
    GROUP BY idGenre, nomGenre;
BEGIN
    FOR genre_row IN C LOOP
        DBMS_OUTPUT.PUT_LINE('Genre: ' || genre_row.nomGenre || ', Nombre de films: ' || genre.nb_films);
    END LOOP;
END Afficher;
/

/*
c) Écrire une procédure AfficherNom qui à partir du nom d’un acteur, cherche toutes les per-
sonnes qui portent ce nom et, pour chacune d’entre elles, affiche son prénom, son nom et ap-
pelle la procédure Afficher précédente.
Exécuter la procédure AfficherNom pour les personnes dont le nom est « Affleck ».
*/
CREATE OR REPLACE PROCEDURE AfficherNom(nomActeur IN VARCHAR2) IS
BEGIN
    FOR personne_row IN(
    SELECT p.idPersonne, p.prenomPersonne, p.nomPersonne, nbFilms(p.idPersonne, p.prenomPersonne, p.nomPersonne)
    FROM bdfilm.personne p
    WHERE p.nomPersonne = nomActeur
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('prenom: ' || personne_row.prenomPersonne || 'nom: ' || personne_row.nomPersonne);
        DBMS_OUTPUT.PUT_LINE('Nombre total de films: '|| personne_row.total_film);
        Afficher(personne_row.idPersonne);
    END LOOP;
END AfficherNom;

