
create trigger CHECK_DATE
    on R�SERVATION
    AFTER insert
    as
    BEGIN
        IF EXISTS(
            SELECT * FROM inserted I
            JOIN R�SERVATION ON I.Num_R�servation = R�SERVATION.Num_R�servation AND GETDATE() > I.Date_Arriv�e AND I.Date_D�part < I.Date_Arriv�e
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
INSERT INTO R�SERVATION VALUES (20000241201, '2019-02-03', '2019-01-10', 2, 4, 13)
