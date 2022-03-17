CREATE TRIGGER interdit_adresse
   ON  CLIENT
   AFTER UPDATE
AS
BEGIN
   SET NOCOUNT ON;
   if exists (
      SELECT *
      FROM INSERTED I
      JOIN DELETED D ON D.Id_Client = I.Id_Client AND d.Id_Adresse <> i.Id_Adresse
   )
   begin
       raiserror('Improssible de changer l adresse.',10,-1)
       rollback
   end
END
GO

ALTER TABLE CLIENT ENABLE TRIGGER interdit_adresse
GO

UPDATE CLIENT SET Id_Adresse = 5 WHERE Id_Client = 8;
