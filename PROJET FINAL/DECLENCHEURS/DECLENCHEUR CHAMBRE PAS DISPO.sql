create trigger CHAMBRE_PAS_DISPONIBLE
    on R�SERVATION
    AFTER insert, UPDATE
    as
    BEGIN
        IF EXISTS(SELECT * FROM INSERTED I
            JOIN R�SERVATION ON I.Nbre_Chambre = R�SERVATION.Nbre_Chambre AND ((I.Date_Arriv�e > R�SERVATION.Date_Arriv�e 
			AND I.Date_Arriv�e < R�SERVATION.Date_D�part) OR
                                     (I.Date_D�part > R�SERVATION.Date_Arriv�e AND I.Date_D�part < R�SERVATION.Date_D�part))
            )
        BEGIN
            RAISERROR ('LA CHAMBRE EST DEJA RESERVER', 10, 1)
            ROLLBACK
        end
    end
GO
    ALTER TABLE R�SERVATION ENABLE TRIGGER CHAMBRE_PAS_DISPONIBLE
GO
INSERT INTO FACTURE VALUES (22, GETDATE())
INSERT INTO R�SERVATION VALUES (20040341211, '2021-06-06', '2021-06-11', 2, 4, 22)

