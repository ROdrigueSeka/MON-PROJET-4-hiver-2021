create trigger LIMITE_RESERVATION
    on R�SERVATION
    AFTER  INSERT, UPDATE
    as
    BEGIN
        IF EXISTS(
                SELECT * FROM INSERTED I
                JOIN R�SERVATION ON I.Num_R�servation = R�SERVATION.Num_R�servation AND DATEDIFF(HOUR, I.Date_Arriv�e, I.Date_D�part) > 200
            )
        BEGIN
            RAISERROR ('DUREE DE LA RESERVATION TROP LONGUE',10,-1)
            ROLLBACK
        end
    end
GO
    ALTER TABLE R�SERVATION ENABLE TRIGGER LIMITE_RESERVATION
