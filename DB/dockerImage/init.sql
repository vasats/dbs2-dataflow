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

CREATE TABLE [Mesto]
(
    [Psc] char(5) PRIMARY KEY NOT NULL,
    [Mesto] varchar(50) NOT NULL
)

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
go
create procedure insertZamestnanecAdresa @jmeno varchar(40), @prijmeni varchar(40),@telefon char(12),
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

go

CREATE TRIGGER newUse ON Zaznamopouziti
    instead of INSERT AS
    begin
        insert into Seznamzamestnancusmeny (HalaID, ZamestnanecID, SmenaID)
        select Z.HalaID,I.ZamestnanecID,S.SmenaID from inserted I
                                       inner join Smena S on I.Datumcas between S.Casod and S.Casdo
                                       inner join Zarizeni Z on Z.ZarizeniID=I.ZarizeniID
        where not exists (select S2.HalaID,S2.ZamestnanecID,S2.SmenaID from Seznamzamestnancusmeny S2
                    where S2.ZamestnanecID = I.ZamestnanecID and S2.SmenaID = S.SmenaID and S2.HalaID = Z.HalaID);

        insert into Zaznamopouziti (Datumcas, ZamestnanecID, ZarizeniID)
        select I.Datumcas,I.ZamestnanecID,I.ZarizeniID from inserted I
                                        inner join Smena S on I.Datumcas between S.Casod and S.Casdo
                                        inner join Zarizeni Z on Z.ZarizeniID=I.ZarizeniID;
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

SELECT SUM(spotreba) AS celkova_spotreba
FROM ZaznamOSpotrebe;
 go
CREATE FUNCTION CelkovaCenaSpotreby(@id int)
    RETURNS float
AS
BEGIN
    DECLARE @CelkovaCena float;
    SELECT @CelkovaCena = SUM(zaznamOSpotrebe.Spotreba * T.CenaZaKWh)
    FROM Zaznamospotrebe
             INNER JOIN Zarizeni Z on Zaznamospotrebe.ZarizeniID = Z.ZarizeniID
             INNER JOIN dbo.Hala H on Z.HalaID = H.HalaID
             INNER JOIN dbo.Tovarna T on T.TovarnaID = H.TovarnaID
    where T.TovarnaID = @id

    if @CelkovaCena IS NULL
        return 0
    RETURN @CelkovaCena;
END;
go
insert into Mesto (Psc, Mesto)
values ('55102', N'Jaroměř'),
       ('10000', N'Praha'),
       ('60200', N'Brno'),
       ('70200', N'Ostrava'),
       ('30100', N'Plzeň'),
       ('46001', N'Liberec'),
       ('77900', N'Olomouc'),
       ('37001', N'České Budějovice'),
       ('50002', N'Hradec Králové'),
       ('53002', N'Pardubice')
go

insert into Smena (Casod, Casdo) values ('3/27/2024 22:00', '3/28/2024 6:00');
insert into Smena (Casod, Casdo) values ('3/28/2024 6:00', '3/28/2024 14:00');
insert into Smena (Casod, Casdo) values ('3/28/2024 14:00', '3/28/2024 22:00');
insert into Smena (Casod, Casdo) values ('3/28/2024 22:00', '3/29/2024 6:00');
insert into Smena (Casod, Casdo) values ('3/29/2024 6:00', '3/29/2024 14:00');
insert into Smena (Casod, Casdo) values ('3/29/2024 14:00', '3/29/2024 22:00');
insert into Smena (Casod, Casdo) values ('3/29/2024 22:00', '3/30/2024 6:00');

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
insert into Adresa (Cislopopisne, Psc, Ulice) values (445, 50002, 'Sachtjen');
insert into Adresa (Cislopopisne, Psc, Ulice) values (153, 77900, 'Loftsgordon');
insert into Adresa (Cislopopisne, Psc, Ulice) values (435, 70200, 'Everett');
insert into Adresa (Cislopopisne, Psc, Ulice) values (266, 60200, 'Maple');
insert into Adresa (Cislopopisne, Psc, Ulice) values (21, 10000, 'Morrow');


go
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$qfSuOcDcSuh1IwxmPZmmdeaSJDySEokS/h4CiwsmWRsXefZfmfoR2', 'mmansfield0', 'ROLE_ADMIN');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$Lz/mm5WCFOmGOjLyBzsh9eLswz3vhQzChvAIFTzCde749T8HIeQMW', 'acockshtt1', 'ROLE_ADMIN');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$KMb7O/hoasfUwFwVr9JJDuotKgo.5W.cjEh6zG5.VXNuNE6pJiIUq', 'crealff2', 'ROLE_USER');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$bXsbfrTFmRrM/IXU3PO2q.14tEXbu5q1pT9SLFECsTVA6j3pnoiiy', 'afernyhough3', 'ROLE_USER');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$odFPmI6b3AYG9YwYqUGzVOxux/8x4m5GV.12ELD.9NgxwMvI8zeLi', 'smacandie4', 'ROLE_USER');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$S6q7bRABIU8l/tjHVdlww.cl.NBl5E7LRP7Br9dVKAnPswAVaFNgK', 'dportis5', 'ROLE_USER');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$jiw1wObPgH.YF8YDk8UP5e57G//B9x1mQuq6/n4kjTNJk90fTskJy', 'klockhurst6', 'ROLE_USER');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$tY8oUbn5HQnd3aGPPKCkpujwuO0HOWTSyPPd.JqXGN.aj9UUiV9.q', 'jbrunelleschi7', 'ROLE_USER');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$K5mBeljUxRhsXkXfzEEJxe0Cj5H.zHdZr5GtTfewiOmEUNoWcmxsm', 'vpleasaunce8', 'ROLE_USER');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$clsCyW845YQQtx2rDD/kQ.Ktfg3lUP9zpZMR.WuT46Iu7d7aPlG4y', 'mishchenko9', 'ROLE_USER');
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

insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:32', 85, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:56', 60, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:15', 45, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:10', 72, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:09', 93, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:25', 34, 180);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:42', 50, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:27', 15, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:02', 95, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:38', 63, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:47', 27, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:25', 54, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:46', 97, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:32', 8, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:18', 53, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:15', 74, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:19', 85, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:29', 2, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:11', 89, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:07', 49, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:45', 13, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:57', 96, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:24', 65, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:02', 14, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:52', 97, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:17', 15, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:40', 60, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:28', 12, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:07', 79, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:32', 31, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:35', 21, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:03', 50, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:49', 9, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:28', 94, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:59', 1, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:45', 88, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:24', 96, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:25', 45, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:32', 39, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:38', 54, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:07', 82, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:15', 95, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:22', 19, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:54', 59, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:18', 44, 57);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:49', 2, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:58', 24, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:44', 48, 55);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:27', 69, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:31', 38, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:51', 30, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:54', 10, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:44', 88, 54);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:19', 52, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:24', 67, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:45', 54, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:03', 90, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:00', 48, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:21', 62, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:45', 80, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:38', 70, 229);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:44', 45, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:20', 20, 66);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:50', 21, 178);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:08', 41, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:33', 73, 83);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:29', 93, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:41', 49, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:58', 21, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:24', 57, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:17', 3, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:19', 39, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:42', 31, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:46', 50, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:34', 77, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:43', 82, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:47', 70, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:57', 78, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:58', 11, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:42', 80, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:59', 19, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:19', 1, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:13', 43, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:38', 3, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:24', 60, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:51', 27, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:02', 3, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:27', 69, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:09', 16, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:57', 19, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:22', 4, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:56', 97, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:21', 55, 182);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:28', 25, 19);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:47', 6, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:55', 38, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:02', 55, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:49', 3, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:23', 45, 207);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:17', 32, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:56', 55, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:21', 51, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:35', 60, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:04', 64, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:45', 73, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:54', 11, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:21', 60, 52);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:41', 13, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:17', 43, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:04', 41, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:03', 35, 208);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:05', 34, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:24', 4, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:46', 73, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:32', 84, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:45', 67, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:32', 94, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:44', 73, 233);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:21', 75, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:30', 88, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:40', 12, 178);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:04', 80, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:35', 75, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:01', 19, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:33', 57, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:05', 13, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:09', 15, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:11', 29, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:56', 39, 189);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:58', 51, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:15', 95, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:24', 54, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:33', 64, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:39', 89, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:31', 56, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:30', 38, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:54', 82, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:04', 31, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:21', 58, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:36', 80, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:04', 72, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:38', 34, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:15', 14, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:13', 13, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:49', 19, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:15', 79, 117);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:21', 56, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:49', 46, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:01', 85, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:35', 90, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:53', 49, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:40', 41, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:25', 86, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:57', 23, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:32', 51, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:42', 61, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:50', 58, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:53', 66, 159);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:24', 14, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:26', 26, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:17', 86, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:08', 44, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:15', 43, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:44', 11, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:10', 90, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:33', 80, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:05', 19, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:39', 30, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:53', 21, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:05', 28, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:40', 43, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:30', 35, 206);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:51', 92, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:06', 50, 243);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:17', 68, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:46', 29, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:21', 93, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:12', 47, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:06', 80, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:31', 72, 149);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:53', 69, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:32', 71, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:16', 25, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:25', 73, 233);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:53', 99, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:31', 30, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:56', 21, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:57', 22, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:38', 98, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:41', 78, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:29', 38, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:46', 8, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:35', 36, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:20', 69, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:17', 54, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:12', 31, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:03', 14, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:50', 96, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:46', 66, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:12', 31, 233);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:31', 22, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:50', 28, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:31', 85, 87);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:58', 76, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:31', 48, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:20', 27, 159);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:18', 75, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:48', 88, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:07', 70, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:56', 38, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:47', 21, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:33', 87, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:40', 88, 46);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:19', 43, 147);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:19', 23, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:03', 82, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:47', 6, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:59', 38, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:23', 34, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:31', 19, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:08', 25, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:09', 6, 46);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:46', 1, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:49', 61, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:14', 52, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:31', 72, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:06', 53, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:46', 63, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:36', 49, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:52', 53, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:55', 19, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:43', 21, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:35', 21, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:38', 52, 212);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:03', 17, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:06', 29, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:03', 11, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:17', 97, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:20', 79, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:44', 76, 229);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:55', 39, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:07', 66, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:31', 75, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:28', 10, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:13', 8, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:01', 70, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:27', 16, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:22', 21, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:10', 22, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:55', 20, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:57', 80, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:05', 86, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:10', 6, 82);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:04', 54, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:07', 31, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:41', 68, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:18', 5, 166);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:42', 75, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:51', 84, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:05', 99, 151);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:15', 92, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:42', 89, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:10', 13, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:39', 69, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:58', 5, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:50', 42, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:15', 81, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:50', 10, 123);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:31', 5, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:55', 35, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:23', 41, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:19', 25, 11);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:19', 85, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:34', 73, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:59', 72, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:14', 85, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:11', 22, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:35', 81, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:29', 94, 178);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:28', 90, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:31', 94, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:13', 90, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:36', 44, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:41', 37, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:07', 100, 49);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:08', 52, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:08', 61, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:13', 70, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:23', 49, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:15', 13, 156);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:20', 43, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:37', 49, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:41', 4, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:24', 72, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:28', 37, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:36', 48, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:37', 92, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:52', 57, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:02', 36, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:24', 40, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:10', 34, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:45', 78, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:27', 15, 243);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:28', 61, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:02', 35, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:45', 52, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:07', 33, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:20', 91, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:45', 58, 84);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:48', 97, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:01', 53, 55);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:22', 65, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:29', 13, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:29', 55, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:49', 17, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:08', 29, 85);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:25', 82, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:20', 17, 82);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:54', 15, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:04', 18, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:27', 82, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:29', 6, 233);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:44', 31, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:01', 39, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:16', 88, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:56', 30, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:12', 76, 169);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:30', 23, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:12', 24, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:22', 27, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:45', 84, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:23', 89, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:29', 49, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:05', 30, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:02', 57, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:08', 62, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:40', 73, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:26', 65, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:54', 40, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:48', 18, 180);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:15', 98, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:53', 26, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:01', 82, 79);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:42', 78, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:52', 1, 244);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:57', 63, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:03', 73, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:45', 2, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:24', 1, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:50', 68, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:34', 20, 49);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:08', 85, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:51', 41, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:24', 48, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:35', 29, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:46', 8, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:40', 49, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:37', 79, 157);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:58', 16, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:57', 37, 82);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:25', 36, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:45', 74, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:20', 45, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:40', 12, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:31', 87, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:33', 44, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:53', 73, 24);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:50', 96, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:06', 2, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:08', 27, 21);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:32', 27, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:47', 81, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:50', 33, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:43', 21, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:06', 100, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:53', 54, 157);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:19', 30, 139);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:54', 43, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:18', 66, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:53', 46, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:48', 37, 136);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:34', 62, 208);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:44', 74, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:24', 57, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:09', 38, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:04', 87, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:12', 46, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:01', 31, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:17', 28, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:30', 70, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:05', 58, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:29', 86, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:52', 89, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:30', 92, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:24', 72, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:15', 55, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:27', 1, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:14', 81, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:36', 54, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:04', 92, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:50', 74, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:09', 20, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:48', 52, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:31', 94, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:01', 82, 149);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:27', 33, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:35', 91, 156);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:29', 27, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:15', 80, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:50', 7, 147);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:25', 70, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:02', 71, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:06', 24, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:57', 83, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:41', 96, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:24', 39, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:27', 70, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:07', 48, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:47', 7, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:48', 90, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:35', 40, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:29', 4, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:39', 47, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:11', 100, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:00', 95, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:53', 48, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:16', 99, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:38', 98, 66);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:36', 100, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:38', 88, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:57', 80, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:09', 30, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:01', 70, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:59', 66, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:30', 43, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:10', 7, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:22', 66, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:11', 62, 149);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:44', 86, 233);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:10', 34, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:24', 52, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:33', 19, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:17', 88, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:57', 20, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:44', 99, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:06', 20, 244);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:16', 43, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:37', 89, 147);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:11', 91, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:06', 85, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:45', 93, 208);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:20', 41, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:04', 89, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:48', 30, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:54', 17, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:34', 11, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:14', 29, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:08', 10, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:53', 33, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:11', 99, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:11', 52, 87);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:47', 99, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:49', 67, 151);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:08', 80, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:03', 80, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:19', 74, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:29', 69, 243);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:14', 80, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:08', 89, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:51', 48, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:16', 91, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:49', 33, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:35', 84, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:20', 75, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:40', 60, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:17', 98, 4);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:07', 21, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:11', 68, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:30', 41, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:35', 41, 85);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:54', 71, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:02', 12, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:11', 84, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:42', 6, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:17', 3, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:59', 70, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:38', 61, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:58', 27, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:07', 67, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:31', 62, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:55', 5, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:13', 30, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:34', 15, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:37', 72, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:37', 95, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:56', 22, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:51', 40, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:27', 70, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:48', 53, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:28', 17, 243);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:23', 11, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:40', 1, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:51', 96, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:01', 78, 66);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:21', 85, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:11', 66, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:01', 33, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:40', 67, 57);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:20', 47, 32);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:34', 59, 83);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:35', 62, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:41', 90, 147);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:33', 51, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:12', 31, 194);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:42', 14, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:51', 71, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:01', 9, 182);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:39', 4, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:52', 11, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:40', 80, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:47', 80, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:15', 18, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:31', 9, 219);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:44', 43, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:11', 32, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:10', 71, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:17', 63, 5);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:29', 54, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:02', 32, 149);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:44', 93, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:39', 42, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:41', 71, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:48', 100, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:05', 84, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:09', 78, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:17', 11, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:38', 26, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:41', 39, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:54', 83, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:40', 86, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:32', 70, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:56', 27, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:24', 42, 85);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:13', 35, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:25', 1, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:51', 66, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:55', 94, 57);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:46', 91, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:04', 13, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:20', 98, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:04', 54, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:26', 98, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:01', 91, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:13', 28, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:00', 7, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:41', 62, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:51', 18, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:59', 36, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:25', 75, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:55', 76, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:23', 74, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:27', 78, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:47', 95, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:04', 54, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:09', 58, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:07', 68, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:46', 55, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:01', 34, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:24', 60, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:06', 69, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:01', 100, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:51', 35, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:11', 25, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:16', 56, 231);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:18', 91, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:38', 54, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:58', 37, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:38', 3, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:26', 4, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:47', 47, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:13', 70, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:41', 100, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:28', 3, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:40', 76, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:14', 82, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:28', 13, 212);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:46', 71, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:02', 30, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:25', 13, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:41', 79, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:59', 2, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:41', 71, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:51', 87, 179);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:11', 44, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:19', 21, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:11', 9, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:58', 40, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:21', 24, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:08', 34, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:34', 96, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:51', 34, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:51', 64, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:20', 19, 156);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:57', 86, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:56', 42, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:46', 8, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:37', 68, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:04', 72, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:46', 72, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:02', 21, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:08', 40, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:47', 43, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:48', 50, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:28', 22, 244);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:23', 21, 82);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:52', 69, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:44', 10, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:45', 99, 24);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:43', 40, 55);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:09', 36, 130);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:54', 99, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:11', 57, 49);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:03', 3, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:08', 53, 55);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:38', 7, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:46', 47, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:40', 81, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:01', 56, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:55', 24, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:13', 97, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:07', 75, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:59', 92, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:03', 55, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:02', 40, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:31', 45, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:16', 17, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:20', 74, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:00', 58, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:50', 22, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:57', 17, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:06', 76, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:13', 64, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:11', 47, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:53', 32, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:21', 56, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:51', 34, 21);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:39', 90, 81);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:01', 15, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:22', 47, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:21', 45, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:31', 25, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:24', 16, 24);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:21', 38, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:31', 45, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:15', 83, 75);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:45', 36, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:32', 38, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:50', 66, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:28', 24, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:10', 38, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:15', 33, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:28', 52, 246);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:33', 82, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:39', 88, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:43', 24, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:16', 85, 180);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:37', 94, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:44', 86, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:25', 30, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:40', 95, 162);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:57', 75, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:35', 82, 11);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:00', 80, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:39', 47, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:06', 54, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:51', 89, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:13', 38, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:56', 59, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:17', 78, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:23', 65, 136);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:01', 40, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:04', 19, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:41', 94, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:15', 79, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:18', 34, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:52', 56, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:44', 81, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:02', 31, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:38', 25, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:37', 43, 189);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:08', 37, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:25', 68, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:47', 9, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:35', 33, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:55', 2, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:48', 42, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:06', 5, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:38', 63, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:22', 92, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:36', 4, 147);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:42', 48, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:30', 54, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:45', 61, 181);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:49', 95, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:47', 21, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:37', 48, 180);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:21', 62, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:13', 90, 49);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:49', 42, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:18', 100, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:50', 59, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:53', 55, 123);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:09', 43, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:00', 21, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:27', 15, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:44', 60, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:40', 94, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:13', 22, 182);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:00', 34, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:22', 99, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:52', 37, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:22', 69, 176);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:06', 65, 87);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:35', 3, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:07', 43, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:53', 26, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:15', 17, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:37', 97, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:57', 57, 83);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:46', 5, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:56', 86, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:36', 14, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:52', 38, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:42', 46, 162);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:34', 11, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:44', 5, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:26', 72, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:41', 39, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:02', 97, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:06', 11, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:45', 49, 115);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:12', 40, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:45', 62, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:39', 57, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:54', 26, 85);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:57', 39, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:23', 15, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:01', 88, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:16', 52, 52);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:13', 78, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:17', 6, 156);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:42', 6, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:16', 100, 156);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:36', 4, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:06', 10, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:48', 62, 219);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:42', 84, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:07', 73, 182);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:20', 59, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:57', 40, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:57', 94, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:54', 12, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:26', 77, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:10', 52, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:16', 92, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:51', 55, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:29', 27, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:34', 33, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:28', 98, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:13', 19, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:05', 63, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:54', 49, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:27', 92, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:03', 1, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:41', 46, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:43', 31, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:52', 90, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:30', 7, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:27', 84, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:29', 26, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:38', 18, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:03', 66, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:08', 86, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:04', 58, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:05', 93, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:30', 15, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:15', 68, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:49', 33, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:18', 99, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:32', 86, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:10', 88, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:29', 97, 162);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:51', 50, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:02', 94, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:24', 19, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:12', 74, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:39', 4, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:00', 96, 5);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:55', 27, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:13', 98, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:47', 74, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:32', 13, 52);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:50', 100, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:53', 24, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:15', 29, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:33', 59, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:57', 13, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:46', 86, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:06', 59, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:25', 50, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:40', 78, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:50', 7, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:17', 51, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:18', 40, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:52', 63, 208);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:06', 54, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:24', 53, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:28', 39, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:09', 64, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:00', 35, 189);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:20', 3, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:25', 100, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:40', 23, 19);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:46', 6, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:08', 23, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:50', 38, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:18', 28, 81);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:37', 58, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:44', 64, 139);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:38', 77, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:05', 84, 136);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:12', 50, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:18', 25, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:49', 55, 212);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:27', 15, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:12', 16, 84);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:56', 63, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:14', 7, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:06', 46, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:58', 94, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:15', 10, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:53', 27, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:37', 94, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:01', 18, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:18', 52, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:11', 28, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:47', 40, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:22', 9, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:53', 58, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:30', 44, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:58', 81, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:36', 45, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:31', 34, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:14', 13, 219);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:29', 16, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:04', 4, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:17', 10, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:02', 59, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:01', 97, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:56', 93, 182);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:22', 67, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:26', 39, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:39', 24, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:58', 88, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:50', 100, 194);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:34', 52, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:49', 63, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:28', 3, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:55', 92, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:25', 31, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:19', 73, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:02', 35, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:40', 6, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:48', 37, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:59', 83, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:15', 90, 79);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:05', 61, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:38', 62, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:41', 74, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:51', 55, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:30', 4, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:46', 9, 189);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:37', 43, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:38', 28, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:06', 63, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:09', 19, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:58', 17, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:52', 33, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:35', 70, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:56', 65, 117);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:46', 12, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:16', 3, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:53', 21, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:25', 37, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:00', 4, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:22', 73, 169);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:22', 57, 118);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:45', 39, 19);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:13', 48, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:36', 29, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:20', 1, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:51', 15, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:34', 78, 208);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:15', 97, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:39', 39, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:08', 27, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:54', 19, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:10', 57, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:39', 46, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:26', 22, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:52', 72, 229);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:46', 76, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:39', 55, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:13', 20, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:09', 20, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:00', 75, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:04', 87, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:50', 95, 123);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:00', 21, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:30', 33, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:29', 2, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:51', 16, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:54', 82, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:40', 54, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:25', 31, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:43', 6, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:07', 90, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:19', 48, 181);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:38', 36, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:25', 11, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:05', 47, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:37', 96, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:21', 19, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:33', 56, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:30', 36, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:57', 74, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:12', 33, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:11', 45, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:54', 45, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:52', 28, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:54', 43, 178);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:18', 10, 87);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:23', 24, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:15', 6, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:08', 11, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:48', 68, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:51', 89, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:59', 93, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:54', 24, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:27', 100, 70);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:05', 73, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:19', 64, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:10', 5, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:10', 23, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:33', 35, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:54', 18, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:55', 62, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:33', 77, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:38', 80, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:20', 76, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:03', 37, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:10', 82, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:37', 58, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:17', 39, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:26', 42, 154);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:45', 20, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:29', 1, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:20', 18, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:15', 63, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:19', 2, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:44', 92, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:25', 27, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:00', 81, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:50', 36, 63);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:29', 23, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:08', 28, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:59', 17, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:54', 69, 219);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:00', 68, 117);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:19', 10, 54);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:34', 35, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:36', 28, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:42', 45, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:14', 75, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:17', 11, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:10', 40, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:20', 16, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:49', 65, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:50', 75, 63);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:48', 78, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:51', 63, 246);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:35', 21, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:09', 45, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:01', 60, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:06', 19, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:07', 14, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:51', 96, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:14', 99, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:32', 22, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:00', 58, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:37', 23, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:51', 53, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:09', 44, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:10', 95, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:19', 15, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:54', 24, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:44', 96, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:22', 53, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:22', 83, 62);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:18', 87, 206);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:07', 80, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:26', 68, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:54', 9, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:18', 3, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:15', 53, 181);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:57', 34, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:37', 39, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:59', 17, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:39', 26, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:42', 69, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:42', 1, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:04', 20, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:51', 60, 244);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:11', 13, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:56', 97, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:30', 2, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:57', 5, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:24', 32, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:47', 91, 63);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:58', 70, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:08', 37, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:03', 24, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:18', 29, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:22', 36, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:58', 57, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:56', 55, 175);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:14', 22, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:24', 81, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:57', 50, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:44', 82, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:09', 12, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:06', 65, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:31', 52, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:47', 72, 84);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:07', 70, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:57', 70, 32);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:15', 92, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:14', 33, 136);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:59', 82, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:26', 75, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:59', 68, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:01', 81, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:57', 81, 87);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:02', 65, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:03', 48, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:01', 53, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:18', 38, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:43', 94, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:33', 75, 149);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:33', 29, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:55', 68, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:17', 40, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:32', 53, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:50', 74, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:37', 86, 66);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:18', 9, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:39', 25, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:56', 47, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:21', 50, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:41', 56, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:12', 38, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:16', 34, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:29', 16, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:10', 92, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:33', 17, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:24', 29, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:52', 59, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:28', 44, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:16', 10, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:42', 69, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:33', 91, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:45', 82, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:44', 98, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:45', 65, 154);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:08', 65, 21);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:06', 33, 75);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:58', 48, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:50', 12, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:13', 74, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:12', 49, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:49', 95, 57);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:09', 32, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:10', 37, 83);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:32', 44, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:49', 73, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:43', 100, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:48', 83, 57);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:30', 23, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:15', 56, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:55', 22, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:25', 20, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:18', 78, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:14', 10, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:30', 26, 117);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:15', 27, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:29', 59, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:24', 2, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:52', 33, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:45', 46, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:41', 57, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:25', 50, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:29', 76, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:34', 96, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:57', 40, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:24', 29, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:15', 34, 55);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:04', 84, 130);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:25', 98, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:24', 20, 61);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:35', 54, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:50', 76, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:39', 74, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:29', 43, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:35', 97, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:56', 67, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:06', 45, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:05', 97, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:21', 65, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:00', 97, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:59', 58, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:33', 89, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:41', 52, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:34', 16, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:34', 100, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:51', 42, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:07', 40, 147);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:43', 83, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:29', 91, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:01', 8, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:24', 100, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:28', 19, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:54', 62, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:55', 78, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:24', 70, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:14', 46, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:35', 90, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:02', 96, 123);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:45', 37, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:20', 47, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:48', 51, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:30', 64, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:58', 27, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:56', 4, 179);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:19', 79, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:48', 29, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:57', 74, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:08', 81, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:59', 94, 56);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:20', 65, 182);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:49', 8, 193);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:13', 89, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:35', 95, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:58', 38, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:53', 84, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:56', 24, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:43', 21, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:42', 65, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:59', 78, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:43', 45, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:01', 40, 233);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:21', 94, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:56', 73, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:00', 58, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:22', 13, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:04', 40, 11);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:55', 44, 169);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:24', 58, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:37', 20, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:21', 87, 208);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:42', 89, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:32', 42, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:47', 17, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:41', 46, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:24', 17, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:47', 52, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:37', 21, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:17', 79, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:07', 51, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:25', 90, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:05', 95, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:20', 93, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:44', 18, 233);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:05', 40, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:20', 48, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:05', 37, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:34', 8, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:36', 20, 231);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:25', 57, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:49', 70, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:56', 20, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:44', 5, 241);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:00', 28, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:47', 8, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:52', 45, 233);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:48', 81, 180);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:11', 52, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:43', 98, 128);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:58', 88, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:57', 43, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:24', 96, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:37', 51, 214);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:51', 9, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:07', 78, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:04', 64, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:11', 71, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:22', 24, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:14', 92, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:13', 75, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:14', 44, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:10', 91, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:18', 96, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:35', 14, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:19', 42, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:45', 12, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:37', 56, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:11', 64, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:21', 28, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:35', 57, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:17', 27, 128);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:48', 25, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:33', 92, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:35', 94, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:02', 71, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:10', 44, 19);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:55', 63, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:37', 18, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:45', 98, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:16', 98, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:33', 45, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:06', 74, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:31', 96, 4);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:45', 90, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:57', 96, 61);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:21', 24, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:33', 62, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:27', 84, 11);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:57', 4, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:08', 71, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:51', 41, 123);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:08', 94, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:27', 81, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:17', 86, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:53', 25, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:21', 48, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:18', 63, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:48', 14, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:23', 53, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:29', 88, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:11', 35, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:42', 21, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:23', 98, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:53', 31, 195);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:43', 57, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:12', 51, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:52', 63, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:18', 46, 229);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:08', 17, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:30', 77, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:05', 82, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:25', 69, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:58', 25, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:58', 15, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:29', 37, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:22', 81, 32);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:35', 42, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:01', 40, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:10', 55, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:13', 100, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:37', 52, 229);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:11', 84, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:21', 76, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:39', 25, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:03', 99, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:03', 39, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:10', 85, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:31', 82, 79);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:32', 34, 49);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:30', 35, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:05', 82, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:00', 63, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:50', 87, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:38', 55, 154);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:02', 65, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:31', 58, 159);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:48', 18, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:40', 65, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:08', 33, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:38', 12, 212);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:36', 25, 56);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:57', 9, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:22', 59, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:01', 61, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:49', 38, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:48', 69, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:22', 37, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:27', 62, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:03', 76, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:36', 39, 21);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:19', 41, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:39', 67, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:45', 17, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:01', 20, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:02', 10, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:00', 32, 117);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:22', 90, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:00', 75, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:38', 39, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:43', 97, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:26', 4, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:56', 3, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:06', 70, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:32', 95, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:56', 91, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:29', 18, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:37', 66, 206);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:11', 35, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:30', 61, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:36', 59, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:34', 29, 83);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:46', 29, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:31', 10, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:35', 54, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:43', 76, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:37', 34, 85);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:15', 86, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:51', 29, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:10', 53, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:57', 69, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:50', 91, 244);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:26', 49, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:08', 72, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:29', 63, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:17', 20, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:52', 100, 101);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:58', 100, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:37', 37, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:37', 9, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:09', 21, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:24', 46, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:36', 58, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:32', 67, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:20', 87, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:25', 42, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:45', 30, 139);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:42', 91, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:40', 13, 156);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:54', 59, 169);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:53', 52, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:30', 19, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:39', 45, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:27', 29, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:38', 8, 10);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:16', 89, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:16', 74, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:44', 42, 61);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:19', 4, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:44', 56, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:02', 61, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:25', 33, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:51', 62, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:47', 100, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:54', 64, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:35', 23, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:44', 4, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:05', 8, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:48', 67, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:38', 82, 159);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:51', 42, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:14', 67, 229);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:58', 35, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:46', 96, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:52', 85, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:48', 77, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:55', 44, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:56', 3, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:48', 76, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:22', 20, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:44', 67, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:56', 46, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:59', 97, 54);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:38', 94, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:43', 29, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:33', 49, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:45', 12, 73);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:04', 84, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:54', 85, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:42', 82, 105);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:59', 29, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:59', 42, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:13', 49, 4);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:18', 83, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:29', 80, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:38', 58, 139);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:22', 6, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:53', 100, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:08', 30, 151);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:09', 17, 166);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:37', 18, 178);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:49', 19, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:47', 37, 4);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:50', 33, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:22', 17, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:29', 28, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:22', 7, 179);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:29', 99, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:16', 58, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:01', 4, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:47', 88, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:54', 87, 121);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:06', 94, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:00', 26, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:17', 96, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:28', 91, 15);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:40', 85, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:32', 65, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:05', 31, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:32', 23, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:31', 73, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:35', 16, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:22', 4, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:35', 25, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:56', 97, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:49', 66, 65);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:38', 76, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:39', 82, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:54', 40, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:28', 22, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:04', 17, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:43', 74, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:07', 30, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:00', 26, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:53', 34, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:47', 48, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:48', 100, 154);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:45', 37, 212);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:54', 62, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:22', 5, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:05', 19, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:48', 85, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:56', 14, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:19', 40, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:42', 4, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:43', 88, 227);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:39', 85, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:03', 62, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:58', 31, 46);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:37', 34, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:05', 92, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:40', 85, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:37', 38, 54);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:54', 96, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:36', 97, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:52', 51, 123);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:14', 98, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:16', 100, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:41', 28, 181);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:40', 78, 66);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:25', 47, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:31', 18, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:17', 43, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:29', 64, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:04', 72, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:19', 46, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:46', 21, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:00', 96, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:38', 32, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:42', 41, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:49', 57, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:10', 51, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:32', 43, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:01', 41, 133);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:13', 10, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:11', 85, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:57', 3, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:30', 12, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:24', 32, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:01', 50, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:10', 6, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:30', 42, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:51', 9, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:35', 24, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:12', 42, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:49', 53, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:34', 86, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:02', 81, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:59', 52, 11);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:01', 87, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:17', 86, 36);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:30', 28, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:29', 52, 183);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:43', 94, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:47', 99, 147);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:44', 98, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:09', 44, 56);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:04', 88, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:47', 11, 140);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:30', 57, 79);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:43', 80, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:12', 82, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:28', 84, 246);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:43', 20, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:55', 7, 21);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:47', 39, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:39', 62, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:49', 17, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:13', 53, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:19', 9, 182);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:07', 92, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:31', 71, 219);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:04', 71, 152);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:15', 83, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:27', 17, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:47', 31, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:53', 82, 244);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:16', 38, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:14', 42, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:55', 18, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:19', 30, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:49', 76, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:01', 71, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:10', 62, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:43', 9, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:30', 58, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:16', 86, 249);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:40', 29, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:40', 58, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:01', 14, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:24', 55, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:24', 31, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:16', 47, 178);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:44', 60, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:21', 23, 54);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:11', 24, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:36', 69, 176);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:35', 31, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:04', 87, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:42', 29, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:17', 12, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:09', 97, 182);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:03', 84, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:56', 35, 84);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:52', 1, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:34', 43, 155);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:08', 56, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:44', 14, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:05', 28, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:43', 47, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:37', 17, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:48', 81, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:09', 10, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:46', 78, 42);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:58', 6, 91);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:10', 79, 128);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:54', 16, 28);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:29', 37, 24);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:02', 21, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:50', 70, 202);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:51', 83, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:55', 98, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:46', 95, 236);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:32', 29, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:05', 6, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:21', 82, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:09', 62, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:27', 58, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:01', 72, 127);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:01', 82, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:15', 98, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:26', 20, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:22', 55, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:49', 46, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:45', 52, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:07', 40, 117);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:15', 56, 207);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:40', 17, 156);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:52', 69, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:07', 94, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:51', 61, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:40', 93, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:05', 1, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:29', 28, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:47', 29, 244);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:17', 86, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:26', 58, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:26', 96, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:07', 43, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:23', 60, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:00', 79, 122);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:04', 45, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:01', 31, 231);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:33', 81, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:53', 92, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:17', 81, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:29', 2, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:51', 26, 52);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:17', 67, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:24', 86, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:50', 40, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:23', 43, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:46', 59, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:59', 25, 212);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:07', 24, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:14', 30, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:13', 50, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:30', 100, 142);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:27', 82, 40);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:13', 74, 119);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:09', 44, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:12', 25, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:52', 59, 83);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:26', 34, 83);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:29', 76, 170);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:32', 50, 5);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:27', 60, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:05', 84, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:01', 61, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:01', 52, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:56', 86, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:05', 57, 126);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:46', 53, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:30', 72, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:01', 82, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:21', 17, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:59', 27, 48);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:24', 38, 156);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:31', 75, 231);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:08', 23, 43);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:39', 24, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:11', 88, 100);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:22', 80, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:56', 78, 102);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:59', 96, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:16', 7, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:38', 77, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:16', 81, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:25', 52, 230);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:31', 98, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:11', 9, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:53', 66, 24);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:52', 11, 211);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:39', 83, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:19', 36, 56);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:36', 71, 145);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:40', 3, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:20', 16, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:32', 75, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:39', 78, 4);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:57', 97, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:14', 36, 95);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:03', 36, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:36', 47, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:20', 31, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:11', 81, 23);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:13', 91, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:22', 18, 231);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:05', 19, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:48', 12, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:03', 42, 207);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:25', 34, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:57', 77, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:47', 89, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:32', 15, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:00', 70, 31);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:32', 55, 178);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:17', 26, 116);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:31', 62, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:03', 26, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:45', 16, 51);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:23', 31, 223);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:34', 1, 243);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:25', 16, 171);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:49', 85, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:05', 85, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:20', 94, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:33', 14, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:25', 32, 139);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:44', 3, 157);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:16', 79, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:39', 64, 109);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:12', 54, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:32', 45, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:43', 64, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:22', 84, 74);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:39', 81, 19);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:02', 84, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:44', 25, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:29', 65, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:20', 80, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:12', 75, 19);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:33', 37, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:27', 37, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:38', 33, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:43', 89, 163);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:12', 48, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:39', 40, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:07', 40, 197);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:35', 74, 92);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:15', 23, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:25', 16, 147);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:36', 26, 137);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:25', 76, 44);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:15', 2, 18);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:00', 85, 180);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:08', 98, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:53', 96, 206);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:34', 97, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:58', 44, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:36', 79, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:11', 37, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:35', 20, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:40', 24, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:28', 31, 243);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:59', 49, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:08', 67, 220);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:14', 40, 6);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:40', 46, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:11', 3, 94);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:29', 70, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:17', 63, 63);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:37', 51, 52);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:44', 85, 143);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:01', 100, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:59', 40, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:41', 68, 134);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:14', 70, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:19', 89, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:52', 75, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:02', 95, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:10', 17, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:41', 85, 198);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:00', 82, 177);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:31', 62, 224);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:36', 27, 61);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:40', 75, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:09', 56, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:56', 51, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:02', 24, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:16', 17, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:01', 45, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:07', 63, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:54', 58, 234);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:23', 63, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:55', 32, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:49', 31, 228);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:16', 16, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:51', 70, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:50', 36, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:22', 16, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:55', 81, 75);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:06', 98, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:45', 20, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:11', 96, 12);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:27', 7, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:49', 5, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:11', 67, 147);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:48', 17, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:08', 8, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:57', 70, 167);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:16', 77, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:41', 56, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:23', 38, 82);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:57', 86, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:34', 85, 244);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:50', 15, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:32', 44, 164);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:46', 15, 226);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:44', 14, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:00', 2, 90);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:27', 46, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:09', 38, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:38', 22, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:04', 74, 225);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:05', 18, 3);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:04', 29, 4);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:26', 32, 49);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:39', 26, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:11', 97, 148);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:57', 22, 38);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:22', 70, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:41', 5, 204);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:30', 30, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:37', 96, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:22', 19, 129);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:53', 60, 190);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:21', 64, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:42', 86, 13);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:56', 81, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:58', 97, 188);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:16', 87, 247);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:28', 19, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:28', 67, 52);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:12', 82, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:39', 86, 158);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:53', 2, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:59', 78, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:40', 31, 98);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:34', 83, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:04', 76, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:39', 55, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:01', 15, 60);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:03', 57, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:04', 31, 14);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:31', 62, 16);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:30', 62, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 21:38', 96, 160);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:24', 94, 124);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:52', 53, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:50', 56, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:16', 57, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:15', 73, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:15', 6, 209);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:21', 55, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:38', 33, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:39', 77, 1);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:51', 85, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:51', 56, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:46', 56, 19);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:27', 47, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:32', 8, 24);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:30', 56, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:51', 85, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:45', 62, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:49', 7, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:37', 89, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:00', 76, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:36', 37, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:08', 97, 33);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:49', 7, 174);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:47', 20, 63);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:12', 20, 26);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:43', 27, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:22', 36, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:27', 80, 194);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:27', 53, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:16', 15, 238);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:46', 20, 86);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:45', 21, 69);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:30', 56, 240);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:35', 20, 181);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:48', 6, 222);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:48', 51, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:58', 91, 203);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:49', 90, 55);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:22', 74, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:07', 62, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:36', 85, 138);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:21', 67, 150);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:09', 77, 166);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:20', 89, 146);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:54', 3, 242);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:42', 6, 154);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:18', 11, 110);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:59', 66, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:58', 14, 187);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:34', 66, 131);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 22:59', 58, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:05', 75, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:01', 98, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:32', 43, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:11', 26, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:15', 35, 21);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:26', 86, 21);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:13', 7, 207);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 2:19', 95, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:10', 24, 161);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:51', 59, 180);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:45', 12, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:14', 28, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:07', 98, 71);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:02', 75, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:44', 8, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:02', 57, 9);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:59', 99, 58);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:03', 99, 30);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:22', 56, 8);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:08', 30, 239);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 6:47', 18, 80);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:56', 11, 144);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:05', 90, 99);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:13', 75, 199);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:50', 76, 200);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:43', 63, 168);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:42', 87, 25);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:48', 22, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 19:29', 65, 217);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:31', 92, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:19', 15, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:17', 96, 130);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 0:28', 100, 210);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:15', 86, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:52', 78, 77);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:01', 2, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:11', 27, 56);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:57', 99, 235);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:48', 47, 93);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:05', 21, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:49', 97, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:39', 66, 72);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 5:00', 15, 20);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:32', 93, 141);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:09', 92, 185);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:38', 23, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:09', 73, 81);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:36', 42, 106);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 7:23', 98, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:57', 61, 55);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:59', 62, 159);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:53', 27, 57);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 6:36', 57, 114);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:04', 32, 191);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:22', 33, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:42', 92, 184);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:49', 31, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 20:27', 24, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 16:14', 100, 76);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:12', 28, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:02', 51, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:25', 53, 67);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:01', 41, 196);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:40', 45, 231);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:39', 6, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 9:58', 33, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:05', 91, 78);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:56', 4, 5);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:58', 15, 39);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:08', 31, 29);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:10', 97, 50);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 15:21', 57, 135);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 2:24', 96, 7);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 23:51', 43, 45);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:30', 22, 216);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:07', 80, 53);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 4:58', 3, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:44', 65, 55);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:08', 63, 22);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:05', 98, 112);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:36', 87, 24);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 19:04', 31, 107);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 8:44', 49, 221);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:20', 88, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:01', 81, 231);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 17:10', 35, 120);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:14', 73, 88);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:33', 28, 41);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:29', 59, 176);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 10:11', 27, 250);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:15', 29, 237);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:58', 14, 64);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 14:29', 21, 35);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:15', 89, 173);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:41', 7, 206);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 18:03', 60, 172);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 10:27', 6, 125);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 11:12', 13, 113);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 18:28', 75, 215);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 20:59', 50, 232);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:21', 75, 111);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:16', 62, 108);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:09', 2, 17);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 16:20', 36, 59);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:03', 84, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 13:23', 18, 47);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 8:59', 29, 103);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:58', 92, 153);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:45', 43, 97);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 15:08', 10, 181);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 17:25', 41, 186);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:19', 73, 132);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:30', 77, 89);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:36', 11, 46);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 3:48', 13, 27);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:18', 9, 96);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 12:33', 23, 139);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 13:53', 68, 34);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 4:02', 14, 201);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 9:36', 64, 2);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 22:03', 96, 151);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 1:55', 67, 213);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 3:46', 75, 37);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:37', 88, 219);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 5:49', 8, 165);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 12:05', 5, 68);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:48', 77, 218);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 0:17', 87, 192);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 14:24', 53, 245);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/29/2024 21:36', 43, 84);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 11:24', 50, 104);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 23:28', 44, 248);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 1:38', 17, 205);
insert into ZaznamOPouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('3/28/2024 7:36', 72, 133);



go
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:59', 64.68, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:47', 62.45, 93);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:16', 1.39, 173);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:04', 88.32, 128);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:13', 24.75, 238);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:12', 25.0, 42);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:59', 21.35, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:33', 28.37, 81);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:28', 99.05, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:05', 25.5, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:37', 28.11, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:12', 14.95, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:27', 65.38, 210);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:09', 83.01, 230);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:51', 73.27, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:09', 22.08, 165);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:45', 96.73, 129);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:50', 5.41, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:14', 43.77, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:12', 95.99, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:23', 56.93, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:19', 91.64, 11);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:51', 50.6, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:05', 26.05, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:35', 72.02, 168);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:36', 50.81, 62);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:17', 60.77, 122);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:53', 78.72, 31);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:13', 19.19, 127);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:50', 86.53, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:43', 90.52, 152);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:13', 90.01, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:31', 83.34, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:50', 25.92, 7);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:09', 87.99, 230);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:27', 74.94, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:05', 35.33, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:34', 58.69, 96);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:10', 76.49, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:20', 21.4, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:03', 7.75, 129);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:04', 94.86, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:46', 92.06, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:31', 94.56, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:12', 51.92, 108);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:20', 40.14, 160);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:57', 34.75, 50);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:08', 48.58, 171);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:44', 16.12, 81);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:49', 17.73, 243);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:27', 28.13, 187);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:22', 71.55, 130);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:39', 64.77, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:01', 39.04, 35);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:52', 76.18, 87);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:03', 32.66, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:09', 1.9, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:34', 21.03, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:26', 59.97, 69);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:01', 62.8, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:21', 38.94, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:42', 60.86, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:35', 57.15, 72);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:39', 86.73, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:04', 44.89, 66);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:39', 45.68, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:27', 91.52, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:52', 4.49, 173);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:50', 19.78, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:43', 36.08, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:34', 2.73, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:57', 99.0, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:16', 81.83, 54);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:53', 48.98, 73);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:53', 55.95, 113);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:34', 5.67, 8);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:13', 45.05, 150);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:30', 60.06, 6);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:20', 42.53, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:41', 94.21, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:39', 73.51, 226);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:08', 57.94, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:53', 47.89, 111);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:57', 64.01, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:30', 86.12, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:12', 23.47, 201);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:46', 5.66, 226);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:59', 76.28, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:17', 32.41, 247);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:10', 62.57, 109);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:02', 99.4, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:20', 55.59, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:05', 56.87, 107);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:27', 6.24, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:48', 29.23, 204);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:04', 73.73, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:16', 11.69, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:39', 79.55, 179);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:01', 60.82, 196);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:03', 27.49, 112);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:29', 22.26, 163);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:07', 87.54, 207);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:00', 49.85, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:46', 98.03, 127);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:29', 16.42, 156);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:52', 23.68, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:43', 3.43, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:48', 22.97, 59);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:31', 66.79, 89);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:22', 84.44, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:26', 9.76, 44);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:05', 72.54, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:32', 3.64, 124);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:13', 94.67, 59);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:19', 60.18, 155);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:27', 34.39, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:08', 66.17, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:17', 74.63, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:05', 6.05, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:29', 40.32, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:09', 27.18, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:11', 31.39, 22);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:25', 60.27, 90);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:26', 33.87, 247);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:02', 39.62, 12);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:29', 46.04, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:16', 55.34, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:07', 79.88, 20);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:13', 3.25, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:18', 35.28, 249);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:35', 72.64, 54);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:03', 17.21, 169);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:31', 33.54, 138);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:34', 69.31, 22);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:08', 22.17, 27);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:30', 15.1, 90);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:13', 90.32, 140);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:28', 97.31, 150);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:59', 36.15, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:27', 41.26, 140);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:01', 31.42, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:14', 16.02, 57);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:53', 61.72, 6);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:19', 7.78, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:30', 39.72, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:50', 83.6, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:33', 13.77, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:50', 58.51, 62);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:22', 82.58, 165);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:28', 63.73, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:56', 27.55, 155);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:31', 15.13, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:46', 6.81, 36);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:03', 3.79, 102);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:23', 39.7, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:40', 45.4, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:17', 8.01, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:48', 62.79, 244);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:32', 38.29, 226);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:42', 51.36, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:25', 15.57, 155);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:13', 38.76, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:24', 24.18, 57);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:51', 66.02, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:47', 42.09, 10);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:22', 68.15, 128);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:03', 86.06, 80);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:58', 35.54, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:01', 54.95, 196);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:15', 20.59, 108);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:08', 2.01, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:01', 25.19, 105);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:45', 60.46, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:17', 50.04, 160);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:15', 63.07, 245);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:58', 99.87, 102);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:15', 52.47, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:15', 98.21, 47);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:18', 50.41, 187);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:51', 8.6, 7);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:00', 58.26, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:19', 21.59, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:35', 59.34, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:21', 31.88, 149);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:26', 86.23, 210);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:26', 58.38, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:17', 6.83, 137);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:22', 41.86, 13);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:21', 6.76, 85);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:36', 6.82, 165);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:54', 93.04, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:52', 88.61, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:02', 61.42, 202);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:36', 96.39, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:06', 32.48, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:30', 65.69, 43);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:44', 47.74, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:16', 92.43, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:48', 36.91, 156);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:56', 63.24, 211);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:22', 78.61, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:43', 21.94, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:02', 73.5, 181);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:10', 94.71, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:04', 19.83, 70);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:36', 90.9, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:06', 16.79, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:21', 37.48, 235);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:54', 15.2, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:14', 99.01, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:25', 86.91, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:48', 23.86, 217);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:18', 40.89, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:45', 51.26, 220);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:58', 34.95, 59);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:36', 54.74, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:26', 97.74, 167);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:39', 79.75, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:32', 40.09, 170);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:12', 31.38, 71);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:28', 93.43, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:14', 63.34, 116);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:32', 12.66, 55);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:56', 24.37, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:18', 59.18, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:52', 21.55, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:55', 59.4, 142);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:34', 29.35, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:37', 74.28, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:37', 98.56, 195);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:27', 49.65, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:21', 56.82, 9);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:02', 37.11, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:47', 2.83, 11);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:05', 14.74, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:48', 62.6, 165);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:09', 6.62, 159);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:29', 17.09, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:10', 80.3, 31);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:04', 72.04, 116);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:49', 36.07, 100);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:45', 33.67, 211);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:18', 5.61, 78);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:41', 67.52, 129);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:51', 56.42, 31);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:20', 42.67, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:37', 48.87, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:15', 59.02, 69);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:26', 37.18, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:35', 24.46, 138);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:43', 47.21, 70);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:44', 17.4, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:56', 70.64, 129);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:09', 56.39, 3);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:11', 6.32, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:23', 87.71, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:59', 2.61, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:35', 92.45, 2);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:39', 5.68, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:54', 16.26, 108);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:59', 29.23, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:19', 68.82, 90);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:20', 46.61, 157);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:40', 87.35, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:55', 70.84, 212);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:39', 45.76, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:55', 70.94, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:39', 62.16, 124);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:21', 89.13, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:39', 98.96, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:10', 75.97, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:02', 1.37, 238);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:52', 27.22, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:02', 90.37, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:27', 59.41, 11);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:49', 50.97, 158);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:40', 16.02, 86);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:27', 29.15, 191);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:10', 30.49, 32);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:27', 58.43, 8);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:38', 17.06, 71);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:04', 72.03, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:24', 85.01, 185);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:32', 48.34, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:45', 68.05, 187);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:33', 67.54, 9);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:51', 47.65, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:29', 71.84, 120);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:37', 30.81, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:53', 72.13, 241);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:11', 38.4, 246);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:10', 22.46, 82);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:26', 94.97, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:18', 86.79, 163);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:38', 81.02, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:21', 9.9, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:58', 9.7, 89);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:51', 1.99, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:20', 86.52, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:50', 38.93, 109);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:29', 2.06, 152);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:43', 8.86, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:49', 13.77, 98);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:59', 91.12, 10);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:45', 58.25, 18);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:42', 88.76, 145);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:15', 74.12, 226);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:22', 15.56, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:14', 76.09, 89);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:34', 83.83, 43);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:45', 21.87, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:25', 36.22, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:40', 7.89, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:19', 60.08, 195);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:36', 99.28, 95);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:47', 20.36, 159);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:57', 89.53, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:53', 40.58, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:43', 8.7, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:35', 92.39, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:43', 32.6, 80);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:37', 38.12, 88);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:10', 26.2, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:12', 46.91, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:34', 41.32, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:31', 27.57, 24);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:50', 4.14, 212);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:40', 95.14, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:38', 58.32, 16);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:24', 79.66, 63);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:22', 77.34, 108);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:23', 52.37, 54);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:22', 40.3, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:59', 31.63, 159);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:53', 94.82, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:28', 23.48, 32);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:13', 75.83, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:55', 60.82, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:54', 27.96, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:11', 97.32, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:31', 20.99, 141);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:21', 33.18, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:30', 43.5, 176);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:42', 22.59, 172);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:56', 12.85, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:47', 94.53, 223);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:47', 20.42, 41);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:10', 34.08, 67);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:22', 28.86, 149);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:02', 90.48, 230);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:17', 65.57, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:38', 22.39, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:30', 95.13, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:44', 17.63, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:03', 31.62, 107);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:10', 19.64, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:12', 99.02, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:22', 93.99, 103);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:15', 12.92, 42);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:52', 99.36, 8);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:26', 59.35, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:42', 61.58, 16);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:57', 99.19, 152);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:14', 20.48, 81);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:35', 75.41, 189);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:48', 31.87, 147);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:55', 11.58, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:57', 55.11, 66);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:20', 89.88, 217);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:25', 84.44, 42);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:17', 41.9, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:08', 73.94, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:05', 82.73, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:00', 48.31, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:02', 45.2, 80);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:20', 12.54, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:22', 97.03, 82);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:26', 14.92, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:34', 96.73, 156);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:27', 31.05, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:14', 73.59, 130);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:39', 58.76, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:56', 9.39, 59);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:33', 9.81, 13);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:33', 81.86, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:43', 15.22, 191);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:28', 52.02, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:41', 79.09, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:23', 13.49, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:00', 78.63, 59);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:18', 74.5, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:14', 19.31, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:03', 89.03, 31);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:15', 17.95, 113);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:25', 73.71, 147);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:05', 8.69, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:41', 15.93, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:33', 4.28, 184);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:44', 64.19, 183);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:10', 52.49, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:53', 34.66, 50);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:30', 65.13, 87);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:38', 72.55, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:42', 28.55, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:15', 40.43, 130);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:45', 1.81, 184);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:15', 70.01, 229);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:03', 40.49, 51);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:24', 96.48, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:58', 5.95, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:26', 20.1, 189);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:01', 53.18, 10);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:29', 38.91, 194);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:59', 70.83, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:21', 42.84, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:29', 62.89, 22);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:16', 41.45, 170);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:54', 65.99, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:13', 63.77, 184);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:49', 66.21, 43);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:23', 64.79, 117);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:32', 4.9, 172);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:25', 54.22, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:18', 89.07, 68);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:23', 43.53, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:00', 73.43, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:53', 49.59, 189);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:27', 95.0, 184);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:08', 88.62, 56);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:25', 91.14, 42);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:48', 58.54, 171);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:08', 33.45, 82);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:32', 46.27, 122);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:54', 13.12, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:12', 76.43, 150);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:24', 78.59, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:21', 37.86, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:16', 11.13, 4);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:49', 88.22, 241);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:40', 34.89, 105);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:24', 8.36, 175);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:33', 25.54, 210);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:31', 65.26, 216);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:37', 30.12, 134);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:30', 6.13, 7);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:18', 82.55, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:21', 69.52, 191);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:43', 95.88, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:40', 31.32, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:24', 32.27, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:15', 97.98, 7);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:33', 12.2, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:13', 40.47, 184);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:08', 68.83, 141);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:12', 50.33, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:05', 35.66, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:56', 85.28, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:34', 8.4, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:03', 70.8, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:50', 98.33, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:42', 62.14, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:10', 3.97, 44);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:24', 58.79, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:51', 17.82, 128);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:00', 18.11, 169);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:07', 75.66, 148);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:32', 60.93, 197);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:19', 17.94, 211);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:34', 94.62, 51);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:58', 24.12, 122);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:11', 2.98, 135);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:53', 73.19, 98);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:02', 66.31, 20);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:00', 50.7, 168);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:37', 34.96, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:26', 14.32, 215);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:05', 27.38, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:44', 89.12, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:16', 96.19, 243);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:02', 95.02, 86);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:36', 23.26, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:06', 92.97, 56);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:01', 34.89, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:38', 2.64, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:40', 62.31, 229);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:07', 56.26, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:20', 13.65, 74);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:38', 47.63, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:10', 73.57, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:05', 96.4, 13);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:37', 55.16, 47);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:10', 89.07, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:32', 29.61, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:29', 25.85, 118);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:13', 9.68, 169);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:44', 13.44, 124);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:05', 13.37, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:57', 89.36, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:19', 2.72, 163);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:12', 90.44, 116);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:24', 4.29, 165);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:11', 38.43, 134);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:02', 14.35, 242);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:27', 94.63, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:21', 38.71, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:41', 86.14, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:58', 48.98, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:10', 23.96, 161);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:16', 52.69, 55);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:55', 27.94, 231);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:36', 24.39, 82);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:03', 63.45, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:51', 76.63, 155);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:13', 99.12, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:42', 74.33, 74);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:50', 88.79, 34);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:26', 54.82, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:56', 28.57, 226);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:38', 8.05, 165);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:40', 6.55, 67);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:16', 64.95, 107);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:29', 4.81, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:55', 7.43, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:04', 32.49, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:42', 97.97, 152);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:30', 54.11, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:40', 88.16, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:50', 66.92, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:52', 60.9, 197);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:39', 67.89, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:23', 80.66, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:50', 30.62, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:16', 27.04, 176);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:50', 2.51, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:22', 88.95, 87);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:21', 75.14, 147);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:43', 45.18, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:33', 8.52, 7);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:52', 16.66, 179);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:18', 81.13, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:11', 8.67, 233);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:13', 25.21, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:24', 56.6, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:13', 90.44, 195);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:57', 86.81, 32);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:14', 8.42, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:57', 67.05, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:34', 37.29, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:22', 63.46, 75);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:30', 83.72, 4);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:57', 95.59, 236);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:42', 88.06, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:02', 54.91, 96);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:49', 94.52, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:38', 5.51, 102);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:37', 81.73, 179);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:23', 70.81, 70);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:41', 77.12, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:56', 35.94, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:50', 61.08, 228);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:07', 51.04, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:30', 91.37, 244);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:36', 28.68, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:44', 60.15, 98);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:16', 10.06, 230);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:58', 37.07, 135);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:49', 16.9, 144);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:33', 19.17, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:56', 68.43, 4);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:28', 46.76, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:08', 65.28, 140);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:19', 46.45, 180);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:12', 7.92, 175);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:23', 34.63, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:31', 27.0, 115);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:26', 15.91, 217);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:03', 28.3, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:19', 26.7, 228);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:22', 44.95, 127);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:56', 64.17, 67);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:50', 1.07, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:51', 94.67, 20);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:56', 76.35, 114);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:23', 95.83, 175);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:01', 32.96, 241);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:36', 4.81, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:50', 83.06, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:19', 51.16, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:10', 14.32, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:26', 63.74, 171);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:07', 82.01, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:09', 38.0, 102);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:32', 16.6, 232);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:37', 94.57, 93);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:18', 99.59, 32);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:39', 59.73, 141);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:55', 90.92, 5);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:08', 4.88, 44);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:32', 16.98, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:07', 94.53, 191);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:31', 82.34, 83);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:01', 96.73, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:32', 94.31, 87);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:31', 39.34, 163);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:17', 18.23, 175);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:47', 46.32, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:39', 40.87, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:16', 1.68, 88);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:05', 51.04, 192);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:09', 26.74, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:07', 1.87, 4);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:05', 40.25, 168);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:19', 90.42, 176);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:58', 14.09, 122);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:18', 50.2, 57);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:03', 44.86, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:48', 40.35, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:39', 48.33, 213);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:45', 44.89, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:32', 89.6, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:32', 27.8, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:33', 8.23, 230);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:21', 47.98, 111);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:11', 98.55, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:56', 21.91, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:26', 14.7, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:24', 81.5, 211);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:43', 61.68, 167);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:07', 84.28, 18);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:05', 44.83, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:40', 44.11, 135);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:22', 34.47, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:36', 73.57, 108);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:22', 89.26, 129);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:20', 69.21, 170);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:06', 50.54, 28);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:54', 57.7, 71);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:13', 5.09, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:26', 80.12, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:10', 11.23, 135);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:32', 74.5, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:05', 77.32, 176);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:36', 65.4, 157);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:52', 54.55, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:35', 98.89, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:18', 56.32, 145);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:49', 6.58, 148);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:14', 46.78, 86);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:19', 18.27, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:43', 63.29, 168);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:25', 39.91, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:17', 42.48, 27);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:50', 9.96, 74);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:33', 49.42, 176);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:23', 32.94, 156);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:50', 74.24, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:29', 33.56, 196);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:03', 42.24, 100);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:45', 20.21, 64);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:25', 64.8, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:35', 30.32, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:57', 1.5, 115);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:33', 19.44, 79);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:07', 49.12, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:25', 93.07, 149);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:27', 89.01, 215);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:43', 8.99, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:53', 44.77, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:47', 88.88, 26);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:23', 54.39, 56);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:21', 83.58, 170);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:11', 57.38, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:57', 40.26, 152);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:18', 71.47, 115);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:13', 55.97, 73);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:36', 33.96, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:57', 65.36, 43);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:31', 74.45, 154);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:03', 58.54, 226);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:51', 89.54, 40);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:54', 74.77, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:29', 69.78, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:40', 41.09, 12);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:41', 95.38, 4);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:18', 91.77, 226);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:50', 1.7, 63);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:14', 31.92, 57);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:25', 60.04, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:56', 62.34, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:25', 58.15, 1);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:36', 16.77, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:21', 13.87, 149);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:54', 38.65, 59);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:27', 2.18, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:52', 66.57, 93);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:09', 12.95, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:10', 13.94, 98);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:49', 8.54, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:59', 41.86, 171);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:30', 94.77, 57);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:33', 64.99, 166);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:37', 63.6, 156);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:46', 94.06, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:26', 74.7, 93);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:30', 16.78, 232);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:47', 7.32, 109);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:45', 75.06, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:20', 23.48, 247);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:29', 76.73, 43);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:04', 55.94, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:11', 43.07, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:01', 28.82, 111);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:18', 19.03, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:46', 27.85, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:55', 4.66, 161);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:29', 43.37, 134);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:43', 21.51, 58);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:41', 81.98, 153);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:59', 84.76, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:47', 29.91, 35);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:17', 54.02, 148);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:19', 72.62, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:59', 31.41, 211);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:31', 76.41, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:55', 72.28, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:39', 8.0, 149);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:18', 49.76, 210);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:19', 81.14, 118);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:15', 57.25, 38);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:49', 7.7, 65);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:31', 66.24, 205);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:53', 12.55, 157);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:11', 61.38, 150);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:20', 34.85, 17);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:56', 73.52, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:08', 56.9, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:07', 13.13, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:00', 22.88, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:52', 58.66, 155);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:15', 26.92, 59);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:44', 47.44, 46);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:13', 12.93, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:10', 99.59, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:38', 35.82, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:08', 82.29, 147);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:58', 59.9, 222);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:47', 63.6, 113);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:04', 37.74, 181);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:04', 98.21, 102);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:09', 21.19, 80);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:36', 14.71, 71);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:53', 72.68, 49);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:22', 21.93, 89);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:57', 86.2, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:06', 5.68, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:43', 76.05, 18);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:53', 54.56, 250);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:47', 73.02, 187);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:18', 84.77, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:50', 9.0, 30);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:56', 60.51, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:27', 81.49, 96);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:33', 57.69, 43);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:39', 73.75, 110);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:15', 27.83, 79);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:22', 16.96, 123);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:02', 93.93, 47);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:06', 70.22, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:14', 47.66, 205);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:44', 18.06, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:03', 51.07, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:57', 13.1, 205);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:34', 91.5, 8);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:17', 56.45, 205);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:51', 84.64, 195);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:59', 79.55, 89);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 21:48', 7.03, 72);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:16', 38.01, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:21', 99.94, 220);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:22', 20.97, 213);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:22', 86.23, 138);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:31', 47.4, 219);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:05', 72.71, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:30', 35.27, 16);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:32', 55.68, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:41', 38.18, 176);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:41', 78.27, 161);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:13', 43.51, 121);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:19', 71.66, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:40', 10.54, 41);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:42', 32.06, 204);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:40', 19.11, 199);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:44', 5.61, 126);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:22', 74.19, 91);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:07', 23.43, 52);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:25', 98.41, 72);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:03', 32.09, 141);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:52', 5.66, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:37', 61.96, 13);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:34', 2.23, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:15', 81.6, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:52', 89.99, 105);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:40', 47.23, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:01', 45.82, 225);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:17', 97.58, 130);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:53', 20.07, 95);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:35', 14.34, 143);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:03', 56.65, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:41', 45.61, 195);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:11', 71.74, 56);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:34', 2.59, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:46', 92.93, 175);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:30', 7.82, 98);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:23', 11.26, 220);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:48', 99.75, 26);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:15', 90.57, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:34', 76.12, 240);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:01', 76.31, 228);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 13:54', 55.42, 66);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:17', 97.6, 78);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:23', 75.29, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:41', 9.47, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:16', 85.81, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:19', 71.98, 187);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:51', 78.84, 18);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:39', 45.84, 82);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:50', 32.14, 29);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:30', 71.01, 131);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:13', 6.65, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:47', 7.86, 125);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:41', 63.02, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:35', 50.5, 32);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:32', 40.21, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:21', 72.34, 156);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:43', 90.67, 167);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:38', 69.83, 2);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:36', 98.4, 36);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:30', 96.49, 55);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:41', 84.22, 46);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:32', 86.76, 245);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:39', 29.3, 229);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:38', 82.31, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:48', 10.65, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:27', 87.32, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:08', 90.51, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:49', 40.02, 209);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:01', 46.95, 182);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:44', 68.72, 23);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:46', 57.0, 142);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:18', 92.03, 19);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:22', 37.32, 76);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:29', 97.64, 184);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:57', 97.47, 6);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:07', 4.77, 241);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:18', 26.83, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:35', 52.91, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:01', 88.61, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:04', 11.75, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:55', 54.05, 52);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:05', 45.82, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:05', 24.48, 61);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:16', 90.96, 76);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:16', 15.99, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:41', 44.41, 243);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:29', 58.86, 158);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:59', 29.17, 97);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:27', 82.41, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:56', 50.24, 69);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:36', 6.87, 45);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 23:24', 16.59, 235);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:33', 53.78, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:57', 81.27, 180);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:59', 87.71, 195);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:41', 31.45, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:49', 78.5, 112);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:49', 38.9, 167);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 11:00', 91.82, 185);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:59', 78.04, 109);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:06', 71.84, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:43', 72.87, 193);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:32', 70.94, 145);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 13:14', 25.06, 78);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:13', 61.84, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:28', 24.93, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:27', 1.96, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:54', 24.8, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:55', 17.67, 96);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:45', 59.35, 124);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:03', 29.76, 198);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:46', 86.01, 229);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:52', 6.67, 113);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:09', 29.92, 221);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:25', 73.14, 115);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:52', 75.35, 188);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:41', 76.25, 128);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:43', 54.32, 118);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:52', 83.64, 78);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:56', 37.15, 85);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:59', 29.22, 41);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:23', 54.32, 63);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:02', 91.77, 159);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:07', 21.29, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:06', 62.49, 86);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:21', 29.42, 49);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:30', 5.51, 152);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 1:58', 79.78, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:31', 19.99, 83);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:40', 14.59, 248);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 20:19', 98.82, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:12', 22.04, 48);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:52', 86.62, 76);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:05', 86.7, 193);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:51', 31.82, 231);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:36', 21.7, 3);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:31', 76.71, 76);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:20', 91.77, 174);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:02', 75.93, 200);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 2:48', 44.81, 85);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:55', 57.86, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:23', 67.66, 194);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:37', 98.84, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:29', 69.67, 190);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:30', 48.79, 71);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:39', 43.71, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 21:33', 99.11, 178);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:36', 7.81, 75);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:30', 60.24, 66);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:57', 30.97, 247);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:07', 85.66, 146);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 1:52', 60.49, 151);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 10:43', 48.35, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:04', 85.86, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:50', 61.95, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:20', 21.15, 21);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:25', 39.64, 93);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:51', 86.39, 117);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:58', 7.85, 116);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:27', 10.82, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:43', 20.07, 133);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:42', 78.85, 106);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:10', 51.86, 184);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:44', 36.7, 49);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:09', 5.79, 139);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:20', 53.96, 119);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:57', 92.46, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 19:10', 79.44, 9);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 15:21', 91.1, 100);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 22:59', 60.06, 77);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:22', 21.25, 176);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 16:29', 25.95, 84);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:08', 87.94, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:05', 71.72, 203);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:51', 83.33, 99);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 15:21', 74.44, 56);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:07', 31.96, 145);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 19:22', 13.64, 224);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 4:47', 53.7, 94);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 10:18', 2.76, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:11', 57.78, 202);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:07', 89.63, 168);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:08', 49.13, 132);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 0:50', 72.1, 177);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 17:36', 49.96, 64);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:47', 52.86, 206);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:13', 18.75, 189);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:19', 50.18, 101);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:40', 38.22, 230);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:19', 3.73, 238);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 23:05', 81.11, 37);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 17:15', 9.19, 30);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:16', 3.46, 30);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:50', 4.63, 238);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:35', 78.51, 39);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:58', 67.75, 214);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 9:28', 60.98, 196);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 11:18', 24.87, 217);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 3:09', 42.26, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 18:28', 7.57, 15);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 7:36', 99.86, 217);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 9:56', 99.44, 104);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 18:22', 89.07, 14);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 5:19', 5.14, 186);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 12:06', 44.87, 53);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 20:11', 34.55, 159);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 6:02', 81.45, 227);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 6:49', 58.77, 116);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 5:02', 74.26, 205);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 4:15', 63.76, 49);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:48', 57.31, 32);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 8:12', 93.52, 234);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 22:37', 49.95, 92);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 7:45', 89.14, 164);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 14:47', 79.9, 78);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 2:58', 25.3, 108);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 8:57', 76.06, 162);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 0:37', 25.8, 231);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 12:47', 2.15, 25);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 14:25', 53.23, 236);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/29/2024 3:19', 7.56, 218);
insert into ZaznamOSpotrebe (Datumcas, Spotreba, ZarizeniID) values ('3/28/2024 16:54', 97.83, 42);

go
insert into Webovyucet (Heslohash, Jmeno, Typuctu)
values ('$2a$10$eKQQYAPTFJDXD6lq76cH1OFSEsBxZDbD9G9Ju.jVSpZPX8TjuO3IO', 'admin', 'ROLE_ADMIN'),
    ('$2a$10$eKQQYAPTFJDXD6lq76cH1OFSEsBxZDbD9G9Ju.jVSpZPX8TjuO3IO', 'user', 'ROLE_USER')