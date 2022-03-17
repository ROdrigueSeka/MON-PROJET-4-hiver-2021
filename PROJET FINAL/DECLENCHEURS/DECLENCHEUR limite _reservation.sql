create trigger LIMITE_RESERVATION
    on RÉSERVATION
    AFTER  INSERT, UPDATE
    as
    BEGIN
        IF EXISTS(
                SELECT * FROM INSERTED I
                JOIN RÉSERVATION ON I.Num_Réservation = RÉSERVATION.Num_Réservation AND DATEDIFF(HOUR, I.Date_Arrivée, I.Date_Départ) > 200
            )
        BEGIN
            RAISERROR ('DUREE DE LA RESERVATION TROP LONGUE',10,-1)
            ROLLBACK
        end
    end
GO
    ALTER TABLE RÉSERVATION ENABLE TRIGGER LIMITE_RESERVATION
