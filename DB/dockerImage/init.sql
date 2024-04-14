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

/*CREATE LOGIN WebServer
    WITH PASSWORD = 'Nj4658g465huisca';
GO*/

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
    Declare @DateTimeFrom as smalldatetime;
    set @DateTimefrom = CONVERT(inserted.)
    Declare @SmenaID as int;
    set @SmenaID = (select S.SmenaID from Smena S where dateadd(time,inserted.Datumcas,CONVERT(smalldatetime,S.Datumod))  and);

            updateSmenaInclusion ZamestnanecID, @SmenaID, @HalaID

    insert into Zaznamopouziti (Datumcas, ZamestnanecID, ZarizeniID)
    values(inserted.Datumcas,inserted.ZamestnanecID,inserted.ZarizeniID)
    commit transaction;
go;

CREATE VIEW spotrebaInfo
AS SELECT Zarizeni.Oznaceni,
          Zarizeni.Nazev,
          Zaznamospotrebe.Spotreba,
          Hala.HalaID,
          Zaznamospotrebe.Datumcas,
          Zaznamopouziti.ZamestnanecID
   FROM Zarizeni INNER JOIN Zaznamospotrebe
                            ON Zarizeni.ZarizeniID=Zaznamospotrebe.ZarizeniID
                 INNER JOIN Hala
                            ON Zarizeni.HalaID=Hala.HalaID
                 INNER JOIN Zaznamopouziti
                            ON Zarizeni.ZarizeniID=Zaznamopouziti.ZarizeniID
GO
/*Napsat funkci co bude scitat spotreby jednotlivych tovaren, hal, zarizeni a zaznamu o spotrebe a pronasobi to cenou/kWh a vrati celkovou cenu spotreby.*/
SELECT SUM(spotreba) AS celkova_spotreba
FROM ZaznamOSpotrebe;
 go
CREATE FUNCTION CelkovaCenaSpotreby()
    RETURNS DECIMAL(18,2)  -- Návratový datový typ je DECIMAL s přesností 18 číslic a 2 desetinnými místy
AS
BEGIN
    DECLARE @CelkovaCena DECIMAL(18,2);  -- Deklarace proměnné pro uchování celkové ceny
    -- Výpočet celkové ceny spotřeby pomocí součtu spotřeby v jednotlivých záznamech o spotřebě a ceny za kWh
    --přepsat na zaznam o spotrebe
    SELECT @CelkovaCena = SUM(zaznamOSpotrebe.Spotreba * Tovarna.CenaZaKWh)
    FROM spotrebaInfo
             INNER JOIN Tovarna ON spotrebaInfo.TovarnaID = Tovarna.TovarnaID
        AND spotrebaInfo.HalaID = Tovarna.HalaID
        AND spotrebaInfo.ZarizeniID = Tovarna.ZarizeniID
        AND spotrebaInfo.ZaznamID = Tovarna.ZaznamID;
    -- Návrat celkové ceny spotřeby
    RETURN @CelkovaCena;
END;
go

insert into Webovyucet (Heslohash, Jmeno, Typuctu)
values ('$2a$10$eKQQYAPTFJDXD6lq76cH1OFSEsBxZDbD9G9Ju.jVSpZPX8TjuO3IO', 'testJmeno1', 'testTyp1')

insert into Adresa (Cislopopisne, Psc, Ulice)
values (215,55102,N'Hradecká')


insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID)
values (2.31,'/foto1','Tovarna Panda', 1);
go


insert into Smena (Casdo, Casod, Datumod) values ('11:13 AM', '9:10 AM', '5/18/2023');
insert into Smena (Casdo, Casod, Datumod) values ('10:06 PM', '12:04 AM', '2/22/2024');
insert into Smena (Casdo, Casod, Datumod) values ('4:51 AM', '1:10 PM', '11/21/2023');
insert into Smena (Casdo, Casod, Datumod) values ('6:16 PM', '2:29 PM', '7/18/2023');
insert into Smena (Casdo, Casod, Datumod) values ('11:20 AM', '7:59 PM', '12/9/2023');
insert into Smena (Casdo, Casod, Datumod) values ('7:20 PM', '3:33 AM', '12/11/2023');
insert into Smena (Casdo, Casod, Datumod) values ('8:16 AM', '11:58 PM', '3/30/2024');
insert into Smena (Casdo, Casod, Datumod) values ('12:14 AM', '12:24 PM', '12/16/2023');
insert into Smena (Casdo, Casod, Datumod) values ('3:03 PM', '3:09 AM', '7/28/2023');
insert into Smena (Casdo, Casod, Datumod) values ('6:32 PM', '12:08 PM', '6/2/2023');

insert into Adresa (Cislopopisne, Psc, Ulice) values (1, '526', 'Reinke Drive');
insert into Adresa (Cislopopisne, Psc, Ulice) values (2, '86', 'Schmedeman Plaza');
insert into Adresa (Cislopopisne, Psc, Ulice) values (3, '82916', 'Redwing Road');
insert into Adresa (Cislopopisne, Psc, Ulice) values (4, '75779', 'Ilene Road');
insert into Adresa (Cislopopisne, Psc, Ulice) values (5, '5596', 'Ridgeview Circle');
insert into Adresa (Cislopopisne, Psc, Ulice) values (6, '90', 'Kim Center');
insert into Adresa (Cislopopisne, Psc, Ulice) values (7, '9962', 'Caliangt Drive');
insert into Adresa (Cislopopisne, Psc, Ulice) values (8, '9172', 'Veith Way');
insert into Adresa (Cislopopisne, Psc, Ulice) values (9, '041', 'Scott Point');
insert into Adresa (Cislopopisne, Psc, Ulice) values (10, '297', 'Claremont Terrace');
go
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID) values ('tdrains0@un.org', 'Trixi', 'Drains', 1, '790-313-8661',1);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID) values ('nstoyles1@gravatar.com', 'Nettie', 'Stoyles', 2, '364-264-1388',2);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID) values ('rgorthy2@dedecms.com', 'Rosalind', 'Gorthy', 3, '826-915-8978',3);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon, WebovyucetID) values ('dmcwilliam3@spotify.com', 'Darbie', 'McWilliam', 4, '949-471-1631',4);
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon) values ('jdunk4@europa.eu', 'Jasmine', 'Dunk', 5, '763-239-7806');
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon) values ('sagg5@nbcnews.com', 'Simona', 'Agg', 6, '559-185-4895');
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon) values ('carkcoll6@sciencedirect.com', 'Cally', 'Arkcoll', 7, '162-747-0490');
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon) values ('sbargery7@qq.com', 'Shayne', 'Bargery', 8, '298-497-2124');
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon) values ('dboniface8@bandcamp.com', 'Demetra', 'Boniface', 9, '920-217-4163');
insert into Zamestnanec (Email, Jmeno, Prijmeni, Rodnecislo, Telefon) values ('basple9@pbs.org', 'Brigitte', 'Asple', 10, '252-907-1372');
go
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$qfSuOcDcSuh1IwxmPZmmdeaSJDySEokS/h4CiwsmWRsXefZfmfoR2', 'mmansfield0', 'admin');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$Lz/mm5WCFOmGOjLyBzsh9eLswz3vhQzChvAIFTzCde749T8HIeQMW', 'acockshtt1', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$KMb7O/hoasfUwFwVr9JJDuotKgo.5W.cjEh6zG5.VXNuNE6pJiIUq', 'crealff2', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$bXsbfrTFmRrM/IXU3PO2q.14tEXbu5q1pT9SLFECsTVA6j3pnoiiy', 'afernyhough3', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$odFPmI6b3AYG9YwYqUGzVOxux/8x4m5GV.12ELD.9NgxwMvI8zeLi', 'smacandie4', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$S6q7bRABIU8l/tjHVdlww.cl.NBl5E7LRP7Br9dVKAnPswAVaFNgK', 'dportis5', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$jiw1wObPgH.YF8YDk8UP5e57G//B9x1mQuq6/n4kjTNJk90fTskJy', 'klockhurst6', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$tY8oUbn5HQnd3aGPPKCkpujwuO0HOWTSyPPd.JqXGN.aj9UUiV9.q', 'jbrunelleschi7', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$K5mBeljUxRhsXkXfzEEJxe0Cj5H.zHdZr5GtTfewiOmEUNoWcmxsm', 'vpleasaunce8', 'user');
insert into Webovyucet (Heslohash, Jmeno, Typuctu) values ('$2a$04$clsCyW845YQQtx2rDD/kQ.Ktfg3lUP9zpZMR.WuT46Iu7d7aPlG4y', 'mishchenko9', 'user');
go
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$7.05', '/I=', 'Panda2',2);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$9.33', '','iadfs', 2);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$9.04', 'Bo6AAAASUCYII=','Har', 3);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$3.47', '0Gg0=','Pod', 4);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$3.73', 'C','Ollo', 5);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$8.79', 'mCC','Hala', 6);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$1.68', '','ses', 7);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$3.00', 'mCC','Ulk', 8);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$7.06', 'QmCC','Palla', 9);
insert into Tovarna (Cenazakwh, Foto, Nazev, AdresaID) values ('$4.92', 'kSuQmCC','Gord', 10);

go
insert into Hala (Oznaceni, TovarnaID) values ('A',1);
insert into Hala (Oznaceni, TovarnaID) values ('B',1);
insert into Hala (Oznaceni, TovarnaID) values ('A1',2);
insert into Hala (Oznaceni, TovarnaID) values ('A',3);
insert into Hala (Oznaceni, TovarnaID) values ('A2',2);
insert into Hala (Oznaceni, TovarnaID) values ('B',3);
insert into Hala (Oznaceni, TovarnaID) values ('C',1);
insert into Hala (Oznaceni, TovarnaID) values ('D',1);
insert into Hala (Oznaceni, TovarnaID) values ('B1',2);
insert into Hala (Oznaceni, TovarnaID) values ('C',3);
go
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (1, 'It', 1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (2, 'Viva',1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (3, 'Domainer',1);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (4, 'Viva',2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (5, 'Sonsing',3);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (6, 'Stringtough',2);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (7, 'Sonsing',5);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (8, 'Hatity',4);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (9, 'Zaam-Dox',9);
insert into Zarizeni (Oznaceni, Nazev, HalaID) values (10, 'Redhold',9);

go
insert into Zaznamopouziti (Datumcas, ZamestnanecID, ZarizeniID) values ('2021-04-15 03:24:43', 1, 1),
('2020-11-22 11:43:48', 1, 1),
('2020-05-27 04:52:14', 1, 1),
('2023-10-11 23:35:04', 1, 1),
('2021-06-26 16:18:47', 1, 1),
('2020-11-11 01:23:36', 1, 1),
('2023-01-10 15:28:18', 1, 1),
('2020-04-16 16:05:03', 1, 1),
('2021-10-20 04:09:38', 1, 1),
('2021-03-29 18:10:19', 1, 1);

go
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2021-05-02 08:39:34', 32.4, 1);
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2020-11-05 23:31:21', 86.2, 1);
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2021-06-05 10:20:44', 50.9, 1);
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2020-11-04 18:01:58', 99.5, 1);
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2022-08-10 07:14:10', 73.4, 1);
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2022-12-17 23:21:53', 100.0, 1);
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2023-07-08 11:32:49', 37.5, 1);
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2020-10-07 19:39:48', 55.8, 1);
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2023-11-08 13:51:43', 38.4, 1);
insert into Zaznamospotrebe (Datumcas, Spotreba, ZarizeniID) values ('2023-10-30 03:47:47', 87.7, 1);
go