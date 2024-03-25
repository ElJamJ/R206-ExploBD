DECLARE
    nb_comedies NUMBER;
    nb_comedies_et_action NUMBER;
BEGIN
    -- Nombre de comédies
    SELECT COUNT(*)
    INTO nb_comedies
    FROM bdfilm.genre
    WHERE nomGenre = 'Comédie';

    -- Nombre de films qui sont à la fois des comédies et des films d'action
    SELECT COUNT(*)
    INTO nb_comedies_et_action
    FROM Genre g1
    JOIN Genre g2 ON g1.filmID = g2.filmID
    WHERE g1.nomGenre = 'Comédie'
    AND g2.nomGenre = 'Action';

    -- Affichage des résultats
    DBMS_OUTPUT.PUT_LINE('Nombre de comédies : ' || nb_comedies);
    DBMS_OUTPUT.PUT_LINE('Nombre de films qui sont à la fois des comédies et des films d’action : ' || nb_comedies_et_action);
END;
/
