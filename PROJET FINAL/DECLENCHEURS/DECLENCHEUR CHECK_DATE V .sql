
create trigger CHECK_DATE
    on RÉSERVATION
    AFTER insert
    as
    BEGIN
        IF EXISTS(
            SELECT * FROM inserted I
            JOIN RÉSERVATION ON I.Num_Réservation = RÉSERVATION.Num_Réservation AND GETDATE() > I.Date_Arrivée AND I.Date_Départ < I.Date_Arrivée
            )
            BEGIN
                RAISERROR ('LA/LES DATES SONT INVALIDE',10,1)
                ROLLBACK
            end
    end
GO
    ALTER TABLE RESERVATION ENABLE TRIGGER CHECK_DATE
GO

INSERT INTO FACTURE VALUES (13, GETDATE(), 100)
INSERT INTO RÉSERVATION VALUES (20000241201, '2019-02-03', '2019-01-10', 2, 4, 13)
