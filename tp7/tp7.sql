DECLARE
    nb_comedies NUMBER;
    nb_comedies_et_action NUMBER;
BEGIN
    -- Nombre de com�dies
    SELECT COUNT(*)
    INTO nb_comedies
    FROM bdfilm.genre
    WHERE nomGenre = 'Com�die';

    -- Nombre de films qui sont � la fois des com�dies et des films d'action
    SELECT COUNT(*)
    INTO nb_comedies_et_action
    FROM Genre g1
    JOIN Genre g2 ON g1.filmID = g2.filmID
    WHERE g1.nomGenre = 'Com�die'
    AND g2.nomGenre = 'Action';

    -- Affichage des r�sultats
    DBMS_OUTPUT.PUT_LINE('Nombre de com�dies : ' || nb_comedies);
    DBMS_OUTPUT.PUT_LINE('Nombre de films qui sont � la fois des com�dies et des films d�action : ' || nb_comedies_et_action);
END;
/
