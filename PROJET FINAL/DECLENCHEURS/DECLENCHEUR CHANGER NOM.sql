create trigger CHANGER_NOM
    on CLIENT
    AFTER UPDATE
    as
    BEGIN
        IF EXISTS(
                SELECT *
                FROM inserted I
                JOIN CLIENT ON I.nom = CLIENT.nom AND I.nom <> CLIENT.NOM OR I.Pr�nom <> CLIENT.Pr�nom
            )
        BEGIN
            RAISERROR ('IL EST INTERDIT DE CHANGER LE NOM D UN CLIENT',10,-1)
            ROLLBACK
        end
    end

GO
    ALTER TABLE CLIENT ENABLE TRIGGER CHANGER_NOM
GO

UPDATE CLIENT SET Pr�nom = 'ALEXANDRE' WHERE Id_Client = 1
