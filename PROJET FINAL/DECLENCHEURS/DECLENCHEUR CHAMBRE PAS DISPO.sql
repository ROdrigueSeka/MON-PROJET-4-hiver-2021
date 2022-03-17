create trigger CHAMBRE_PAS_DISPONIBLE
    on RÉSERVATION
    AFTER insert, UPDATE
    as
    BEGIN
        IF EXISTS(SELECT * FROM INSERTED I
            JOIN RÉSERVATION ON I.Nbre_Chambre = RÉSERVATION.Nbre_Chambre AND ((I.Date_Arrivée > RÉSERVATION.Date_Arrivée 
			AND I.Date_Arrivée < RÉSERVATION.Date_Départ) OR
                                     (I.Date_Départ > RÉSERVATION.Date_Arrivée AND I.Date_Départ < RÉSERVATION.Date_Départ))
            )
        BEGIN
            RAISERROR ('LA CHAMBRE EST DEJA RESERVER', 10, 1)
            ROLLBACK
        end
    end
GO
    ALTER TABLE RÉSERVATION ENABLE TRIGGER CHAMBRE_PAS_DISPONIBLE
GO
INSERT INTO FACTURE VALUES (22, GETDATE())
INSERT INTO RÉSERVATION VALUES (20040341211, '2021-06-06', '2021-06-11', 2, 4, 22)

