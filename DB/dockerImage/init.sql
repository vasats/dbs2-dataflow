create database energie
go
use energie
go

CREATE TABLE [Adresa]
(
    [Cislopopisne] char(10) NOT NULL,
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
    [Casdo] time(5) NULL,
    [Casod] time(5) NOT NULL,
    [Datumod] date NOT NULL,
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
    WITH PASSWORD = 'nj4658g465huisca';
GO

CREATE PROCEDURE updateSmenaInclusion @ZamestnanecIDtoCheck int, @SmenaIdToCheck int, @HalaIdToCheck int
AS
    if (@ZamestnanecIDtoCheck not in (SELECT T.ZamestnanecID
        from Seznamzamestnancusmeny T
        where T.HalaID=@HalaIdToCheck and T.SmenaID=@SmenaIdToCheck))

        Insert into Seznamzamestnancusmeny (HalaID, ZamestnanecID, SmenaID)
         values (@HalaIdToCheck, @ZamestnanecIDtoCheck, @SmenaIdToCheck)
go

CREATE TRIGGER newUse ON Zaznamopouziti
    instead of INSERT AS
    Begin TRANSACTION;

    Declare @HalaID as int;
    set @HalaID = (select Z.HalaID from Zarizeni Z where Z.ZarizeniID = inserted.ZarizeniID);
    Declare @SmenaID as int;

    updateSmenaInclusion ZamestnanecID, @SmenaID, @HalaID







insert into Webovyucet (Heslohash, Jmeno, Typuctu)
values ('$2a$10$eKQQYAPTFJDXD6lq76cH1OFSEsBxZDbD9G9Ju.jVSpZPX8TjuO3IO', 'testJmeno1', 'testTyp1')