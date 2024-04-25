create database energie;

;


use energie CREATE TABLE [Adresa]
(
    [Cislopopisne] varchar(10) NOT NULL,
    [Psc] char(5) NOT NULL,
    [Ulice] varchar(20) NULL,
    [AdresaID] int NOT NULL IDENTITY (1, 1)
);


use energie CREATE TABLE [Hala]
(
    [Oznaceni] char(10) NOT NULL,
    [HalaID] int NOT NULL IDENTITY (1, 1),
    [TovarnaID] int NOT NULL
)
;

use energie CREATE TABLE [Seznamzamestnancusmeny]
(
    [HalaID] int NOT NULL,
    [ZamestnanecID] int NOT NULL,
    [SmenaID] int NOT NULL
)
;

use energie CREATE TABLE [Smena]
(
    [Casdo] smalldatetime NULL,
    [Casod] smalldatetime NOT NULL,
    [SmenaID] int NOT NULL IDENTITY (1, 1)
)
;

use energie CREATE TABLE [Tovarna]
(
    [Cenazakwh] smallmoney NULL,
    [Foto] varchar(30) NULL,
    [Nazev] varchar(50) NOT NULL,
    [TovarnaID] int NOT NULL IDENTITY (1, 1),
    [AdresaID] int NOT NULL
)
;

use energie CREATE TABLE [Webovyucet]
(
    [Heslohash] varchar(64) NOT NULL,
    [Jmeno] varchar(40) NOT NULL,
    [Typuctu] varchar(10) NOT NULL,
    [WebovyucetID] int NOT NULL IDENTITY (1, 1)
)
;

use energie CREATE TABLE [Zamestnanec]
(
    [Email] varchar(40) NULL,
    [Jmeno] varchar(40) NOT NULL,
    [Prijmeni] varchar(40) NOT NULL,
    [Rodnecislo] char(10) NOT NULL,
    [Telefon] char(12) NULL,
    [ZamestnanecID] int NOT NULL IDENTITY (1, 1),
    [AdresaID] int NULL,
    [WebovyucetID] int NULL
)
;

use energie CREATE TABLE [Zarizeni]
(
    [Oznaceni] varchar(10) NOT NULL,
    [Nazev] varchar(30) NULL,
    [ZarizeniID] int NOT NULL IDENTITY (1, 1),
    [HalaID] int NOT NULL
)
;

use energie CREATE TABLE [Zaznamopouziti]
(
    [Datumcas] smalldatetime NOT NULL,
    [ZaznamopouzitiID] int NOT NULL IDENTITY (1, 1),
    [ZamestnanecID] int NOT NULL,
    [ZarizeniID] int NOT NULL
)
;

use energie CREATE TABLE [Zaznamospotrebe]
(
    [Datumcas] smalldatetime NULL,
    [Spotreba] float NULL,
    [ZaznamospotrebeID] int NOT NULL IDENTITY (1, 1),
    [ZarizeniID] int NULL
)
;

use energie CREATE TABLE [Mesto]
(
    [Psc] char(5) PRIMARY KEY NOT NULL,
    [Mesto] varchar(50) NOT NULL
)
;

/* Create Primary Keys, Indexes, Uniques, Checks */

use energie ALTER TABLE [Adresa]
    ADD CONSTRAINT [PK_Adresa]
        PRIMARY KEY CLUSTERED ([AdresaID] ASC)
;

use energie ALTER TABLE [Hala]
    ADD CONSTRAINT [PK_Hala]
        PRIMARY KEY CLUSTERED ([HalaID] ASC)
;

use energie ALTER TABLE [Seznamzamestnancusmeny]
    ADD CONSTRAINT [PK_Seznamzamestnancusmeny]
        PRIMARY KEY CLUSTERED ([HalaID] ASC,[ZamestnanecID] ASC,[SmenaID] ASC)
;

use energie ALTER TABLE [Smena]
    ADD CONSTRAINT [PK_Smena]
        PRIMARY KEY CLUSTERED ([SmenaID] ASC)
;

use energie ALTER TABLE [Tovarna]
    ADD CONSTRAINT [PK_Tovarna]
        PRIMARY KEY CLUSTERED ([TovarnaID] ASC)
;

use energie ALTER TABLE [Webovyucet]
    ADD CONSTRAINT [PK_Webovyucet]
        PRIMARY KEY CLUSTERED ([WebovyucetID] ASC)
;

use energie ALTER TABLE [Zamestnanec]
    ADD CONSTRAINT [PK_Zamestnanec]
        PRIMARY KEY CLUSTERED ([ZamestnanecID] ASC)
;

use energie ALTER TABLE [Zarizeni]
    ADD CONSTRAINT [PK_Zarizeni]
        PRIMARY KEY CLUSTERED ([ZarizeniID] ASC)
;

use energie ALTER TABLE [Zaznamopouziti]
    ADD CONSTRAINT [PK_Zaznamopouziti]
        PRIMARY KEY CLUSTERED ([ZaznamopouzitiID] ASC)
;

use energie CREATE NONCLUSTERED INDEX [INDEX_Datumcas]
    ON [Zaznamopouziti] ([Datumcas] ASC)
;

use energie ALTER TABLE [Zaznamospotrebe]
    ADD CONSTRAINT [PK_Zaznamospotrebe]
        PRIMARY KEY CLUSTERED ([ZaznamospotrebeID] ASC)
;

use energie CREATE NONCLUSTERED INDEX [INDEX_Datumcas]
    ON [Zaznamospotrebe] ([Datumcas] ASC)
;

/* Create Foreign Key Constraints */

use energie ALTER TABLE [Hala] ADD CONSTRAINT [FK_Hala_Tovarna]
    FOREIGN KEY ([TovarnaID]) REFERENCES [Tovarna] ([TovarnaID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Seznamzamestnancusmeny] ADD CONSTRAINT [FK_Seznamzamestnancusmeny_Hala]
    FOREIGN KEY ([HalaID]) REFERENCES [Hala] ([HalaID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Seznamzamestnancusmeny] ADD CONSTRAINT [FK_Seznamzamestnancusmeny_Zamestnanec]
    FOREIGN KEY ([ZamestnanecID]) REFERENCES [Zamestnanec] ([ZamestnanecID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Seznamzamestnancusmeny] ADD CONSTRAINT [FK_Seznamzamestnancusmeny_Smena]
    FOREIGN KEY ([SmenaID]) REFERENCES [Smena] ([SmenaID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Tovarna] ADD CONSTRAINT [FK_Tovarna_Adresa]
    FOREIGN KEY ([AdresaID]) REFERENCES [Adresa] ([AdresaID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Zamestnanec] ADD CONSTRAINT [FK_Zamestnanec_Adresa]
    FOREIGN KEY ([AdresaID]) REFERENCES [Adresa] ([AdresaID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Zamestnanec] ADD CONSTRAINT [FK_Zamestnanec_Webovyucet]
    FOREIGN KEY ([WebovyucetID]) REFERENCES [Webovyucet] ([WebovyucetID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Zarizeni] ADD CONSTRAINT [FK_Zarizeni_Hala]
    FOREIGN KEY ([HalaID]) REFERENCES [Hala] ([HalaID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Zaznamopouziti] ADD CONSTRAINT [FK_Zaznamopouziti_Zamestnanec]
    FOREIGN KEY ([ZamestnanecID]) REFERENCES [Zamestnanec] ([ZamestnanecID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Zaznamopouziti] ADD CONSTRAINT [FK_Zaznamopouziti_Zarizeni]
    FOREIGN KEY ([ZarizeniID]) REFERENCES [Zarizeni] ([ZarizeniID]) ON DELETE No Action ON UPDATE No Action
;

use energie ALTER TABLE [Zaznamospotrebe] ADD CONSTRAINT [FK_Zaznamospotrebe_Zarizeni]
    FOREIGN KEY ([ZarizeniID]) REFERENCES [Zarizeni] ([ZarizeniID]) ON DELETE No Action ON UPDATE No Action
;

use energie CREATE LOGIN WebServer
    WITH PASSWORD = 'Nj4658g465huisca';
use energie create user Webserver from Login WebServer;
use energie alter role db_owner add member Webserver;

/*
create type [dbo].[ZaznamOPouziti] as table
(
    [Datumcas] smalldatetime NOT NULL,
    [ZaznamopouzitiID] int NOT NULL,
    [ZamestnanecID] int NOT NULL,
    [ZarizeniID] int NOT NULL
)
go
set implicit_transactions off
go

CREATE PROCEDURE updateSmenaInclusion @ZamestnanecIDtoCheck int, @SmenaIdToCheck int, @HalaIdToCheck int
AS
    if (@ZamestnanecIDtoCheck not in (SELECT T.ZamestnanecID
                                      from Seznamzamestnancusmeny T
                                      where T.HalaID=@HalaIdToCheck and T.SmenaID=@SmenaIdToCheck))

        Insert into Seznamzamestnancusmeny (HalaID, ZamestnanecID, SmenaID)
        values (@HalaIdToCheck, @ZamestnanecIDtoCheck, @SmenaIdToCheck)
go
CREATE PROCEDURE checkSmenaInclusion @inserted ZaznamOPouziti READONLY
AS
begin
    begin tran tr1
        BEGIN TRY ;

            insert into Seznamzamestnancusmeny (HalaID, ZamestnanecID, SmenaID)
            select Z.HalaID,I.ZamestnanecID,S.SmenaID from @inserted I
                                                inner join Smena S on I.Datumcas between S.Casod and S.Casdo
                                                inner join Zarizeni Z on Z.ZarizeniID=I.ZarizeniID;

            insert into Zaznamopouziti (Datumcas, ZamestnanecID, ZarizeniID)
            select I.Datumcas,I.ZamestnanecID,I.ZarizeniID from @inserted I
                                                inner join Smena S on I.Datumcas between S.Casod and S.Casdo
                                                inner join Zarizeni Z on Z.ZarizeniID=I.ZarizeniID;
            COMMIT TRAN tr1
        END TRY
        BEGIN CATCH
            SELECT ERROR_MESSAGE() AS ErrorMessage
        end catch
end
*/

use energie create procedure insertZamestnanecAdresa @jmeno varchar(40), @prijmeni varchar(40),@telefon char(12),
                                         @email varchar(40), @rodneCislo char(10), @psc char(10), @ulice varchar(20),
                                         @cislopopisne varchar(10)
    as
    begin
        begin transaction tr1
            BEGIN TRY
                INSERT INTO Adresa (Cislopopisne, Psc, Ulice)
                VALUES (@cislopopisne, @psc, @ulice)

                declare @id int = SCOPE_IDENTITY()

                INSERT INTO Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID, WebovyucetID)
                VALUES (@email, @jmeno,@prijmeni,@rodneCislo,@telefon,@id,null)
                commit transaction tr1

                select * from Zamestnanec where ZamestnanecID=SCOPE_IDENTITY()

            END TRY
            begin catch
                rollback transaction tr1
            end catch

    end

;

use energie CREATE TRIGGER newUse ON Zaznamopouziti
    instead of INSERT AS
    begin
        insert into Seznamzamestnancusmeny (HalaID, ZamestnanecID, SmenaID)
        select Z.HalaID,I.ZamestnanecID,S.SmenaID from inserted I
                                                           inner join Smena S on I.Datumcas between S.Casod and S.Casdo
                                                           inner join Zarizeni Z on Z.ZarizeniID=I.ZarizeniID

        insert into Zaznamopouziti (Datumcas, ZamestnanecID, ZarizeniID)
        select I.Datumcas,I.ZamestnanecID,I.ZarizeniID from inserted I
                                                                inner join Smena S on I.Datumcas between S.Casod and S.Casdo
                                                                inner join Zarizeni Z on Z.ZarizeniID=I.ZarizeniID
    end
        /*
        declare @insert ZaznamOPouziti
        insert into @insert (Datumcas, ZaznamopouzitiID, ZamestnanecID, ZarizeniID)
            select * from inserted
        execute checkSmenaInclusion @insert*/

/*

    DECLARE @Cas smalldatetime;
    DECLARE @Zamestnanec int;
    DECLARE @Zarizeni int;

    DECLARE insert_cursor CURSOR FOR select I.Datumcas,I.ZamestnanecID,I.ZarizeniID from inserted I inner join Smena S on I.Datumcas between S.Casod and S.Casdo

    OPEN insert_cursor

    FETCH NEXT FROM insert_cursor INTO @Cas,@Zamestnanec,@Zarizeni;
    While @@FETCH_STATUS = 0
        begin
            EXECUTE checkSmenaInclusion @Cas, @Zamestnanec, @Zarizeni
            FETCH NEXT FROM insert_cursor INTO @Cas, @Zamestnanec, @Zarizeni
        end
*/


;

use energie create VIEW spotrebaInfo
AS SELECT Zar.Oznaceni,
          Zar.Nazev,
          Spot.Spotreba,
          Hala.HalaID,
          Spot.Datumcas,
          Pouz.ZamestnanecID
   FROM Zaznamospotrebe Spot INNER JOIN Zarizeni Zar
                                    ON Zar.ZarizeniID=Spot.ZarizeniID
                             INNER JOIN Hala
                                    ON Zar.HalaID=Hala.HalaID
                            left outer JOIN Zaznamopouziti Pouz
                                    ON Zar.ZarizeniID=Pouz.ZarizeniID

    where Pouz.ZamestnanecID is null or Pouz.Datumcas = (select max(Zaznamopouziti.Datumcas) from Zaznamopouziti
                                                       WHERE Zaznamopouziti.Datumcas < Spot.Datumcas and
                                                             Zaznamopouziti.ZarizeniID = Zar.ZarizeniID)

;

/*SELECT SUM(spotreba) AS celkova_spotreba
FROM ZaznamOSpotrebe;
 go*/
use energie CREATE FUNCTION CelkovaCenaSpotreby(@id int)
    RETURNS float
AS
BEGIN
    DECLARE @CelkovaCena float
    SELECT @CelkovaCena = SUM(zaznamOSpotrebe.Spotreba * T.CenaZaKWh)
    FROM Zaznamospotrebe
             INNER JOIN Zarizeni Z on Zaznamospotrebe.ZarizeniID = Z.ZarizeniID
             INNER JOIN dbo.Hala H on Z.HalaID = H.HalaID
             INNER JOIN dbo.Tovarna T on T.TovarnaID = H.TovarnaID
    where T.TovarnaID = @id

    if @CelkovaCena IS NULL
        return 0
    RETURN @CelkovaCena
END;
