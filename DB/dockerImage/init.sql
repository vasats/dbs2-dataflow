create database energie
go
use energie
go

CREATE TABLE [Adresa]
(
    [Cislopopisne] varchar(10) NOT NULL,
    [Psc] char(5) NOT NULL,
    [Ulice] varchar(20) NULL,
    [AdresaID] int NOT NULL IDENTITY (1, 1)
)
GO

CREATE TABLE [Hala]
(
    [Oznaceni] char(10) NOT NULL,
    [HalaID] int NOT NULL IDENTITY (1, 1),
    [TovarnaID] int NOT NULL
)
GO

CREATE TABLE [Seznamzamestnancusmeny]
(
    [HalaID] int NOT NULL,
    [ZamestnanecID] int NOT NULL,
    [SmenaID] int NOT NULL
)
GO

CREATE TABLE [Smena]
(
    [Casdo] smalldatetime NULL,
    [Casod] smalldatetime NOT NULL,
    [SmenaID] int NOT NULL IDENTITY (1, 1)
)
GO

CREATE TABLE [Tovarna]
(
    [Cenazakwh] smallmoney NULL,
    [Foto] varchar(30) NULL,
    [Nazev] varchar(50) NOT NULL,
    [TovarnaID] int NOT NULL IDENTITY (1, 1),
    [AdresaID] int NOT NULL
)
GO

CREATE TABLE [Webovyucet]
(
    [Heslohash] varchar(64) NOT NULL,
    [Jmeno] varchar(40) NOT NULL,
    [Typuctu] varchar(10) NOT NULL,
    [WebovyucetID] int NOT NULL IDENTITY (1, 1)
)
GO

CREATE TABLE [Zamestnanec]
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
GO

CREATE TABLE [Zarizeni]
(
    [Oznaceni] varchar(10) NOT NULL,
    [Nazev] varchar(30) NULL,
    [ZarizeniID] int NOT NULL IDENTITY (1, 1),
    [HalaID] int NOT NULL
)
GO

CREATE TABLE [Zaznamopouziti]
(
    [Datumcas] smalldatetime NOT NULL,
    [ZaznamopouzitiID] int NOT NULL IDENTITY (1, 1),
    [ZamestnanecID] int NOT NULL,
    [ZarizeniID] int NOT NULL
)
GO

CREATE TABLE [Zaznamospotrebe]
(
    [Datumcas] smalldatetime NULL,
    [Spotreba] float NULL,
    [ZaznamospotrebeID] int NOT NULL IDENTITY (1, 1),
    [ZarizeniID] int NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [Adresa]
    ADD CONSTRAINT [PK_Adresa]
        PRIMARY KEY CLUSTERED ([AdresaID] ASC)
GO

ALTER TABLE [Hala]
    ADD CONSTRAINT [PK_Hala]
        PRIMARY KEY CLUSTERED ([HalaID] ASC)
GO

ALTER TABLE [Seznamzamestnancusmeny]
    ADD CONSTRAINT [PK_Seznamzamestnancusmeny]
        PRIMARY KEY CLUSTERED ([HalaID] ASC,[ZamestnanecID] ASC,[SmenaID] ASC)
GO

ALTER TABLE [Smena]
    ADD CONSTRAINT [PK_Smena]
        PRIMARY KEY CLUSTERED ([SmenaID] ASC)
GO

ALTER TABLE [Tovarna]
    ADD CONSTRAINT [PK_Tovarna]
        PRIMARY KEY CLUSTERED ([TovarnaID] ASC)
GO

ALTER TABLE [Webovyucet]
    ADD CONSTRAINT [PK_Webovyucet]
        PRIMARY KEY CLUSTERED ([WebovyucetID] ASC)
GO

ALTER TABLE [Zamestnanec]
    ADD CONSTRAINT [PK_Zamestnanec]
        PRIMARY KEY CLUSTERED ([ZamestnanecID] ASC)
GO

ALTER TABLE [Zarizeni]
    ADD CONSTRAINT [PK_Zarizeni]
        PRIMARY KEY CLUSTERED ([ZarizeniID] ASC)
GO

ALTER TABLE [Zaznamopouziti]
    ADD CONSTRAINT [PK_Zaznamopouziti]
        PRIMARY KEY CLUSTERED ([ZaznamopouzitiID] ASC)
GO

CREATE NONCLUSTERED INDEX [INDEX_Datumcas]
    ON [Zaznamopouziti] ([Datumcas] ASC)
GO

ALTER TABLE [Zaznamospotrebe]
    ADD CONSTRAINT [PK_Zaznamospotrebe]
        PRIMARY KEY CLUSTERED ([ZaznamospotrebeID] ASC)
GO

CREATE NONCLUSTERED INDEX [INDEX_Datumcas]
    ON [Zaznamospotrebe] ([Datumcas] ASC)
GO

/* Create Foreign Key Constraints */

ALTER TABLE [Hala] ADD CONSTRAINT [FK_Hala_Tovarna]
    FOREIGN KEY ([TovarnaID]) REFERENCES [Tovarna] ([TovarnaID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Seznamzamestnancusmeny] ADD CONSTRAINT [FK_Seznamzamestnancusmeny_Hala]
    FOREIGN KEY ([HalaID]) REFERENCES [Hala] ([HalaID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Seznamzamestnancusmeny] ADD CONSTRAINT [FK_Seznamzamestnancusmeny_Zamestnanec]
    FOREIGN KEY ([ZamestnanecID]) REFERENCES [Zamestnanec] ([ZamestnanecID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Seznamzamestnancusmeny] ADD CONSTRAINT [FK_Seznamzamestnancusmeny_Smena]
    FOREIGN KEY ([SmenaID]) REFERENCES [Smena] ([SmenaID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Tovarna] ADD CONSTRAINT [FK_Tovarna_Adresa]
    FOREIGN KEY ([AdresaID]) REFERENCES [Adresa] ([AdresaID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Zamestnanec] ADD CONSTRAINT [FK_Zamestnanec_Adresa]
    FOREIGN KEY ([AdresaID]) REFERENCES [Adresa] ([AdresaID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Zamestnanec] ADD CONSTRAINT [FK_Zamestnanec_Webovyucet]
    FOREIGN KEY ([WebovyucetID]) REFERENCES [Webovyucet] ([WebovyucetID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Zarizeni] ADD CONSTRAINT [FK_Zarizeni_Hala]
    FOREIGN KEY ([HalaID]) REFERENCES [Hala] ([HalaID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Zaznamopouziti] ADD CONSTRAINT [FK_Zaznamopouziti_Zamestnanec]
    FOREIGN KEY ([ZamestnanecID]) REFERENCES [Zamestnanec] ([ZamestnanecID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Zaznamopouziti] ADD CONSTRAINT [FK_Zaznamopouziti_Zarizeni]
    FOREIGN KEY ([ZarizeniID]) REFERENCES [Zarizeni] ([ZarizeniID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Zaznamospotrebe] ADD CONSTRAINT [FK_Zaznamospotrebe_Zarizeni]
    FOREIGN KEY ([ZarizeniID]) REFERENCES [Zarizeni] ([ZarizeniID]) ON DELETE No Action ON UPDATE No Action
GO

CREATE LOGIN WebServer
    WITH PASSWORD = 'Nj4658g465huisca';
create user Webserver from Login WebServer
alter role db_owner add member Webserver
go

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

go

CREATE TRIGGER newUse ON Zaznamopouziti
    instead of INSERT AS
    begin
        insert into Seznamzamestnancusmeny (HalaID, ZamestnanecID, SmenaID)
        select Z.HalaID,I.ZamestnanecID,S.SmenaID from inserted I
                                                           inner join Smena S on I.Datumcas between S.Casod and S.Casdo
                                                           inner join Zarizeni Z on Z.ZarizeniID=I.ZarizeniID;

        insert into Zaznamopouziti (Datumcas, ZamestnanecID, ZarizeniID)
        select I.Datumcas,I.ZamestnanecID,I.ZarizeniID from inserted I
                                                                inner join Smena S on I.Datumcas between S.Casod and S.Casdo
                                                                inner join Zarizeni Z on Z.ZarizeniID=I.ZarizeniID;

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
    end

go;

create VIEW spotrebaInfo
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

GO
/*Napsat funkci co bude scitat spotreby jednotlivych tovaren, hal, zarizeni a zaznamu o spotrebe a pronasobi to cenou/kWh a vrati celkovou cenu spotreby.*/
SELECT SUM(spotreba) AS celkova_spotreba
FROM ZaznamOSpotrebe;
 go
CREATE FUNCTION CelkovaCenaSpotreby(@id int)
    RETURNS float  -- Návratový datový typ je DECIMAL s přesností 18 číslic a 2 desetinnými místy
AS
BEGIN
    DECLARE @CelkovaCena float;  -- Deklarace proměnné pro uchování celkové ceny
    -- Výpočet celkové ceny spotřeby pomocí součtu spotřeby v jednotlivých záznamech o spotřebě a ceny za kWh
    --přepsat na zaznam o spotrebe
    SELECT @CelkovaCena = SUM(zaznamOSpotrebe.Spotreba * T.CenaZaKWh)
    FROM Zaznamospotrebe
             INNER JOIN Zarizeni Z on Zaznamospotrebe.ZarizeniID = Z.ZarizeniID
             INNER JOIN dbo.Hala H on Z.HalaID = H.HalaID
             INNER JOIN dbo.Tovarna T on T.TovarnaID = H.TovarnaID
    where T.TovarnaID = @id

    if @CelkovaCena IS NULL
        return 0
    -- Návrat celkové ceny spotřeby
    RETURN @CelkovaCena;
END;
go

insert into Smena (Casod, Casdo) values ('3/4/2024 5:04', '3/4/2024 9:14');
insert into Smena (Casod, Casdo) values ('3/13/2024 14:02', '3/13/2024 8:23');
insert into Smena (Casod, Casdo) values ('3/20/2024 19:02', '3/20/2024 2:17');
insert into Smena (Casod, Casdo) values ('3/17/2024 0:41', '3/17/2024 10:38');
insert into Smena (Casod, Casdo) values ('3/29/2024 0:57', '3/29/2024 11:46');
insert into Smena (Casod, Casdo) values ('3/19/2024 9:09', '3/19/2024 7:16');
insert into Smena (Casod, Casdo) values ('3/10/2024 0:40', '3/10/2024 4:40');
insert into Smena (Casod, Casdo) values ('3/11/2024 13:12', '3/11/2024 10:35');
insert into Smena (Casod, Casdo) values ('3/3/2024 19:32', '3/3/2024 12:55');
insert into Smena (Casod, Casdo) values ('3/5/2024 4:28', '3/5/2024 21:40');
insert into Smena (Casod, Casdo) values ('3/29/2024 11:15', '3/29/2024 21:59');
insert into Smena (Casod, Casdo) values ('3/25/2024 6:38', '3/25/2024 14:42');
insert into Smena (Casod, Casdo) values ('3/20/2024 23:07', '3/20/2024 21:33');
insert into Smena (Casod, Casdo) values ('3/28/2024 5:51', '3/28/2024 7:31');
insert into Smena (Casod, Casdo) values ('3/15/2024 0:46', '3/15/2024 21:43');
insert into Smena (Casod, Casdo) values ('3/1/2024 15:15', '3/1/2024 4:23');
insert into Smena (Casod, Casdo) values ('3/23/2024 4:11', '3/23/2024 20:48');
insert into Smena (Casod, Casdo) values ('3/30/2024 22:47', '3/30/2024 23:06');
insert into Smena (Casod, Casdo) values ('3/7/2024 12:11', '3/7/2024 4:34');
insert into Smena (Casod, Casdo) values ('3/8/2024 6:11', '3/8/2024 12:54');
insert into Smena (Casod, Casdo) values ('3/18/2024 1:47', '3/18/2024 14:42');
insert into Smena (Casod, Casdo) values ('3/25/2024 21:45', '3/25/2024 6:16');
insert into Smena (Casod, Casdo) values ('3/19/2024 4:20', '3/19/2024 2:03');
insert into Smena (Casod, Casdo) values ('3/12/2024 17:37', '3/12/2024 5:16');
insert into Smena (Casod, Casdo) values ('3/2/2024 12:29', '3/2/2024 2:06');
insert into Smena (Casod, Casdo) values ('3/6/2024 2:15', '3/6/2024 19:21');
insert into Smena (Casod, Casdo) values ('3/4/2024 2:28', '3/4/2024 14:09');
insert into Smena (Casod, Casdo) values ('3/29/2024 18:28', '3/29/2024 7:37');
insert into Smena (Casod, Casdo) values ('3/11/2024 10:30', '3/11/2024 0:23');
insert into Smena (Casod, Casdo) values ('3/30/2024 12:44', '3/30/2024 0:04');
insert into Smena (Casod, Casdo) values ('3/27/2024 17:14', '3/27/2024 8:55');
insert into Smena (Casod, Casdo) values ('3/2/2024 5:00', '3/2/2024 9:24');
insert into Smena (Casod, Casdo) values ('3/26/2024 21:01', '3/26/2024 21:47');
insert into Smena (Casod, Casdo) values ('3/6/2024 15:51', '3/6/2024 14:24');
insert into Smena (Casod, Casdo) values ('3/11/2024 8:11', '3/11/2024 5:37');
insert into Smena (Casod, Casdo) values ('3/24/2024 23:35', '3/24/2024 12:16');
insert into Smena (Casod, Casdo) values ('3/17/2024 10:11', '3/17/2024 7:01');
insert into Smena (Casod, Casdo) values ('3/3/2024 21:00', '3/3/2024 2:39');
insert into Smena (Casod, Casdo) values ('3/3/2024 11:44', '3/3/2024 2:55');
insert into Smena (Casod, Casdo) values ('3/29/2024 23:11', '3/29/2024 0:00');
insert into Smena (Casod, Casdo) values ('3/3/2024 19:56', '3/3/2024 16:34');
insert into Smena (Casod, Casdo) values ('3/26/2024 3:41', '3/26/2024 3:15');
insert into Smena (Casod, Casdo) values ('3/26/2024 22:34', '3/26/2024 14:35');
insert into Smena (Casod, Casdo) values ('3/14/2024 10:26', '3/14/2024 17:00');
insert into Smena (Casod, Casdo) values ('3/13/2024 10:28', '3/13/2024 9:52');
insert into Smena (Casod, Casdo) values ('3/6/2024 21:55', '3/6/2024 11:27');
insert into Smena (Casod, Casdo) values ('3/15/2024 14:17', '3/15/2024 21:14');
insert into Smena (Casod, Casdo) values ('3/28/2024 20:45', '3/28/2024 9:45');
insert into Smena (Casod, Casdo) values ('3/24/2024 19:02', '3/24/2024 6:25');
insert into Smena (Casod, Casdo) values ('3/1/2024 3:36', '3/1/2024 12:52');
go

insert into Adresa (Cislopopisne, Psc, Ulice) values (29, 26037, 'Fairview');
insert into Adresa (Cislopopisne, Psc, Ulice) values (428, 31306, 'Springs');
insert into Adresa (Cislopopisne, Psc, Ulice) values (321, 72922, 'Bowman');
insert into Adresa (Cislopopisne, Psc, Ulice) values (75, 52234, 'Spenser');
insert into Adresa (Cislopopisne, Psc, Ulice) values (409, 31257, 'Columbus');
insert into Adresa (Cislopopisne, Psc, Ulice) values (236, 82630, 'International');
insert into Adresa (Cislopopisne, Psc, Ulice) values (331, 28125, 'Cherokee');
insert into Adresa (Cislopopisne, Psc, Ulice) values (187, 65905, 'New Castle');
insert into Adresa (Cislopopisne, Psc, Ulice) values (472, 75490, 'Monica');
insert into Adresa (Cislopopisne, Psc, Ulice) values (29, 91486, 'Del Sol');
insert into Adresa (Cislopopisne, Psc, Ulice) values (233, 66721, 'Dapin');
insert into Adresa (Cislopopisne, Psc, Ulice) values (52, 96318, 'Thompson');
insert into Adresa (Cislopopisne, Psc, Ulice) values (45, 74781, 'Westridge');
insert into Adresa (Cislopopisne, Psc, Ulice) values (199, 39268, 'Fuller');
insert into Adresa (Cislopopisne, Psc, Ulice) values (211, 37060, 'Clemons');
insert into Adresa (Cislopopisne, Psc, Ulice) values (229, 64431, 'North');
insert into Adresa (Cislopopisne, Psc, Ulice) values (70, 85888, 'Lyons');
insert into Adresa (Cislopopisne, Psc, Ulice) values (256, 20573, 'Erie');
insert into Adresa (Cislopopisne, Psc, Ulice) values (41, 65524, 'Ridgeview');
insert into Adresa (Cislopopisne, Psc, Ulice) values (53, 35519, 'Pawling');
insert into Adresa (Cislopopisne, Psc, Ulice) values (329, 90652, 'Hansons');
insert into Adresa (Cislopopisne, Psc, Ulice) values (103, 48949, 'Basil');
insert into Adresa (Cislopopisne, Psc, Ulice) values (59, 22276, 'Summerview');
insert into Adresa (Cislopopisne, Psc, Ulice) values (211, 21093, 'Tony');
insert into Adresa (Cislopopisne, Psc, Ulice) values (144, 44354, 'Mallory');
insert into Adresa (Cislopopisne, Psc, Ulice) values (193, 22085, 'Hoepker');
insert into Adresa (Cislopopisne, Psc, Ulice) values (32, 83790, 'Old Shore');
insert into Adresa (Cislopopisne, Psc, Ulice) values (14, 53842, 'Erie');
insert into Adresa (Cislopopisne, Psc, Ulice) values (384, 80200, 'Swallow');
insert into Adresa (Cislopopisne, Psc, Ulice) values (102, 53137, 'West');
insert into Adresa (Cislopopisne, Psc, Ulice) values (289, 82421, 'Dwight');
insert into Adresa (Cislopopisne, Psc, Ulice) values (19, 33466, 'American Ash');
insert into Adresa (Cislopopisne, Psc, Ulice) values (90, 96402, 'Becker');
insert into Adresa (Cislopopisne, Psc, Ulice) values (440, 91366, 'Butternut');
insert into Adresa (Cislopopisne, Psc, Ulice) values (478, 16309, 'Florence');
insert into Adresa (Cislopopisne, Psc, Ulice) values (110, 59753, 'Division');
insert into Adresa (Cislopopisne, Psc, Ulice) values (79, 39635, 'Michigan');
insert into Adresa (Cislopopisne, Psc, Ulice) values (129, 22822, 'Novick');
insert into Adresa (Cislopopisne, Psc, Ulice) values (373, 66691, 'Corben');
insert into Adresa (Cislopopisne, Psc, Ulice) values (111, 89683, 'Summit');
insert into Adresa (Cislopopisne, Psc, Ulice) values (227, 77972, 'Manley');
insert into Adresa (Cislopopisne, Psc, Ulice) values (271, 15374, 'Fremont');
insert into Adresa (Cislopopisne, Psc, Ulice) values (135, 69606, 'Trailsway');
insert into Adresa (Cislopopisne, Psc, Ulice) values (133, 93737, 'Logan');
insert into Adresa (Cislopopisne, Psc, Ulice) values (136, 91035, 'Bultman');
insert into Adresa (Cislopopisne, Psc, Ulice) values (391, 26305, 'Dorton');
insert into Adresa (Cislopopisne, Psc, Ulice) values (364, 81060, 'Carpenter');
insert into Adresa (Cislopopisne, Psc, Ulice) values (166, 17370, 'Corry');
insert into Adresa (Cislopopisne, Psc, Ulice) values (264, 33900, 'Schlimgen');
insert into Adresa (Cislopopisne, Psc, Ulice) values (472, 20605, 'Russell');
insert into Adresa (Cislopopisne, Psc, Ulice) values (265, 87281, 'Porter');
insert into Adresa (Cislopopisne, Psc, Ulice) values (180, 57619, 'Dunning');
insert into Adresa (Cislopopisne, Psc, Ulice) values (217, 73072, 'Sutherland');
insert into Adresa (Cislopopisne, Psc, Ulice) values (376, 60929, 'Algoma');
insert into Adresa (Cislopopisne, Psc, Ulice) values (431, 47517, 'Schmedeman');
insert into Adresa (Cislopopisne, Psc, Ulice) values (409, 44972, 'New Castle');
insert into Adresa (Cislopopisne, Psc, Ulice) values (428, 93259, 'Toban');
insert into Adresa (Cislopopisne, Psc, Ulice) values (184, 72483, 'Susan');
insert into Adresa (Cislopopisne, Psc, Ulice) values (150, 70622, 'Onsgard');
insert into Adresa (Cislopopisne, Psc, Ulice) values (128, 48685, 'Truax');
insert into Adresa (Cislopopisne, Psc, Ulice) values (151, 61287, 'Chive');
insert into Adresa (Cislopopisne, Psc, Ulice) values (480, 31826, 'Monterey');
insert into Adresa (Cislopopisne, Psc, Ulice) values (49, 18735, 'Delladonna');
insert into Adresa (Cislopopisne, Psc, Ulice) values (91, 19228, 'Pond');
insert into Adresa (Cislopopisne, Psc, Ulice) values (256, 84661, 'Logan');
insert into Adresa (Cislopopisne, Psc, Ulice) values (346, 59563, 'Nelson');
insert into Adresa (Cislopopisne, Psc, Ulice) values (393, 48299, 'Blackbird');
insert into Adresa (Cislopopisne, Psc, Ulice) values (78, 89210, 'Redwing');
insert into Adresa (Cislopopisne, Psc, Ulice) values (219, 92192, 'Dapin');
insert into Adresa (Cislopopisne, Psc, Ulice) values (218, 70079, 'Ramsey');
insert into Adresa (Cislopopisne, Psc, Ulice) values (94, 43668, 'Beilfuss');
insert into Adresa (Cislopopisne, Psc, Ulice) values (299, 94177, 'Gerald');
insert into Adresa (Cislopopisne, Psc, Ulice) values (358, 32642, 'Morrow');
insert into Adresa (Cislopopisne, Psc, Ulice) values (24, 43613, 'Trailsway');
insert into Adresa (Cislopopisne, Psc, Ulice) values (269, 57499, 'Eagle Crest');
insert into Adresa (Cislopopisne, Psc, Ulice) values (161, 19866, 'Pierstorff');
insert into Adresa (Cislopopisne, Psc, Ulice) values (343, 66113, 'Mayfield');
insert into Adresa (Cislopopisne, Psc, Ulice) values (215, 95725, '6th');
insert into Adresa (Cislopopisne, Psc, Ulice) values (356, 62581, 'Tennyson');
insert into Adresa (Cislopopisne, Psc, Ulice) values (456, 23552, 'Anzinger');
insert into Adresa (Cislopopisne, Psc, Ulice) values (189, 83996, 'New Castle');
insert into Adresa (Cislopopisne, Psc, Ulice) values (343, 19499, 'Becker');
insert into Adresa (Cislopopisne, Psc, Ulice) values (307, 20870, 'Scofield');
insert into Adresa (Cislopopisne, Psc, Ulice) values (398, 67055, 'Macpherson');
insert into Adresa (Cislopopisne, Psc, Ulice) values (480, 72053, 'Elka');
insert into Adresa (Cislopopisne, Psc, Ulice) values (181, 74946, 'Quincy');
insert into Adresa (Cislopopisne, Psc, Ulice) values (175, 53240, 'Bellgrove');
insert into Adresa (Cislopopisne, Psc, Ulice) values (12, 14858, 'Chive');
insert into Adresa (Cislopopisne, Psc, Ulice) values (47, 11034, 'Monica');
insert into Adresa (Cislopopisne, Psc, Ulice) values (271, 67692, 'Clove');
insert into Adresa (Cislopopisne, Psc, Ulice) values (377, 27161, 'Cordelia');
insert into Adresa (Cislopopisne, Psc, Ulice) values (419, 72223, 'Arrowood');
insert into Adresa (Cislopopisne, Psc, Ulice) values (283, 14866, 'Burrows');
insert into Adresa (Cislopopisne, Psc, Ulice) values (402, 13248, 'Hovde');
insert into Adresa (Cislopopisne, Psc, Ulice) values (168, 31628, 'John Wall');
insert into Adresa (Cislopopisne, Psc, Ulice) values (5, 32908, 'Hayes');
insert into Adresa (Cislopopisne, Psc, Ulice) values (2, 44052, 'Bobwhite');
insert into Adresa (Cislopopisne, Psc, Ulice) values (45, 12109, 'Mendota');
insert into Adresa (Cislopopisne, Psc, Ulice) values (208, 87553, 'Parkside');
insert into Adresa (Cislopopisne, Psc, Ulice) values (432, 16228, 'Merchant');
insert into Adresa (Cislopopisne, Psc, Ulice) values (445, 58513, 'Sachtjen');
insert into Adresa (Cislopopisne, Psc, Ulice) values (153, 34326, 'Loftsgordon');
insert into Adresa (Cislopopisne, Psc, Ulice) values (435, 36245, 'Everett');
insert into Adresa (Cislopopisne, Psc, Ulice) values (266, 36167, 'Maple');
insert into Adresa (Cislopopisne, Psc, Ulice) values (21, 93047, 'Morrow');


go
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$qfSuOcDcSuh1IwxmPZmmdeaSJDySEokS/h4CiwsmWRsXefZfmfoR2', 'mmansfield0', 'admin');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$Lz/mm5WCFOmGOjLyBzsh9eLswz3vhQzChvAIFTzCde749T8HIeQMW', 'acockshtt1', 'admin');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$KMb7O/hoasfUwFwVr9JJDuotKgo.5W.cjEh6zG5.VXNuNE6pJiIUq', 'crealff2', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$bXsbfrTFmRrM/IXU3PO2q.14tEXbu5q1pT9SLFECsTVA6j3pnoiiy', 'afernyhough3', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$odFPmI6b3AYG9YwYqUGzVOxux/8x4m5GV.12ELD.9NgxwMvI8zeLi', 'smacandie4', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$S6q7bRABIU8l/tjHVdlww.cl.NBl5E7LRP7Br9dVKAnPswAVaFNgK', 'dportis5', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$jiw1wObPgH.YF8YDk8UP5e57G//B9x1mQuq6/n4kjTNJk90fTskJy', 'klockhurst6', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$tY8oUbn5HQnd3aGPPKCkpujwuO0HOWTSyPPd.JqXGN.aj9UUiV9.q', 'jbrunelleschi7', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$K5mBeljUxRhsXkXfzEEJxe0Cj5H.zHdZr5GtTfewiOmEUNoWcmxsm', 'vpleasaunce8', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$clsCyW845YQQtx2rDD/kQ.Ktfg3lUP9zpZMR.WuT46Iu7d7aPlG4y', 'mishchenko9', 'user');
go

insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('djillions0@paypal.com', 'Eugénie', 'Jillions', 8335247063, '385 590 652', 1, 1);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('eaxten1@skype.com', 'Ruì', 'Axten', 9691521172, '100 016 090', 2, 2);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('boshiels2@hibu.com', 'Märta', 'O''Shiels', 2202512815, '450 911 592', 3, 3);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('gcoale3@tinypic.com', 'Táng', 'Coale', 2880439739, '809 705 031', 4, 4);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('dtissington4@netlog.com', 'Marie-thérèse', 'Tissington', 1808408571, '079 810 320', 5, 5);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('slehr5@weebly.com', 'Réjane', 'Lehr', 3806833833, '113 232 423', 6, 6);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('ftyrer6@people.com.cn', 'Ruì', 'Tyrer', 3111400620, '887 750 372', 7, 7);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('dtremayle7@wisc.edu', 'Loïs', 'Tremayle', 5745461322, '799 429 795', 8, 8);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('fpound8@netlog.com', 'Séverine', 'Pound', 4633058610, '783 848 753', 9, 9);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID, AdresaID) values ('dfussie9@harvard.edu', 'Marie-thérèse', 'Fussie', 8713559595, '560 527 792', 10, 10);

insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('rnancekivell0@disqus.com', 'Eliès', 'Nancekivell', 8622654105, '262 965 172', 11);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('agrievson1@google.fr', 'Lyséa', 'Grievson', 4770720411, '884 871 059', 12);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('bmcdoual2@de.vu', 'Célia', 'McDoual', 1567105586, '760 070 735', 13);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('aoswick3@eepurl.com', 'Maëlla', 'Oswick', 8393706044, '273 855 576', 14);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('rklos4@geocities.jp', 'Maëlyss', 'Klos', 6754179007, '221 029 452', 15);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('jskyner5@wunderground.com', 'Marie-françoise', 'Skyner', 1931969419, '088 139 425', 16);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('dduckels6@sciencedaily.com', 'Eléonore', 'Duckels', 6484345734, '275 793 519', 17);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('mmcasgill7@hp.com', 'Lén', 'McAsgill', 2764558887, '942 723 510', 18);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('chairsine8@angelfire.com', 'Célia', 'Hairsine', 4157560246, '699 799 894', 19);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('mshinn9@chron.com', 'Josée', 'Shinn', 2686207842, '381 804 910', 20);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('aclacsona@blinklist.com', 'Mélinda', 'Clacson', 3945636351, '454 479 184', 21);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('wsethb@unc.edu', 'Görel', 'Seth', 3278086747, '069 696 382', 22);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('avalancec@php.net', 'Nuó', 'Valance', 4390145600, '689 697 959', 23);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('cbonevantd@stanford.edu', 'André', 'Bonevant', 2323891244, '374 760 095', 24);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('bculpe@chicagotribune.com', 'Frédérique', 'Culp', 1457710452, '847 331 576', 25);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('nmacmoyerf@scientificamerican.com', 'Maëlys', 'MacMoyer', 3414186827, '209 596 727', 26);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('afenelowg@amazon.com', 'Océanne', 'Fenelow', 3725884412, '175 940 657', 27);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('mmcginnyh@tripadvisor.com', 'Björn', 'McGinny', 7496691821, '374 686 416', 28);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('rchanteri@a8.net', 'Léandre', 'Chanter', 8705097525, '093 990 655', 29);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('jhirsthousej@telegraph.co.uk', 'Dù', 'Hirsthouse', 3858881802, '136 761 247', 30);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('jsushamsk@vinaora.com', 'Andrée', 'Sushams', 2949641122, '484 308 990', 31);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('ajansenl@hugedomains.com', 'Célia', 'Jansen', 7583817124, '869 153 604', 32);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('wcrackerm@intel.com', 'Alizée', 'Cracker', 1867733640, '633 995 553', 33);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('jachromovn@boston.com', 'Maëlyss', 'Achromov', 1517941110, '523 624 448', 34);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('lantognettio@netscape.com', 'Béatrice', 'Antognetti', 9905324704, '474 579 213', 35);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('twadsworthp@hud.gov', 'Åslög', 'Wadsworth', 7355845411, '828 862 989', 36);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('kcaressq@boston.com', 'Géraldine', 'Caress', 8569746335, '034 306 026', 37);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('fstaleyr@hud.gov', 'Mylène', 'Staley', 2584942626, '100 797 220', 38);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('jcasonis@paginegialle.it', 'Vénus', 'Casoni', 7803912546, '950 279 518', 39);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('cbringloet@scientificamerican.com', 'Marie-ève', 'Bringloe', 3716155553, '008 383 036', 40);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('vlambinu@prlog.org', 'Marie-noël', 'Lambin', 1162817387, '398 851 147', 41);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('dpurringtonv@parallels.com', 'Nuó', 'Purrington', 2278711884, '280 160 051', 42);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('cbeckittw@nba.com', 'Zoé', 'Beckitt', 5089406877, '986 398 181', 43);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('adibdalex@reverbnation.com', 'Méng', 'Dibdale', 2444115904, '589 516 578', 44);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('vsaintsburyy@adobe.com', 'Judicaël', 'Saintsbury', 8048502998, '083 922 937', 45);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('econrartz@nih.gov', 'Chloé', 'Conrart', 5493771280, '325 842 012', 46);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('vdoerren10@about.com', 'Béatrice', 'Doerren', 1030770454, '783 668 637', 47);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('wbill11@slashdot.org', 'Maïwenn', 'Bill', 6437549434, '014 068 504', 48);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('tsokale12@hugedomains.com', 'Néhémie', 'Sokale', 3880413605, '650 844 029', 49);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('dimmings13@hhs.gov', 'Gaétane', 'Immings', 8812906541, '456 579 193', 50);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('rgosnold14@narod.ru', 'Audréanne', 'Gosnold', 2597379735, '600 227 978', 51);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('jbushaway15@github.com', 'Maëly', 'Bushaway', 6111555478, '837 589 778', 52);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('asynnott16@mayoclinic.com', 'Yè', 'Synnott', 7603472255, '815 504 624', 53);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('gkemshell17@apache.org', 'Adélaïde', 'Kemshell', 3108229136, '480 792 722', 54);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('nphebee18@walmart.com', 'Salomé', 'Phebee', 4438298174, '269 408 977', 55);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('tgrumbridge19@ebay.com', 'Lyséa', 'Grumbridge', 2506934747, '790 362 421', 56);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('ifoxley1a@utexas.edu', 'Pélagie', 'Foxley', 8719184704, '792 462 610', 57);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('wbartlet1b@house.gov', 'Åke', 'Bartlet', 1782657372, '668 126 392', 58);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('ipilgram1c@ocn.ne.jp', 'Maéna', 'Pilgram', 9314615849, '549 070 068', 59);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('akynforth1d@joomla.org', 'Nadège', 'Kynforth', 7825331811, '638 267 739', 60);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('awraith1e@xrea.com', 'Yè', 'Wraith', 9825159915, '242 973 453', 61);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('pbalharry1f@newyorker.com', 'Léane', 'Balharry', 5489766884, '618 624 921', 62);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('spea1g@hostgator.com', 'Wá', 'Pea', 6693813658, '627 457 598', 63);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('kruos1h@blogspot.com', 'Styrbjörn', 'Ruos', 2890809140, '843 224 525', 64);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('ocrosse1i@sakura.ne.jp', 'Cécile', 'Crosse', 7316955093, '228 485 276', 65);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('shawksby1j@blogtalkradio.com', 'Yóu', 'Hawksby', 9586673960, '640 831 116', 66);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('fdmtrovic1k@guardian.co.uk', 'Anaé', 'Dmtrovic', 6684845252, '174 750 129', 67);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('tboyall1l@bigcartel.com', 'Dorothée', 'Boyall', 7597687721, '571 572 863', 68);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('pfleeman1m@squarespace.com', 'Måns', 'Fleeman', 1434940719, '723 270 255', 69);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('iblewett1n@yandex.ru', 'Dafnée', 'Blewett', 6232855243, '722 662 594', 70);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('llumbers1o@senate.gov', 'Maëlys', 'Lumbers', 7177712871, '701 970 066', 71);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('cwaddell1p@bizjournals.com', 'Méng', 'Waddell', 5928776987, '616 859 303', 72);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('agreenman1q@ovh.net', 'Esbjörn', 'Greenman', 1788909615, '834 313 151', 73);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('cbyng1r@google.ru', 'Lauréna', 'Byng', 1469656172, '639 150 671', 74);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('tcrates1s@si.edu', 'Kévina', 'Crates', 5953407689, '834 747 134', 75);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('rweildish1t@youtube.com', 'Léonie', 'Weildish', 1807045861, '059 348 493', 76);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('lwiggett1u@amazon.de', 'Gösta', 'Wiggett', 5642814621, '544 954 394', 77);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('sdinwoodie1v@friendfeed.com', 'Rachèle', 'Dinwoodie', 2569799262, '787 898 863', 78);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('tlaverack1w@google.com.hk', 'Loïc', 'Laverack', 3740458847, '846 513 142', 79);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('llaxe1x@jiathis.com', 'Maëlys', 'Laxe', 6687189016, '002 700 083', 80);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('kcyson1y@symantec.com', 'Stévina', 'Cyson', 5383131208, '562 344 241', 81);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('ndalli1z@cloudflare.com', 'Desirée', 'Dalli', 7858499934, '767 087 021', 82);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('kratchford20@dagondesign.com', 'Anaël', 'Ratchford', 6841726278, '283 616 876', 83);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('dabbys21@51.la', 'Méthode', 'Abbys', 6944692029, '070 068 438', 84);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('rkiddey22@plala.or.jp', 'Mélina', 'Kiddey', 2692675088, '602 538 806', 85);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('gmossdale23@nature.com', 'Léandre', 'Mossdale', 9491509262, '529 820 268', 86);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('rchapell24@msu.edu', 'Yóu', 'Chapell', 7168141090, '416 670 141', 87);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('kboerderman25@alibaba.com', 'Marie-noël', 'Boerderman', 9760251740, '496 124 623', 88);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('gwaddington26@twitter.com', 'Maïwenn', 'Waddington', 1928535582, '064 906 950', 89);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('septon27@seattletimes.com', 'Bérénice', 'Epton', 1078480550, '428 230 203', 90);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('mstandishbrooks28@pcworld.com', 'Méng', 'Standish-Brooks', 9207726897, '394 547 430', 91);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('mhalladey29@fastcompany.com', 'Nadège', 'Halladey', 1644474379, '206 273 168', 92);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('gbewshea2a@smugmug.com', 'Maïté', 'Bewshea', 7201290620, '653 054 402', 93);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('tduggan2b@dailymotion.com', 'Pénélope', 'Duggan', 4717741614, '580 068 765', 94);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('cbackler2c@shinystat.com', 'Åke', 'Backler', 3961979997, '947 460 762', 95);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('bvarrow2d@vkontakte.ru', 'Pål', 'Varrow', 7032745626, '923 474 204', 96);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('nstrachan2e@ca.gov', 'Bérénice', 'Strachan', 3770505549, '099 310 952', 97);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('nharold2f@icq.com', 'Annotée', 'Harold', 4374806293, '855 256 019', 98);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('estainton2g@hc360.com', 'Michèle', 'Stainton', 3302838363, '466 154 912', 99);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, AdresaID) values ('gclurow2h@virginia.edu', 'Maïlis', 'Clurow', 8583229533, '105 040 232', 100);
go

insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$7.05', 'pexels-pixabay-247763.jpg', 'Panda',101);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$9.33', 'pexels-pixabay-220793.jpg','Panda 2', 102);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$9.04', 'pexels-pixabay-269077.jpg','Har', 103);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$3.47', 'pexels-hikaique-65438.jpg','Pod', 104);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$3.73', 'pexels-scottwebb-532568.jpg','Ollo', 105);
go
insert into Hala (Oznaceni, TovarnaID) values ('EMX', '4');
insert into Hala (Oznaceni, TovarnaID) values ('WAY', '3');
insert into Hala (Oznaceni, TovarnaID) values ('JOQ', '5');
insert into Hala (Oznaceni, TovarnaID) values ('TAM', '1');
insert into Hala (Oznaceni, TovarnaID) values ('CCK', '1');
insert into Hala (Oznaceni, TovarnaID) values ('MLN', '5');
insert into Hala (Oznaceni, TovarnaID) values ('MWL', '1');
insert into Hala (Oznaceni, TovarnaID) values ('WKD', '4');
insert into Hala (Oznaceni, TovarnaID) values ('RJG', '3');
insert into Hala (Oznaceni, TovarnaID) values ('QDP', '3');
insert into Hala (Oznaceni, TovarnaID) values ('UQZ', '3');
insert into Hala (Oznaceni, TovarnaID) values ('FYA', '2');
insert into Hala (Oznaceni, TovarnaID) values ('GBC', '2');
insert into Hala (Oznaceni, TovarnaID) values ('HIE', '5');
insert into Hala (Oznaceni, TovarnaID) values ('WVI', '1');
insert into Hala (Oznaceni, TovarnaID) values ('FIN', '5');
insert into Hala (Oznaceni, TovarnaID) values ('QCG', '5');
insert into Hala (Oznaceni, TovarnaID) values ('MDZ', '4');
insert into Hala (Oznaceni, TovarnaID) values ('DZL', '4');
insert into Hala (Oznaceni, TovarnaID) values ('TKP', '1');
insert into Hala (Oznaceni, TovarnaID) values ('XWL', '5');
insert into Hala (Oznaceni, TovarnaID) values ('ZAD', '2');
insert into Hala (Oznaceni, TovarnaID) values ('ZOA', '5');
insert into Hala (Oznaceni, TovarnaID) values ('TGV', '5');
insert into Hala (Oznaceni, TovarnaID) values ('VAJ', '1');
go
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('pNT-97', 'Scraper', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('nvR-6373', 'Grader', 15);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('KgjP-528', 'Grader', 14);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('GlTx-2479', 'Excavator', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Idiu-97', 'Crawler', 8);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('WlGj-131', 'Trencher', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('sGb-885', 'Skid-Steer', 7);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('JPS-05', 'Skid-Steer', 5);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('mrCm-3848', 'Excavator', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('gEn-85', 'Crawler', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('qYYN-2692', 'Bulldozer', 5);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('zEZW-47', 'Skid-Steer', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('owe-585', 'Dragline', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('YlRh-766', 'Excavator', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('bSt-90', 'Crawler', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('clt-7477', 'Bulldozer', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('bDgr-2388', 'Excavator', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Sib-518', 'Bulldozer', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('XWpa-200', 'Scraper', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Sokm-64', 'Compactor', 18);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('zHF-7477', 'Grader', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('sGdG-5967', 'Scraper', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('tzZH-377', 'Compactor', 23);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('nLVI-5914', 'Excavator', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('nEe-00', 'Grader', 15);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('cdE-074', 'Excavator', 6);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('RPMe-8952', 'Bulldozer', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('bIU-446', 'Scraper', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('XWv-92', 'Scraper', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Zvd-3050', 'Dragline', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('LQuS-42', 'Scraper', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('KPPW-19', 'Trencher', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('gFX-8707', 'Backhoe', 3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ABIT-6870', 'Compactor', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Thea-3944', 'Skid-Steer', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('txP-623', 'Dragline', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('MWcw-55', 'Crawler', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('lPuQ-8370', 'Scraper', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Obbw-45', 'Crawler', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Mvlj-093', 'Trencher', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('FgLH-950', 'Scraper', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ggJC-489', 'Skid-Steer', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('WHF-430', 'Dragline', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Fjv-01', 'Dump Truck', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('mZhk-01', 'Grader', 6);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('QGeI-877', 'Scraper', 23);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('hZTh-883', 'Excavator', 7);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('XHOF-3381', 'Crawler', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('jgtF-65', 'Compactor', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('SFb-721', 'Compactor', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('XIIP-6482', 'Backhoe', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('TYy-784', 'Crawler', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('xyM-0931', 'Trencher', 8);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('SmN-569', 'Trencher', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('OKP-9160', 'Dragline', 5);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('phO-87', 'Compactor', 14);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('kkNM-09', 'Grader', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('fsM-21', 'Dragline', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('aHLi-16', 'Bulldozer', 23);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Yio-85', 'Backhoe', 11);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('bUw-203', 'Bulldozer', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('dWB-225', 'Scraper', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('hOW-85', 'Compactor', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('BPW-04', 'Crawler', 18);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('raFT-336', 'Dump Truck', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('KfuJ-9476', 'Compactor', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('PTS-69', 'Scraper', 11);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Baje-895', 'Dragline', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('fzO-13', 'Excavator', 5);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Jip-58', 'Scraper', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('cZTM-35', 'Bulldozer', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('IWXd-55', 'Bulldozer', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('GQX-1664', 'Backhoe', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('aAs-349', 'Crawler', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('cRfS-807', 'Dragline', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('KFI-5681', 'Scraper', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('cdpo-40', 'Trencher', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('nfs-3119', 'Bulldozer', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Bqj-211', 'Excavator', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Wxi-1696', 'Bulldozer', 15);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('pip-1129', 'Crawler', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('BKNj-170', 'Bulldozer', 8);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('wrIm-556', 'Excavator', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ATs-59', 'Bulldozer', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('PLFn-319', 'Bulldozer', 11);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('DxFu-92', 'Crawler', 11);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('AZt-6122', 'Crawler', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('XYB-15', 'Compactor', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('jpC-90', 'Compactor', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('JQWS-05', 'Backhoe', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('gBcN-2785', 'Dump Truck', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('rSM-50', 'Dump Truck', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('SNFq-237', 'Grader', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('GHC-9316', 'Dragline', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('zpC-76', 'Scraper', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('tOxH-78', 'Excavator', 3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('RRK-1150', 'Skid-Steer', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('roK-262', 'Grader', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('zCnN-94', 'Backhoe', 7);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('FdXU-30', 'Bulldozer', 14);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('IdPC-201', 'Bulldozer', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('rXts-63', 'Compactor', 3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('yyE-993', 'Backhoe', 6);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('gtwR-7732', 'Crawler', 15);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('NqcW-070', 'Scraper', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('bjo-231', 'Dump Truck', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('odR-86', 'Grader', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('sXN-069', 'Compactor', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('VnmZ-5261', 'Crawler', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('xoPo-3616', 'Dump Truck', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('foI-41', 'Scraper', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('AFG-527', 'Excavator', 5);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('WUwL-5362', 'Dragline', 25);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('bZB-777', 'Skid-Steer', 14);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('SDw-645', 'Bulldozer', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('sudq-7675', 'Excavator', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('gfOe-0900', 'Bulldozer', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('SVuk-436', 'Compactor', 7);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('nRy-3922', 'Skid-Steer', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('zWiF-541', 'Dump Truck', 11);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Jspk-87', 'Bulldozer', 5);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('PGW-850', 'Excavator', 18);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('xuLz-8179', 'Skid-Steer', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('hAy-8709', 'Dragline', 6);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('qXU-33', 'Bulldozer', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('McPs-6747', 'Scraper', 14);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('glEH-70', 'Grader', 23);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('lMn-39', 'Dump Truck', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('vIk-46', 'Backhoe', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('nhjz-12', 'Skid-Steer', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('soC-55', 'Excavator', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('NXK-860', 'Compactor', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('mhn-9448', 'Bulldozer', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Venj-34', 'Bulldozer', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('RhM-737', 'Excavator', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('mihG-5925', 'Dragline', 5);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Frte-4728', 'Skid-Steer', 25);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Wef-626', 'Dragline', 6);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('NlGE-63', 'Excavator', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('UGR-40', 'Grader', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('cjg-491', 'Excavator', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('MFin-4205', 'Grader', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('nnms-22', 'Backhoe', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('zYZz-6180', 'Backhoe', 3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('GrSY-401', 'Dragline', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ueii-1443', 'Dragline', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('oTod-57', 'Skid-Steer', 6);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('HtG-559', 'Trencher', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('zMvI-92', 'Scraper', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('tOF-631', 'Trencher', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('EpWS-884', 'Dump Truck', 25);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('qaZY-1610', 'Bulldozer', 6);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('YUcz-0867', 'Compactor', 25);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('GjGh-46', 'Dragline', 15);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('GvU-6296', 'Grader', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('gJR-21', 'Skid-Steer', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('REeb-5246', 'Grader', 2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('QIgF-856', 'Trencher', 23);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('dRT-75', 'Bulldozer', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('GQg-6916', 'Dump Truck', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('lqV-47', 'Trencher', 15);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('vPc-45', 'Excavator', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('cfL-87', 'Skid-Steer', 23);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('KSP-5872', 'Compactor', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('JsUo-57', 'Scraper', 14);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('LHfq-03', 'Trencher', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('wIU-567', 'Compactor', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Tsr-9626', 'Backhoe', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Nrk-422', 'Compactor', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('FTln-655', 'Compactor', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Ddo-53', 'Backhoe', 3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('rCOo-92', 'Crawler', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('YvjD-8679', 'Bulldozer', 15);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('OTSw-051', 'Trencher', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ekeN-12', 'Dump Truck', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('QrwH-206', 'Crawler', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('JKEA-701', 'Excavator', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('vBaX-023', 'Grader', 18);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('oDii-691', 'Backhoe', 3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ECp-02', 'Trencher', 3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('WKAU-114', 'Scraper', 23);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('fGK-100', 'Dragline', 14);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('HjvF-60', 'Dragline', 11);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('flZ-760', 'Scraper', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('PkmF-01', 'Dump Truck', 7);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('WXz-6263', 'Grader', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('uRG-07', 'Backhoe', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('CPY-4438', 'Backhoe', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('UjMr-2457', 'Trencher', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('lipn-987', 'Dragline', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('EBRW-977', 'Grader', 25);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Lbbo-644', 'Bulldozer', 11);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('zhp-7747', 'Dump Truck', 6);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('szGX-371', 'Dump Truck', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('eJBf-078', 'Bulldozer', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('SZO-4202', 'Scraper', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('AyN-645', 'Backhoe', 5);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ZGF-048', 'Trencher', 23);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('doev-432', 'Bulldozer', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Yzf-72', 'Grader', 7);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('bZK-66', 'Grader', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('FQXY-69', 'Bulldozer', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('zBF-0261', 'Scraper', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('CjPs-288', 'Crawler', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('LAP-28', 'Dragline', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('yRjj-91', 'Scraper', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Zfd-4058', 'Scraper', 14);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('WWSs-60', 'Grader', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Oxal-80', 'Crawler', 25);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('wyfI-40', 'Trencher', 8);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('SVKN-747', 'Bulldozer', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('xLrP-044', 'Grader', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('EPT-29', 'Crawler', 15);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ajAe-959', 'Crawler', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('rnti-15', 'Compactor', 22);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('dEwz-3674', 'Trencher', 13);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Cwo-1228', 'Skid-Steer', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Vho-193', 'Backhoe', 3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('SkY-3104', 'Excavator', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ajTd-82', 'Crawler', 8);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('QjN-90', 'Scraper', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('mTer-811', 'Crawler', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ulh-67', 'Dragline', 15);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('cZW-808', 'Dump Truck', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('pMt-015', 'Skid-Steer', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('TKvC-4687', 'Crawler', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Guk-21', 'Compactor', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Uot-74', 'Dump Truck', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('CGmK-94', 'Dragline', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('KOGU-9952', 'Excavator', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('EZj-82', 'Dump Truck', 9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('pBuJ-5598', 'Bulldozer', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('lTw-23', 'Dragline', 18);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('TMJ-5854', 'Backhoe', 4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('DfG-6066', 'Trencher', 8);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Fryj-238', 'Crawler', 11);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('ApD-985', 'Trencher', 12);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('khO-3907', 'Dragline', 3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('BfM-61', 'Excavator', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('nIw-437', 'Bulldozer', 20);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('qzu-655', 'Backhoe', 21);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Bar-4532', 'Dump Truck', 23);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Tao-6082', 'Grader', 17);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('gSm-6394', 'Dragline', 19);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('JdyP-7118', 'Excavator', 24);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('svcZ-3997', 'Scraper', 18);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('AhMB-834', 'Backhoe', 16);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('AfKi-72', 'Backhoe', 25);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('CTea-2535', 'Crawler', 10);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values ('Wwpr-372', 'Scraper', 4);


go

insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 16:09', 63, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 17:06', 61, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 15:35', 73, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 16:43', 55, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 17:53', 49, 5);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 14:28', 79, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 9:39', 36, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 16:40', 88, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 8:18', 34, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 17:12', 62, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 14:31', 25, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 13:33', 33, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 5:08', 73, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 12:35', 87, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 17:20', 20, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 16:39', 28, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 15:35', 87, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 9:02', 19, 207);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 1:04', 79, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 14:43', 67, 229);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 3:12', 93, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 17:04', 74, 162);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 22:50', 21, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 22:27', 100, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 3:56', 53, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 14:22', 44, 176);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 21:39', 93, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:33', 68, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 12:43', 6, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 2:19', 33, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:48', 41, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 17:25', 88, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 20:38', 67, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 15:05', 82, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 6:24', 38, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 7:16', 8, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 14:01', 21, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 4:31', 99, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 0:09', 22, 156);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 9:38', 48, 231);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 13:17', 48, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 23:41', 67, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 19:15', 41, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 19:32', 50, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 13:11', 9, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 9:05', 39, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 17:54', 14, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 22:53', 100, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 7:08', 36, 176);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 18:28', 69, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 23:47', 34, 151);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 4:08', 38, 56);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 2:59', 45, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 17:33', 51, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 22:02', 6, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 12:14', 93, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 23:32', 77, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 12:43', 14, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 4:56', 13, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:58', 58, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 7:14', 43, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 0:16', 27, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 3:53', 76, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:11', 100, 166);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 16:32', 43, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 20:07', 3, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 8:24', 36, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 13:57', 92, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:01', 72, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 0:14', 84, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 5:14', 35, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 21:04', 34, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 19:49', 79, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 13:33', 33, 162);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 0:19', 56, 79);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 21:32', 60, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 3:48', 71, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 2:55', 51, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 23:03', 54, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 13:36', 22, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 8:41', 19, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 3:47', 49, 57);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:27', 27, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 10:29', 81, 11);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 23:12', 55, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 15:54', 26, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 22:09', 78, 87);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 3:18', 12, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 8:37', 55, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 14:20', 25, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 22:19', 32, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 17:31', 91, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 21:33', 72, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 9:15', 8, 212);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 8:20', 92, 207);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 3:14', 96, 180);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 13:54', 43, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 0:27', 87, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 22:59', 8, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 19:29', 77, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 22:39', 73, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 15:10', 87, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:00', 87, 189);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:50', 32, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 22:36', 98, 79);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 12:08', 81, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 21:35', 57, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:42', 66, 194);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 23:21', 50, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 22:11', 35, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 22:37', 79, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 16:05', 61, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 13:17', 22, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 8:25', 8, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 20:46', 3, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 20:43', 71, 180);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 22:53', 18, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 17:56', 32, 162);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 14:38', 66, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:45', 66, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 22:29', 5, 151);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:43', 55, 52);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 12:37', 78, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 12:35', 77, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 4:55', 13, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 11:36', 76, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 1:03', 31, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 0:11', 29, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 12:27', 1, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 2:54', 66, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:59', 74, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 14:46', 57, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 20:45', 89, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 22:23', 44, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 21:43', 60, 149);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 6:51', 11, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 4:34', 78, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 4:09', 24, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 11:00', 10, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 14:44', 65, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 1:14', 8, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 1:18', 75, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 23:11', 97, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 1:03', 16, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 15:06', 92, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 9:42', 71, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:03', 56, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 9:55', 26, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 0:08', 74, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 22:53', 86, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 1:17', 15, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 9:20', 33, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 10:01', 89, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 20:58', 100, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 7:41', 67, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 19:42', 36, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 8:35', 40, 178);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 4:42', 47, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 9:03', 50, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 20:52', 77, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 14:08', 69, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 4:46', 10, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 19:29', 58, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 5:36', 8, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 14:57', 72, 157);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 10:47', 17, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 11:27', 81, 63);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 21:56', 69, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 11:09', 73, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 0:14', 99, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 14:08', 86, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 10:48', 27, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 17:27', 98, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 13:59', 39, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 19:45', 79, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:12', 28, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 3:18', 18, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 4:52', 18, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 6:21', 53, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 11:47', 26, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 23:10', 38, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 11:22', 76, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 2:14', 63, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 15:21', 60, 4);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 8:01', 25, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 14:56', 28, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 1:28', 54, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 13:35', 63, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 23:46', 62, 61);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 1:05', 11, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 7:54', 58, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 7:58', 37, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 6:47', 15, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 3:36', 58, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 22:19', 4, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 11:37', 23, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 1:07', 51, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:57', 59, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 16:38', 6, 123);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 20:03', 90, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 5:08', 87, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 15:42', 86, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 8:30', 67, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 1:39', 34, 136);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 12:51', 47, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 3:24', 44, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 13:34', 51, 179);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 18:01', 84, 194);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 12:06', 80, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 4:10', 92, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 12:50', 39, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:07', 90, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 1:38', 76, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 15:39', 4, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 7:25', 72, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 19:43', 37, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 17:44', 76, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 20:17', 57, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 8:56', 5, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 2:34', 73, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 20:37', 95, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 13:35', 92, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 11:43', 13, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 10:10', 72, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 19:54', 45, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 3:05', 55, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:22', 39, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 22:50', 16, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 14:02', 9, 82);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 22:27', 36, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 3:39', 54, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 12:15', 69, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 11:20', 2, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 14:31', 62, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 19:06', 67, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 8:11', 67, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 11:50', 53, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 20:46', 42, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 9:20', 22, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 1:48', 87, 136);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 15:21', 85, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 18:21', 29, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 13:07', 15, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 9:06', 30, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:40', 53, 206);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 17:50', 50, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 2:28', 64, 149);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 16:54', 59, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:41', 56, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 19:54', 44, 208);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 22:29', 62, 219);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 0:33', 91, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 21:53', 63, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 9:23', 23, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 11:35', 54, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 3:41', 96, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 19:16', 100, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 10:50', 7, 46);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 10:37', 54, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 4:56', 53, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 15:12', 21, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 17:03', 79, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 22:07', 46, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 9:20', 18, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 6:27', 38, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 23:12', 35, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 17:29', 42, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 12:12', 64, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 23:24', 6, 176);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 13:06', 96, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 10:41', 8, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 20:12', 89, 75);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:39', 93, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 5:11', 3, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 12:16', 12, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 14:17', 2, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 23:09', 82, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 0:39', 44, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 19:47', 44, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 21:33', 99, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 17:42', 2, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 21:43', 38, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 20:13', 99, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:54', 100, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 8:53', 74, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 7:21', 87, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 22:27', 93, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 7:17', 86, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 15:02', 23, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 17:29', 83, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 23:20', 11, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 4:04', 15, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 9:52', 66, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 13:39', 84, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 9:31', 47, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 17:25', 32, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 16:31', 15, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 5:27', 96, 157);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 10:32', 38, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 8:01', 14, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 3:35', 35, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 16:33', 90, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 5:52', 58, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 8:13', 11, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 20:23', 83, 11);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 22:13', 58, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 11:42', 53, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 19:09', 71, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 4:29', 20, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 16:22', 77, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 13:06', 62, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 20:47', 34, 179);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 13:36', 83, 46);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 2:11', 80, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 11:58', 48, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 6:01', 57, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 14:23', 9, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 21:43', 3, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 3:16', 27, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 18:04', 7, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 3:42', 38, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 2:48', 52, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 22:18', 41, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 20:07', 88, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 16:49', 28, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 12:25', 1, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:56', 56, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 7:24', 5, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 3:36', 76, 246);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 20:49', 67, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 23:33', 65, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 10:32', 64, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:40', 55, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 21:28', 34, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 0:23', 52, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 13:56', 8, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 9:30', 92, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 7:17', 18, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 6:20', 20, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 11:28', 30, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 11:35', 64, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 8:35', 66, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 18:39', 60, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 17:24', 91, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 3:04', 42, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 19:37', 56, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 3:45', 26, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 23:41', 1, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 11:49', 85, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 7:17', 43, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 11:33', 75, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:28', 35, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 2:29', 81, 117);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 14:34', 19, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 8:38', 41, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 18:44', 18, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 20:49', 22, 162);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 20:14', 26, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 5:03', 88, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 1:26', 20, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 4:16', 17, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 9:00', 46, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 17:35', 27, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 15:39', 56, 219);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 19:14', 31, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 17:09', 88, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 8:53', 60, 66);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 9:07', 75, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 6:16', 95, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 16:16', 60, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 12:40', 21, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 13:05', 85, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 16:51', 50, 182);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 22:12', 23, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 3:24', 99, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 8:29', 31, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 14:22', 2, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 22:06', 27, 166);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 21:11', 49, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 13:27', 98, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 11:06', 95, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 3:43', 1, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 2:44', 59, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:39', 4, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 6:25', 2, 115);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 18:52', 84, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 0:15', 63, 56);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 6:38', 27, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 0:35', 95, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 19:24', 89, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 14:09', 32, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 10:29', 20, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 20:16', 65, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 20:21', 52, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 10:37', 61, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 10:18', 99, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 10:01', 35, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 4:53', 14, 246);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:34', 51, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 7:42', 63, 179);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:21', 71, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 3:24', 98, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 3:10', 3, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 14:08', 4, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 16:01', 39, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 12:31', 16, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:50', 31, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 22:27', 71, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 0:29', 26, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:32', 85, 4);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 11:48', 79, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 12:22', 72, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 19:38', 4, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 11:57', 72, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 16:22', 98, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 6:27', 63, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 14:51', 91, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 9:59', 77, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 12:37', 6, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 10:31', 55, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 7:10', 89, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 3:36', 33, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 2:42', 64, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 22:42', 61, 178);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 5:46', 82, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 2:39', 32, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 19:10', 45, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 22:30', 30, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 12:39', 30, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 16:52', 56, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 20:36', 1, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 2:17', 87, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 18:03', 21, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 14:07', 59, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:00', 2, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 15:57', 23, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 14:11', 70, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 22:13', 66, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 14:13', 86, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 16:34', 15, 5);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 19:21', 66, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 23:06', 49, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 3:48', 62, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 8:58', 12, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 20:25', 31, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 4:45', 4, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 11:07', 50, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 4:50', 12, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 15:42', 12, 66);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 16:52', 23, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 9:03', 57, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 15:13', 94, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 3:27', 48, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:48', 59, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 22:05', 40, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:57', 38, 49);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:57', 29, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 16:38', 95, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 17:14', 35, 159);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 16:07', 34, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 3:29', 31, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 4:42', 18, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 3:08', 83, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 7:04', 93, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 18:55', 33, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 10:30', 33, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 20:09', 97, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 0:47', 4, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 13:54', 45, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 2:12', 69, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 4:53', 36, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 18:26', 31, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 3:20', 80, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 3:12', 1, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 3:13', 19, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 9:17', 83, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 18:36', 100, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 9:37', 98, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 1:02', 90, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 13:43', 55, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 9:24', 15, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 22:27', 91, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 6:34', 70, 117);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 15:01', 69, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 3:40', 70, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 3:28', 4, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 8:58', 28, 207);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 5:09', 37, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 18:49', 15, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 20:06', 76, 149);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 20:01', 23, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 5:31', 84, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 12:46', 72, 207);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 5:52', 27, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 12:22', 65, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 9:31', 82, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 12:05', 57, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 23:13', 66, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 16:06', 59, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 20:45', 47, 154);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 12:18', 1, 85);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 22:05', 43, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 9:59', 39, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 16:06', 96, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 11:26', 2, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:13', 36, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 21:21', 97, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 20:59', 28, 4);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 5:44', 78, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 10:50', 27, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 10:12', 16, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 11:04', 37, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 20:03', 92, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 3:28', 25, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 23:36', 56, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:07', 84, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 19:46', 56, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:40', 24, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 3:17', 53, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 12:28', 73, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 12:30', 27, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 5:51', 96, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 17:34', 20, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 21:52', 55, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 6:34', 28, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 12:56', 18, 81);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 11:17', 93, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 23:26', 1, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 12:49', 55, 83);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 6:07', 46, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 2:37', 6, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 6:23', 74, 11);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 8:09', 13, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 18:26', 37, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 23:18', 97, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 17:24', 3, 233);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 9:52', 30, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:39', 64, 154);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 20:51', 22, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 6:40', 46, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 15:45', 5, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 1:29', 21, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 22:16', 87, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 7:22', 96, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 16:35', 9, 189);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 1:27', 16, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 18:29', 57, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 2:57', 45, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 8:54', 80, 219);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:44', 1, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 7:18', 6, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 0:11', 12, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 13:41', 24, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 19:54', 9, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 0:51', 83, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 16:11', 9, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 0:21', 76, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 4:46', 4, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 22:17', 48, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 13:34', 43, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 16:11', 86, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 19:18', 80, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 1:34', 90, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 7:40', 12, 11);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 23:38', 63, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 5:49', 53, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 11:15', 60, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 0:01', 59, 87);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 2:00', 5, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 2:53', 36, 194);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 18:20', 11, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 8:43', 26, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 21:08', 50, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 20:41', 75, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 17:38', 68, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 0:54', 73, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 11:10', 8, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 15:54', 91, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 11:04', 76, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 19:50', 76, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 4:28', 69, 85);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:28', 6, 181);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 17:35', 6, 83);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 7:13', 41, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:47', 56, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 7:18', 14, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 6:43', 23, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 21:32', 61, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 17:00', 41, 46);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 6:43', 39, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 9:17', 22, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 3:37', 85, 243);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 23:47', 69, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 22:25', 13, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 15:57', 92, 159);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 12:09', 93, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 6:10', 96, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 4:24', 77, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 16:07', 3, 82);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 7:44', 30, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 0:04', 28, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:24', 59, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 6:25', 53, 19);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 13:49', 61, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 11:07', 23, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 18:06', 31, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 19:20', 86, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:15', 60, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 12:47', 59, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 6:09', 10, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 7:15', 74, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 19:13', 87, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 8:36', 5, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 6:57', 40, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 15:05', 57, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 4:17', 23, 166);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 7:24', 18, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 19:14', 67, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 23:11', 54, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 4:21', 61, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 16:48', 46, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 0:02', 89, 159);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 1:54', 98, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 19:33', 70, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 0:09', 38, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 12:37', 77, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 13:08', 95, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 19:25', 44, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 12:41', 25, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 23:25', 1, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 16:22', 66, 24);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 5:18', 95, 246);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 5:20', 26, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 15:25', 34, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 2:14', 91, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 1:07', 26, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 13:48', 7, 84);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 18:04', 12, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:55', 90, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 7:07', 35, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 2:16', 12, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 5:53', 29, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 1:03', 6, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 15:38', 50, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:38', 96, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:23', 39, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 0:52', 57, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 2:43', 100, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 17:08', 77, 130);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 22:32', 27, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 5:10', 7, 24);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 3:24', 63, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 2:46', 21, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:36', 67, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 10:35', 85, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 4:12', 91, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 4:36', 70, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 9:42', 89, 84);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 21:21', 32, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:18', 1, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 15:08', 85, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 7:26', 16, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 21:33', 62, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 20:02', 79, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 15:56', 42, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 13:23', 60, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 22:22', 64, 136);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 21:27', 1, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 15:45', 18, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 3:59', 12, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 4:25', 62, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:50', 15, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 7:24', 78, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 20:22', 62, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 21:53', 68, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 6:14', 33, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 8:19', 51, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 21:03', 16, 123);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 11:31', 4, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 4:28', 63, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 4:09', 14, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 2:09', 77, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:04', 77, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 22:56', 44, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 12:10', 40, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 6:19', 73, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 14:23', 22, 79);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 14:47', 41, 169);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 10:11', 93, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 8:07', 60, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 5:42', 42, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 6:09', 100, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 7:50', 26, 206);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 18:31', 87, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 14:48', 12, 32);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 7:02', 50, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 19:59', 77, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 14:17', 28, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 2:26', 66, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 22:34', 51, 49);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 22:07', 95, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 2:54', 58, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 7:08', 27, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 21:36', 54, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 17:14', 18, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 11:48', 81, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 5:29', 23, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 20:36', 22, 81);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 11:51', 13, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 20:38', 4, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 16:20', 92, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 21:26', 17, 159);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 3:09', 82, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 23:12', 81, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 18:35', 19, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 12:24', 21, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 18:52', 79, 208);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 8:10', 1, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 7:50', 100, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 3:33', 29, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 20:58', 9, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 9:41', 23, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 12:45', 90, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 10:01', 14, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 11:03', 72, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 22:58', 33, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 17:30', 9, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 23:36', 46, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 3:13', 100, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 9:53', 49, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 16:22', 63, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 7:49', 68, 206);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 6:09', 39, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 10:37', 62, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 22:38', 8, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 1:08', 23, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 8:24', 49, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 8:09', 50, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 1:21', 64, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:43', 13, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 22:39', 77, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 18:11', 39, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 20:47', 90, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 2:13', 86, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 6:52', 36, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 5:54', 70, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 9:14', 47, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 1:50', 1, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 9:39', 99, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:43', 14, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 2:27', 32, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 7:46', 16, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 13:27', 80, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 7:44', 60, 123);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 4:48', 19, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 0:05', 20, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 8:11', 20, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 8:39', 82, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 1:19', 4, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 5:58', 31, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 3:44', 24, 52);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 4:52', 85, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 1:01', 22, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 9:41', 43, 54);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 9:14', 21, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 8:48', 77, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 1:44', 92, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 12:19', 62, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 14:20', 80, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 7:03', 92, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 4:40', 23, 63);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 0:42', 15, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 15:37', 86, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 22:31', 73, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 21:49', 85, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 16:33', 55, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 3:06', 90, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 2:23', 68, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 2:32', 33, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 18:03', 36, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:34', 12, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 21:53', 49, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 17:35', 92, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 5:11', 42, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 2:46', 50, 21);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 17:09', 56, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 1:10', 4, 87);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 3:34', 27, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 11:14', 43, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 17:59', 17, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 18:11', 93, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 6:52', 38, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 13:28', 16, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 0:42', 96, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 3:49', 59, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 8:06', 91, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:12', 56, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 0:20', 81, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 17:07', 59, 169);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 13:41', 12, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 22:18', 83, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 6:51', 29, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 2:44', 23, 115);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 20:54', 3, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 16:05', 6, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 11:16', 41, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 16:40', 15, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 14:09', 65, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 5:50', 33, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 4:46', 76, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 3:41', 21, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 1:47', 40, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 17:23', 83, 179);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 13:20', 70, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 14:57', 67, 207);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:10', 95, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 15:25', 19, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 10:03', 22, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 6:35', 8, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 8:12', 54, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 7:13', 56, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 4:55', 69, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 3:57', 35, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 20:43', 88, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 21:11', 77, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 17:49', 70, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 5:50', 85, 130);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 15:31', 66, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 18:18', 55, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 5:07', 23, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 15:23', 85, 169);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 3:05', 83, 229);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 19:30', 100, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 7:24', 43, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 10:59', 92, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 19:43', 67, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 21:59', 79, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 18:13', 74, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 10:57', 60, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:24', 100, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 15:37', 9, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 0:52', 14, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 23:46', 38, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 14:53', 52, 246);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 18:34', 82, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 13:10', 24, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 1:19', 39, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 10:30', 24, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 5:22', 17, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 19:25', 53, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 21:10', 85, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 17:19', 78, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 16:46', 69, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 12:42', 54, 130);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 3:16', 36, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 12:46', 52, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 8:16', 79, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 2:47', 83, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 16:09', 26, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 2:35', 54, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 16:06', 85, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 20:45', 56, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 12:31', 80, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 20:23', 30, 189);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:38', 29, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 23:08', 59, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 7:07', 11, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 5:26', 60, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 16:26', 68, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 12:11', 23, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 20:50', 81, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 17:46', 84, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 2:27', 30, 56);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 14:51', 82, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 6:38', 96, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 16:11', 67, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 23:39', 90, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 14:09', 74, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 14:43', 97, 57);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 14:42', 57, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 17:50', 15, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 9:34', 46, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 14:29', 15, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 5:14', 50, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 8:35', 80, 229);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 6:18', 100, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 13:36', 91, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 8:50', 85, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 21:05', 86, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 17:14', 46, 84);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 18:04', 50, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 23:08', 73, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 15:03', 80, 66);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:47', 34, 56);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 6:52', 45, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 8:36', 86, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 14:32', 50, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 4:21', 80, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 15:03', 54, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 6:00', 7, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 13:02', 20, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:43', 15, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 1:54', 4, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 23:01', 64, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 23:11', 25, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 9:48', 52, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 10:42', 16, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 15:52', 47, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 3:00', 75, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 4:27', 2, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 7:15', 38, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 14:07', 18, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 6:04', 79, 194);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 3:24', 10, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:45', 87, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 19:04', 74, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 6:45', 25, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 7:17', 19, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 10:59', 23, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 15:16', 38, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 1:32', 6, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 0:02', 16, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 19:39', 57, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 14:39', 18, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/24/2024 14:20', 52, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 13:49', 78, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 23:56', 45, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 22:33', 21, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 9:42', 20, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/14/2024 3:04', 23, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 5:46', 76, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 9:12', 9, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 13:28', 74, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/18/2024 7:40', 100, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 12:55', 58, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 19:37', 65, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 0:39', 92, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 23:48', 1, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 4:53', 52, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 0:24', 15, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 3:17', 40, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 17:18', 89, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 22:50', 46, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 11:25', 68, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 1:05', 36, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 21:15', 40, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 8:09', 43, 151);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 18:57', 89, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/4/2024 2:10', 51, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/30/2024 8:44', 87, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 9:38', 17, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 7:08', 22, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:09', 51, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:41', 90, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 16:19', 21, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 8:34', 17, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/12/2024 5:17', 30, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/3/2024 5:57', 91, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 16:42', 51, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 16:01', 72, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 0:06', 70, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 22:03', 100, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 11:02', 26, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/10/2024 3:11', 1, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 17:07', 76, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 16:02', 55, 189);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 10:04', 94, 157);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 4:00', 15, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:41', 5, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/2/2024 9:15', 57, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 16:27', 9, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/1/2024 19:29', 21, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/19/2024 19:16', 17, 169);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 10:10', 60, 49);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 4:39', 86, 157);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/25/2024 16:23', 94, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/26/2024 13:50', 38, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/11/2024 16:21', 70, 231);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 5:11', 68, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/9/2024 1:28', 47, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 22:57', 47, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 17:27', 66, 46);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 16:29', 56, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:27', 15, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/16/2024 5:23', 22, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/22/2024 15:03', 65, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/27/2024 5:19', 10, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/23/2024 10:54', 31, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/20/2024 20:00', 79, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/17/2024 14:14', 26, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 5:10', 80, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/21/2024 0:00', 68, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 23:53', 34, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 19:19', 60, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/5/2024 14:27', 60, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/6/2024 22:28', 7, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/8/2024 15:47', 21, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/13/2024 16:37', 16, 212);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/7/2024 6:09', 26, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/15/2024 15:21', 42, 129);

go
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 23:36', 15.29, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 15:03', 44.26, 12);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 21:41', 44.38, 59);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 15:23', 85.87, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 0:04', 45.18, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 8:30', 52.42, 52);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 3:59', 43.28, 181);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 21:55', 33.59, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 18:19', 66.59, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 1:00', 5.91, 57);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 21:51', 56.81, 124);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 23:09', 2.86, 102);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 1:14', 51.63, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 15:03', 73.26, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 18:42', 96.18, 35);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 8:49', 61.42, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 6:58', 95.1, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:23', 24.26, 60);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 12:32', 30.7, 109);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:40', 81.98, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 6:35', 78.52, 81);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 3:20', 5.64, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 21:05', 50.08, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 23:46', 91.09, 116);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 20:35', 79.91, 150);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 21:51', 81.18, 245);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 8:27', 41.01, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 12:48', 22.56, 145);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 21:41', 21.95, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 20:50', 88.44, 181);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 8:08', 94.1, 230);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 13:45', 48.02, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 23:06', 98.59, 20);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 17:35', 52.12, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 1:24', 9.8, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 13:44', 73.87, 27);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 17:01', 69.85, 201);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 4:28', 60.83, 98);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 23:31', 59.97, 172);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 20:28', 84.0, 56);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 6:14', 12.27, 194);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 7:44', 8.27, 193);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:27', 88.53, 179);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 14:55', 1.99, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 9:40', 23.73, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 21:20', 16.97, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 0:36', 62.36, 2);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 12:48', 48.82, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 10:40', 83.34, 158);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 11:43', 73.11, 42);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 16:23', 36.69, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 19:57', 55.63, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 7:53', 90.78, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 20:13', 92.29, 212);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 19:54', 98.28, 167);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 22:49', 1.65, 181);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 9:07', 63.36, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 5:13', 7.11, 83);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 6:00', 3.06, 246);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 17:02', 13.8, 3);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 4:32', 45.5, 74);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 20:01', 1.38, 213);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 19:58', 17.12, 180);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:58', 66.92, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 23:36', 44.87, 123);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 16:05', 40.73, 72);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 6:05', 79.7, 103);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 2:14', 90.45, 197);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 16:35', 88.53, 96);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 3:31', 16.12, 135);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 8:36', 23.27, 156);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 14:11', 3.58, 235);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 11:08', 48.51, 246);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 10:40', 91.73, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 19:27', 35.99, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 3:10', 22.03, 246);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 22:30', 2.44, 212);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 13:43', 13.45, 140);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 7:30', 72.97, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 10:00', 27.52, 78);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 1:39', 53.55, 75);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 11:14', 79.39, 187);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 0:54', 75.88, 184);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 16:31', 84.85, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 13:56', 8.97, 185);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 13:26', 47.5, 30);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 20:51', 24.42, 18);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 12:38', 52.16, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 17:04', 97.9, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 16:13', 21.84, 185);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 13:00', 75.33, 167);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 19:03', 74.89, 173);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 5:03', 75.73, 33);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 5:14', 40.79, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 15:38', 83.99, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:12', 24.11, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 19:48', 60.44, 173);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 6:16', 56.2, 230);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 13:39', 33.49, 180);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 10:07', 85.52, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 13:24', 10.21, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 16:18', 34.0, 134);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 14:04', 37.1, 108);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 12:43', 36.69, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 19:37', 17.01, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 8:03', 58.53, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 9:42', 36.08, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 16:50', 52.59, 31);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 3:32', 52.44, 150);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 18:19', 89.11, 150);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:30', 69.2, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 3:28', 88.31, 212);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 0:37', 73.48, 18);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 9:41', 51.51, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 15:59', 41.49, 30);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 5:09', 89.98, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 20:09', 27.81, 159);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:12', 64.76, 32);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 20:30', 28.41, 108);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 10:04', 98.15, 128);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 13:49', 27.16, 238);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 9:14', 50.68, 87);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:42', 63.91, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 19:30', 59.77, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 5:58', 59.1, 57);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 13:09', 36.67, 11);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 4:24', 91.8, 4);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 10:26', 24.6, 54);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 2:45', 75.18, 47);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 20:25', 53.67, 85);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 11:36', 69.49, 35);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 13:56', 8.82, 194);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 8:30', 89.03, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 13:50', 50.0, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 19:18', 78.73, 136);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 9:10', 45.08, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 3:39', 88.3, 87);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:56', 81.33, 41);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 15:24', 43.28, 189);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 2:20', 87.83, 90);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 1:18', 28.63, 208);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 8:23', 8.25, 222);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 2:09', 56.61, 40);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 8:51', 49.06, 71);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 13:22', 99.18, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 4:57', 26.68, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 17:59', 42.48, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 5:23', 85.08, 22);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 20:47', 61.5, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 23:27', 7.7, 138);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 19:43', 86.75, 104);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 23:32', 63.79, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 10:46', 87.79, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 15:23', 2.97, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 12:33', 90.41, 24);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 7:05', 60.65, 124);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 19:27', 92.03, 220);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 15:52', 73.59, 171);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 11:47', 15.28, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 4:12', 42.34, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 1:08', 4.99, 134);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 20:23', 51.29, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 7:19', 23.81, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 22:23', 42.7, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 19:06', 20.51, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 7:07', 55.41, 36);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 20:38', 35.22, 88);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 23:16', 87.1, 207);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 14:38', 2.82, 78);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 8:05', 71.9, 208);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 14:16', 87.86, 82);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 13:04', 33.91, 148);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 10:36', 91.4, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 23:29', 96.69, 2);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 13:57', 82.6, 173);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 12:11', 13.96, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 5:50', 54.53, 44);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 12:17', 55.83, 35);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 21:20', 76.22, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 11:15', 73.34, 207);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 0:00', 84.05, 161);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 1:54', 72.8, 163);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 10:39', 97.67, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 12:58', 21.93, 207);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 21:06', 70.58, 105);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 23:46', 85.84, 191);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 20:34', 80.62, 211);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 2:47', 58.98, 187);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 5:38', 73.19, 170);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 8:42', 94.69, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 7:28', 22.88, 28);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 6:01', 67.47, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 17:53', 28.46, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 12:43', 91.22, 201);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 1:02', 36.0, 82);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 19:01', 27.82, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:12', 51.66, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 6:16', 93.68, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 2:20', 4.38, 172);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 5:12', 23.04, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 5:28', 39.79, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:05', 45.06, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 12:12', 40.97, 62);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 11:56', 48.79, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 13:05', 98.11, 123);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 13:23', 42.51, 8);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 17:39', 93.93, 196);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 13:38', 61.21, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:19', 54.24, 93);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 8:42', 96.78, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 0:44', 88.77, 173);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 21:16', 60.56, 50);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 18:22', 25.96, 211);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:11', 65.88, 157);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 19:24', 12.89, 70);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 20:00', 52.38, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 4:03', 37.62, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 0:47', 21.97, 172);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 4:45', 89.63, 222);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 15:35', 3.54, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 16:18', 98.66, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 5:12', 72.05, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 5:46', 74.53, 18);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 22:13', 12.66, 90);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 23:40', 34.05, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:06', 69.38, 44);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 1:45', 56.5, 13);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 9:46', 69.07, 40);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 20:19', 80.03, 89);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 6:00', 85.62, 207);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 10:13', 21.57, 108);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 22:20', 50.94, 196);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 19:21', 55.0, 75);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 12:05', 48.6, 159);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 2:03', 85.08, 93);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 12:19', 96.11, 236);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 20:13', 27.92, 233);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:01', 83.65, 24);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 9:38', 5.93, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 5:56', 58.63, 249);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:46', 18.36, 130);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 4:22', 33.11, 52);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 19:40', 57.36, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:47', 91.02, 129);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 20:02', 27.99, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 6:42', 92.64, 220);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 0:07', 79.13, 157);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 18:40', 82.89, 210);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 7:51', 79.91, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 14:01', 76.55, 7);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 17:53', 61.22, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 9:38', 85.04, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 7:45', 49.71, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 9:19', 56.78, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 11:14', 62.59, 167);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 22:39', 4.51, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 15:52', 17.37, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 13:45', 90.42, 52);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 1:45', 23.83, 70);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 1:37', 73.78, 163);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 23:16', 68.13, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 2:06', 65.42, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 23:36', 99.48, 57);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 21:41', 52.25, 47);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 18:36', 34.49, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 8:43', 80.91, 150);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 19:58', 90.49, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 8:33', 64.52, 7);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 11:19', 38.09, 59);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 10:52', 20.32, 197);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 12:42', 91.27, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 20:40', 22.98, 160);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 23:43', 99.34, 148);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 20:08', 1.93, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 12:34', 20.18, 170);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 14:06', 7.95, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 19:36', 9.77, 9);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 1:21', 36.68, 218);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 15:32', 49.11, 87);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 2:13', 69.06, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 11:31', 41.47, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 22:20', 87.52, 100);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 18:39', 77.08, 193);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 18:55', 61.08, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 11:38', 13.19, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 13:19', 13.96, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 22:05', 18.16, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 1:08', 54.0, 16);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 20:20', 37.57, 215);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 19:38', 73.98, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 7:19', 1.21, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 6:22', 75.43, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 16:19', 99.08, 160);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 13:42', 15.14, 51);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 2:51', 22.46, 20);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 10:33', 18.47, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 16:49', 77.39, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 1:09', 97.59, 104);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 23:53', 95.25, 68);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 23:24', 49.46, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 1:35', 36.12, 117);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 14:09', 14.79, 81);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 17:36', 86.25, 244);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 8:53', 5.19, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 13:27', 74.18, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 23:44', 46.0, 4);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 4:57', 76.9, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 13:17', 79.28, 41);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 6:29', 65.45, 130);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 2:47', 80.89, 9);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 22:21', 24.5, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:37', 60.44, 40);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 19:16', 19.01, 244);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 0:39', 57.83, 208);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 5:47', 1.05, 54);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 20:30', 28.26, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 23:54', 38.46, 230);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 0:41', 37.64, 156);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 12:53', 59.07, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 17:41', 37.76, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 0:31', 9.22, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 22:57', 88.0, 204);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:02', 72.67, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 18:01', 24.81, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 0:43', 52.91, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 18:13', 48.43, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 16:40', 7.51, 10);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 3:36', 3.2, 96);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 5:54', 34.29, 129);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 11:26', 87.01, 88);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 19:04', 49.15, 233);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 23:46', 45.9, 245);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 19:06', 59.23, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 16:43', 11.19, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 2:25', 74.25, 180);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 10:23', 35.16, 70);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 16:55', 81.98, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 11:59', 23.53, 96);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 17:04', 71.48, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 7:55', 24.21, 13);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 16:44', 18.78, 13);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 15:23', 98.39, 247);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 11:26', 12.18, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 22:04', 54.28, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 10:12', 56.75, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 8:41', 57.35, 73);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 17:05', 96.35, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 13:44', 42.28, 28);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 13:47', 23.6, 236);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:03', 36.59, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 1:08', 77.35, 49);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 0:28', 68.64, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 20:11', 23.52, 81);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 23:14', 81.89, 83);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 14:23', 42.2, 67);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 19:58', 25.58, 107);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 10:16', 63.52, 197);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 0:31', 41.66, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 18:11', 66.23, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 22:22', 5.56, 33);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 0:47', 82.44, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 1:43', 80.18, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 23:56', 70.46, 127);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 22:12', 71.51, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 5:35', 95.25, 62);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:25', 71.58, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 15:38', 80.89, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 2:32', 8.82, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 11:35', 23.19, 168);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 19:12', 64.82, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 5:08', 74.24, 78);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 3:19', 88.11, 13);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 7:33', 47.12, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 21:33', 72.44, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 11:19', 51.74, 187);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 0:01', 84.34, 246);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 20:51', 74.14, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 8:30', 33.67, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 9:33', 79.01, 238);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 2:40', 46.25, 86);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 4:22', 21.73, 228);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 6:33', 81.23, 27);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 13:23', 19.37, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 18:04', 28.28, 212);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 18:07', 15.49, 74);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 21:34', 72.11, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 14:05', 4.5, 98);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 2:26', 54.59, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 5:10', 41.25, 54);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 0:41', 99.22, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 7:46', 24.45, 83);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 6:03', 5.36, 193);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 11:40', 82.04, 175);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 9:20', 18.25, 185);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:51', 30.95, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 12:10', 64.93, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 23:45', 44.5, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 5:41', 46.65, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 8:51', 3.84, 71);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 10:09', 61.04, 50);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 2:25', 53.95, 78);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 3:07', 63.73, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 12:28', 52.47, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:00', 36.08, 179);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 18:07', 8.15, 194);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 9:46', 18.02, 244);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 20:08', 19.68, 32);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 21:40', 50.09, 136);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 8:43', 15.17, 207);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 21:20', 89.09, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:00', 92.19, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 23:22', 5.23, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 14:03', 28.04, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 21:36', 16.93, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 2:55', 95.48, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 8:23', 96.39, 158);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 12:27', 3.84, 95);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 2:00', 58.44, 129);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 1:50', 28.73, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 11:21', 56.09, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 20:46', 27.78, 93);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 16:42', 57.57, 26);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 5:27', 36.88, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 22:06', 88.22, 64);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 20:03', 78.06, 52);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 17:23', 44.87, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 22:48', 99.35, 40);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 2:08', 60.43, 185);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 22:06', 27.8, 205);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 11:01', 47.25, 134);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 4:21', 64.34, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 4:09', 10.07, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 5:04', 6.48, 247);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 15:12', 80.79, 27);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:27', 90.76, 85);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 21:37', 84.33, 138);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 15:16', 52.83, 8);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 17:24', 27.48, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:16', 91.96, 67);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 4:04', 89.55, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 19:38', 36.23, 90);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 22:55', 8.1, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 2:52', 1.42, 169);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 23:10', 72.45, 147);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 13:44', 83.25, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 22:06', 58.27, 171);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 2:27', 43.79, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 22:44', 60.11, 31);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 23:54', 70.64, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 1:28', 41.06, 115);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 2:16', 52.12, 157);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 6:22', 68.55, 134);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 1:31', 21.0, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 7:14', 92.65, 64);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:10', 10.78, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 10:23', 54.19, 50);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 4:32', 10.76, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 22:59', 47.67, 46);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 13:50', 88.32, 52);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:38', 49.5, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 16:55', 57.7, 86);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 16:00', 38.16, 180);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 0:09', 33.15, 35);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 5:55', 56.31, 237);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 15:32', 32.77, 180);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:19', 97.25, 8);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 10:35', 7.36, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 8:07', 91.86, 213);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 6:31', 91.99, 189);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 9:06', 99.25, 73);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 20:04', 89.16, 168);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 21:57', 13.26, 8);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 17:35', 60.13, 70);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 19:36', 36.56, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 9:14', 88.92, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 23:24', 32.91, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:36', 98.15, 100);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 4:48', 84.83, 11);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 15:44', 96.23, 18);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 17:41', 18.46, 123);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 8:52', 47.36, 31);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 9:37', 32.46, 136);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 2:05', 79.7, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 6:10', 35.84, 246);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:46', 49.2, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 14:22', 8.24, 116);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 19:15', 91.44, 127);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 20:31', 58.18, 76);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 18:58', 73.33, 20);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 18:37', 61.95, 215);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 0:12', 24.61, 120);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 22:51', 74.71, 142);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 13:24', 78.06, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:21', 91.33, 183);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 23:53', 1.36, 232);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 9:30', 13.29, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 19:15', 5.97, 16);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 7:44', 76.9, 147);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 1:36', 7.33, 69);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 10:11', 28.33, 115);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 12:38', 21.19, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 4:12', 77.46, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 15:50', 41.49, 147);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:49', 38.68, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 8:44', 57.56, 10);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 21:57', 7.08, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 18:14', 45.4, 243);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 1:38', 81.93, 145);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 9:32', 86.58, 135);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 14:35', 86.01, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 13:58', 73.46, 193);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 10:56', 97.69, 116);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 11:27', 37.42, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 0:17', 11.09, 62);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 18:20', 57.94, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 22:03', 88.36, 6);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 15:43', 27.08, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 17:13', 27.78, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 9:53', 75.61, 62);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 4:14', 59.3, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 21:16', 46.98, 172);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 6:36', 31.2, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 4:07', 24.61, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 14:55', 2.59, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:13', 65.64, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 17:42', 32.41, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 17:23', 94.12, 217);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 10:15', 6.16, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 14:16', 29.49, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 14:43', 73.14, 142);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 0:29', 4.01, 147);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 0:06', 96.86, 20);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 16:30', 54.2, 169);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 20:36', 52.18, 109);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 2:12', 65.08, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 23:56', 2.86, 185);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 15:37', 64.68, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 21:49', 31.05, 210);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:37', 64.92, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 3:59', 40.48, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 1:18', 49.21, 168);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 4:10', 50.22, 135);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 5:07', 48.32, 69);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 12:11', 21.65, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 9:56', 63.21, 138);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 0:56', 93.32, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 18:48', 6.2, 62);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:08', 21.26, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 13:52', 2.22, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 13:29', 6.06, 171);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 21:13', 32.84, 155);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 3:12', 44.0, 173);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 23:25', 26.37, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 9:53', 91.76, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 16:31', 42.67, 6);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 11:46', 27.32, 165);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 1:11', 36.58, 87);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 17:16', 72.05, 60);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 5:26', 60.17, 33);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 2:05', 7.97, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 19:06', 2.9, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:52', 44.52, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 20:08', 53.06, 134);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:28', 21.24, 30);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:03', 96.17, 66);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 3:41', 2.45, 239);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 5:04', 40.0, 47);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 21:15', 15.45, 231);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 16:41', 13.69, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 4:44', 18.09, 202);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 19:51', 94.26, 156);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 10:13', 24.67, 179);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 22:20', 45.14, 120);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 21:54', 51.32, 124);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:47', 96.75, 103);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 13:59', 77.83, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 13:59', 30.43, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 21:25', 38.58, 169);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 9:27', 91.04, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 7:15', 20.55, 28);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 20:47', 44.97, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 0:56', 21.91, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 22:12', 14.84, 144);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 4:50', 57.82, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 10:36', 1.67, 13);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 13:55', 65.54, 197);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 16:40', 78.46, 112);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:38', 3.95, 233);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 16:33', 51.11, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 23:37', 99.76, 245);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 10:13', 86.38, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:33', 15.43, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 19:00', 2.15, 215);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 19:45', 75.51, 105);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 20:11', 34.31, 232);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 21:13', 42.5, 141);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 16:02', 22.83, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 21:00', 82.25, 98);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 20:37', 26.27, 103);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 20:55', 12.96, 7);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 11:14', 53.55, 118);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 0:04', 18.72, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:38', 90.38, 60);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 0:58', 43.98, 239);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 7:35', 79.1, 246);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 20:34', 39.67, 68);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 4:59', 70.26, 76);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 15:24', 38.48, 173);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 18:28', 58.72, 207);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:23', 47.04, 49);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 11:13', 15.31, 118);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 13:39', 34.42, 100);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 17:43', 34.41, 27);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 20:00', 9.56, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 20:02', 56.98, 236);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 18:32', 27.96, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 17:12', 44.75, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 17:24', 18.39, 220);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 13:25', 15.47, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:56', 75.67, 249);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:30', 16.28, 197);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:55', 84.87, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 22:53', 88.89, 210);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 12:10', 29.5, 241);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 14:05', 52.37, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 7:49', 73.86, 204);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 16:59', 19.91, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 13:58', 97.11, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 18:40', 4.83, 247);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 12:17', 55.74, 87);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 22:02', 38.22, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 23:30', 89.88, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 0:01', 39.78, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 17:38', 80.28, 112);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 1:52', 59.78, 193);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 20:10', 3.41, 16);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 19:16', 40.6, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 17:07', 88.76, 175);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 22:03', 32.96, 152);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 8:54', 20.96, 8);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 5:28', 31.68, 120);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:36', 60.05, 229);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 18:54', 23.67, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:57', 76.18, 117);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 22:54', 58.17, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 10:02', 4.0, 62);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 3:36', 73.08, 194);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:17', 20.09, 26);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 21:01', 59.53, 185);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 14:48', 72.8, 104);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 21:57', 40.69, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 21:31', 24.76, 160);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 1:33', 59.69, 73);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 17:47', 63.49, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 2:43', 40.76, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 16:22', 1.58, 113);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 7:29', 22.65, 183);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 0:28', 96.84, 56);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 0:26', 12.45, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 2:41', 14.82, 249);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 3:28', 32.58, 241);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 1:36', 67.65, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 18:43', 92.68, 117);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 2:57', 72.24, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 4:37', 22.94, 109);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 0:04', 70.68, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 18:58', 14.01, 30);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:18', 40.42, 16);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 22:44', 92.04, 204);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 19:32', 75.78, 104);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 3:29', 35.66, 247);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 10:17', 49.77, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 23:54', 33.48, 123);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 10:07', 53.53, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 18:33', 1.14, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 14:53', 26.15, 163);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 10:28', 89.25, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 5:56', 3.14, 175);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 10:54', 71.97, 169);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 22:52', 35.36, 42);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 0:47', 80.79, 74);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 15:04', 33.72, 93);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 13:48', 41.11, 204);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 4:41', 16.31, 111);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 13:21', 88.24, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 13:33', 11.55, 217);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 21:06', 7.25, 158);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 9:21', 49.05, 71);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:49', 62.57, 11);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 21:44', 72.6, 208);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 20:46', 23.37, 249);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 9:41', 67.93, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 16:23', 12.24, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 19:10', 64.41, 43);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 4:48', 12.65, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 8:51', 76.75, 26);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:44', 18.88, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 11:39', 15.55, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 18:46', 27.75, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 14:31', 47.83, 228);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 19:27', 46.07, 184);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 21:36', 3.76, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 15:56', 87.16, 144);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 17:03', 4.39, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 8:47', 96.53, 43);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 0:28', 51.2, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 17:02', 73.0, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 13:03', 56.45, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 23:57', 70.33, 66);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 11:14', 81.04, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 6:13', 88.35, 207);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 1:15', 27.4, 42);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 20:47', 40.34, 40);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 6:25', 43.96, 128);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 18:44', 34.68, 140);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 1:04', 25.02, 239);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 23:34', 96.91, 128);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 10:58', 53.3, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 11:16', 55.3, 9);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 18:02', 90.62, 167);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 20:48', 84.26, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 11:20', 49.9, 218);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 16:30', 23.69, 72);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 7:20', 96.51, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 13:23', 51.61, 213);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 18:50', 91.93, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 2:46', 53.15, 128);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 16:28', 79.95, 197);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 13:44', 82.04, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 19:37', 26.6, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:17', 71.74, 239);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 13:53', 55.86, 160);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 10:41', 69.55, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 18:30', 89.54, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 3:20', 35.45, 228);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 1:05', 80.88, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 23:05', 34.36, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 9:47', 45.16, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 2:43', 55.16, 6);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 9:02', 36.06, 105);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 10:00', 60.06, 243);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 18:19', 10.96, 68);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 15:26', 56.66, 11);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 9:23', 34.46, 122);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 1:23', 74.33, 98);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 6:40', 50.77, 100);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 13:29', 93.13, 244);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 2:42', 14.68, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 17:24', 22.89, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 16:00', 66.54, 215);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 19:50', 33.47, 51);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 13:27', 21.1, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 13:23', 86.87, 20);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 14:56', 23.21, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 2:25', 23.53, 149);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 15:41', 30.41, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:31', 92.84, 122);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 12:13', 40.38, 86);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 1:16', 92.33, 163);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 7:49', 97.23, 124);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 20:45', 82.53, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 0:21', 30.7, 24);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 17:33', 23.08, 145);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 23:01', 48.89, 31);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 3:15', 79.14, 72);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 9:01', 37.55, 33);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 18:54', 71.07, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 4:26', 46.52, 96);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 14:52', 37.94, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 2:46', 24.35, 112);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 4:48', 15.26, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 2:35', 38.6, 6);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 16:12', 9.97, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:02', 92.15, 232);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 3:41', 92.38, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 19:50', 42.79, 46);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:18', 39.59, 172);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 22:24', 88.9, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 21:39', 40.37, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 7:41', 75.09, 54);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 2:38', 65.34, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 19:21', 33.11, 207);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 6:44', 38.13, 68);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 7:03', 17.47, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 20:14', 60.75, 57);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 19:43', 38.31, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 16:32', 73.64, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 22:04', 82.49, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 13:25', 20.97, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 1:05', 56.79, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:03', 19.96, 193);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 22:12', 3.47, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 7:19', 79.34, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 23:01', 55.01, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 8:04', 89.53, 229);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 9:28', 51.25, 46);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 1:25', 23.94, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 15:47', 51.11, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 5:00', 65.97, 233);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 22:41', 48.92, 233);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 15:24', 25.14, 100);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 12:18', 83.19, 239);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 9:16', 2.34, 64);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 0:20', 72.82, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 21:22', 47.88, 149);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 20:00', 45.77, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 22:09', 25.72, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:46', 80.46, 122);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/15/2024 6:33', 63.01, 112);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 19:28', 23.57, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 1:52', 46.09, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 5:53', 7.29, 105);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:22', 78.34, 51);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 11:26', 7.24, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 4:03', 86.71, 148);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:26', 93.31, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 13:26', 68.14, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 5:40', 80.72, 157);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 14:56', 39.28, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 5:32', 72.79, 115);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 23:32', 76.19, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:17', 66.44, 176);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 23:07', 31.12, 102);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 7:38', 1.52, 27);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 7:08', 9.7, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 7:16', 7.82, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 5:19', 36.51, 236);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 6:37', 59.3, 89);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 15:39', 32.93, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 17:22', 4.48, 135);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 21:18', 97.41, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 18:40', 92.08, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 13:55', 83.03, 165);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 19:31', 66.2, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 11:25', 67.82, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 6:37', 68.15, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 10:15', 46.61, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 3:40', 83.2, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:45', 20.16, 152);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 19:48', 36.42, 237);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 18:52', 39.65, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 0:22', 72.4, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 14:35', 12.25, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 10:39', 25.13, 122);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 1:49', 53.99, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 1:25', 61.13, 52);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 5:15', 26.27, 88);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 0:19', 26.14, 191);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 13:29', 40.32, 145);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 16:08', 72.72, 201);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 7:27', 42.12, 241);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 15:05', 63.84, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 23:58', 2.95, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 19:59', 98.64, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 19:33', 21.3, 117);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 3:57', 64.29, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 14:08', 27.13, 11);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 15:48', 75.41, 144);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 3:31', 56.08, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:19', 67.04, 56);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 21:27', 84.95, 191);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 16:44', 55.18, 111);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 19:20', 39.37, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 3:50', 12.55, 231);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 21:52', 93.69, 51);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 9:49', 34.48, 40);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 18:37', 62.48, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 4:02', 42.22, 236);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 3:00', 18.25, 68);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 19:50', 51.32, 67);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 8:57', 64.09, 86);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 6:02', 39.86, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 5:12', 94.0, 161);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 23:56', 70.42, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 14:44', 44.26, 27);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 23:55', 67.47, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 21:14', 47.67, 75);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 2:46', 77.78, 46);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 21:12', 94.97, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 20:35', 53.72, 243);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 15:59', 6.05, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 21:42', 24.37, 187);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 9:38', 68.22, 10);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 2:14', 55.65, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 8:42', 66.63, 201);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 12:56', 15.21, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 23:27', 7.86, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 22:45', 83.74, 113);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 14:21', 66.92, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 16:30', 26.48, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 2:54', 53.29, 181);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 7:57', 42.62, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 9:00', 23.44, 183);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 1:18', 8.4, 105);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 20:28', 95.88, 127);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 23:50', 41.17, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 12:49', 41.2, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 9:11', 12.56, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 1:01', 7.42, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 14:49', 10.66, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 21:57', 88.4, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 6:39', 6.69, 118);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 11:20', 45.91, 73);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 18:26', 2.53, 213);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 20:07', 30.13, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 18:41', 33.23, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 9:43', 87.87, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 21:34', 40.26, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 16:29', 55.48, 152);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 15:41', 5.34, 111);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 6:41', 66.22, 69);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 17:41', 80.79, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 21:36', 28.98, 10);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 23:20', 39.71, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 9:48', 73.33, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/26/2024 22:45', 93.34, 235);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:12', 75.67, 158);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 2:03', 1.01, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 6:35', 44.8, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 5:07', 18.2, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 13:02', 71.71, 189);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 20:08', 40.06, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/10/2024 6:37', 86.59, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:34', 54.01, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 16:46', 42.34, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 0:29', 17.03, 120);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 21:01', 22.1, 142);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 3:10', 43.71, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 20:41', 30.79, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 14:09', 65.71, 236);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 15:32', 61.47, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 15:30', 83.52, 137);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 21:44', 35.51, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:24', 64.91, 239);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 13:06', 45.88, 147);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:01', 83.65, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 7:49', 58.91, 20);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 12:00', 96.73, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/9/2024 15:05', 40.77, 85);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 18:08', 60.78, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 14:09', 5.6, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:45', 69.35, 28);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 20:09', 89.3, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 5:08', 72.45, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/6/2024 6:44', 52.12, 115);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 6:09', 11.21, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 17:51', 90.27, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 15:00', 60.26, 181);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 13:43', 97.6, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/24/2024 15:33', 59.32, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 11:11', 7.04, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/22/2024 2:00', 50.54, 86);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/17/2024 0:09', 39.34, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 14:36', 83.55, 83);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 22:21', 47.63, 54);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 5:14', 49.52, 49);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 23:00', 7.41, 158);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 9:05', 15.2, 172);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:00', 38.84, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 10:55', 1.21, 95);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 4:39', 22.19, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 9:12', 56.13, 210);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 1:42', 31.61, 3);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/25/2024 0:52', 63.47, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 1:17', 38.47, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/20/2024 3:40', 44.39, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 0:03', 57.59, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/21/2024 18:44', 53.08, 115);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 16:22', 14.47, 112);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 14:48', 65.36, 51);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 15:36', 88.24, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 12:57', 68.87, 42);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/23/2024 2:35', 19.52, 73);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/12/2024 13:41', 21.53, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 3:11', 75.5, 205);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 18:06', 77.13, 194);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 21:19', 21.95, 140);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/3/2024 7:13', 86.34, 26);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/19/2024 16:45', 64.19, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/13/2024 5:29', 22.91, 51);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/7/2024 6:23', 98.7, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/16/2024 23:03', 58.26, 246);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/27/2024 22:37', 62.29, 185);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:23', 85.32, 116);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/14/2024 14:45', 15.19, 16);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/30/2024 14:32', 16.05, 104);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:52', 70.13, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 1:06', 45.34, 26);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 14:51', 81.4, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 12:39', 87.56, 249);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/4/2024 14:14', 30.24, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 0:38', 29.13, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/8/2024 17:53', 1.08, 63);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/2/2024 4:33', 65.48, 27);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/1/2024 10:44', 95.58, 212);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 1:21', 13.15, 140);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/5/2024 21:57', 16.55, 35);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/18/2024 17:58', 62.56, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/11/2024 4:05', 95.75, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:14', 69.19, 156);
go
insert into Webovyucet (Heslohash, Jmeno, Typuctu)
values ('$2a$10$eKQQYAPTFJDXD6lq76cH1OFSEsBxZDbD9G9Ju.jVSpZPX8TjuO3IO', 'admin', 'admin')