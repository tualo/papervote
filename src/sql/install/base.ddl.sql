DELIMITER ;

insert
    ignore into ds_class (class_name)
values
    ('Wahlsystem');

CREATE TABLE IF NOT EXISTS abgabetyp (
    ridx VARCHAR(12),
    id INT DEFAULT 0 NOT NULL,
    kostenstelle INT DEFAULT 0 NOT NULL,
    name VARCHAR(255),
    aktiv INT DEFAULT 1,
    insert_date DATE NOT NULL,
    update_date DATE NOT NULL,
    login VARCHAR(255) NOT NULL,
    insert_time TIME,
    update_time TIME,
    PRIMARY KEY (id, kostenstelle),
    CONSTRAINT idx_abgabetyp UNIQUE (ridx),
    CONSTRAINT idx_abgabetyp_ridx UNIQUE (ridx)
);

INSERT
    IGNORE INTO abgabetyp (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        insert_time,
        update_time
    )
VALUES
    (
        '1|0',
        1,
        0,
        'Briefwahl',
        1,
        '2011-10-19',
        '2011-10-19',
        'ADMIN',
        null,
        null
    );

INSERT
    IGNORE INTO abgabetyp (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        insert_time,
        update_time
    )
VALUES
    (
        '2|0',
        2,
        0,
        'Onlinewahl',
        1,
        '2011-10-19',
        '2011-10-19',
        'ADMIN',
        null,
        null
    );

CREATE TABLE IF NOT EXISTS wahltyp (
    ridx VARCHAR(12),
    id INT DEFAULT 0 NOT NULL,
    kostenstelle INT DEFAULT 0 NOT NULL,
    name VARCHAR(255),
    aktiv TINYINT DEFAULT 1,
    insert_date DATE NOT NULL,
    update_date DATE NOT NULL,
    login VARCHAR(255) NOT NULL,
    insert_time TIME,
    update_time TIME,
    feld VARCHAR(255),
    stimmzettelfeld VARCHAR(255),
    import_field VARCHAR(25),
    PRIMARY KEY (id, kostenstelle),
    CONSTRAINT idx_wahltyp UNIQUE (ridx),
    CONSTRAINT idx_wahltyp_ridx UNIQUE (ridx)
);

INSERT
    IGNORE INTO wahltyp (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        insert_time,
        update_time,
        feld,
        stimmzettelfeld,
        import_field
    )
VALUES
    (
        '1|0',
        1,
        0,
        'Vollversammlungswahl',
        1,
        '2017-07-25',
        '2017-07-25',
        'thomas.hoffmann@tualo.de',
        '11:45:54',
        '11:45:54',
        'wahlscheinstatus',
        'stimmzettel',
        'vv'
    );

INSERT
    IGNORE INTO wahltyp (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        insert_time,
        update_time,
        feld,
        stimmzettelfeld,
        import_field
    )
VALUES
    (
        '2|0',
        2,
        0,
        'Gremialwahl',
        1,
        '2017-07-25',
        '2017-07-25',
        'thomas.hoffmann@tualo.de',
        '11:45:54',
        '11:45:54',
        'wahlscheinstatus',
        'stimmzettel',
        ''
    );

INSERT
    IGNORE INTO wahltyp (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        insert_time,
        update_time,
        feld,
        stimmzettelfeld,
        import_field
    )
VALUES
    (
        '3|0',
        3,
        0,
        'Plenarwahl',
        0,
        '2017-07-25',
        '2017-07-25',
        'thomas.hoffmann@tualo.de',
        '11:45:54',
        '11:45:54',
        'wahlscheinstatus_plenar',
        'stimmzettel_plenar',
        null
    );

INSERT
    IGNORE INTO wahltyp (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        insert_time,
        update_time,
        feld,
        stimmzettelfeld,
        import_field
    )
VALUES
    (
        '4|0',
        4,
        0,
        'Regionalausschuss',
        0,
        '2021-02-03',
        '2021-02-03',
        '{login}',
        '16:25:21',
        '16:25:21',
        'wahlscheinstatus',
        'stimmzettel',
        'ra'
    );

CREATE TABLE IF NOT EXISTS wahlscheinstatus (
    ridx VARCHAR(12),
    id INT DEFAULT 0 NOT NULL,
    kostenstelle INT DEFAULT 0 NOT NULL,
    name VARCHAR(255),
    aktiv TINYINT DEFAULT 1,
    insert_date DATE NOT NULL,
    update_date DATE NOT NULL,
    login VARCHAR(255) NOT NULL,
    fibukonto VARCHAR(20),
    steuerschluessel VARCHAR(20),
    beschreibung VARCHAR(4000),
    insert_time TIME,
    update_time TIME,
    barcode VARCHAR(255),
    farbe VARCHAR(255),
    ohne_wahlberechtigten VARCHAR(255),
    sz_count INT DEFAULT 0,
    PRIMARY KEY (id, kostenstelle),
    CONSTRAINT idx_wahlscheinstatus UNIQUE (ridx),
    CONSTRAINT idx_wahlscheinstatus_ridx UNIQUE (ridx)
);

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '-1|0',
        -1,
        0,
        'mit TAN entsperrt',
        0,
        '2020-08-25',
        '2020-08-25',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        null,
        '15:50:48',
        '15:50:48',
        'FC999999',
        'rgb(111,111,111)',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '1|0',
        1,
        0,
        'unbekannt',
        0,
        '2011-10-19',
        '2016-01-28',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        null,
        '14:19:52',
        'FC212',
        'rgb(111,111,111)',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '2|0',
        2,
        0,
        'angenommen',
        1,
        '2011-10-19',
        '2012-03-26',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '09:38:38',
        '14:19:52',
        'FC210',
        '#20ff20',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '3|0',
        3,
        0,
        'ungültig',
        1,
        '2011-10-19',
        '2016-01-27',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '09:38:52',
        '14:19:52',
        'FC213',
        '#ff2020',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '4|0',
        4,
        0,
        'zurückgewiesen',
        1,
        '2011-10-19',
        '2016-01-27',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '12:22:23',
        '14:19:52',
        'FC215',
        '#080808',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '5|0',
        5,
        0,
        'unzustellbar',
        0,
        '2011-10-19',
        '2015-11-19',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '08:29:35',
        '14:19:52',
        'FC214',
        '#2020ff',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '7|0',
        7,
        0,
        'neue Wahlunterlagen generiert',
        0,
        '2012-04-20',
        '2014-07-04',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '12:58:20',
        '14:19:52',
        'FC9999',
        'rgb(111,111,111)',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '8|0',
        8,
        0,
        'Klärung',
        1,
        '2012-04-30',
        '2012-04-30',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '10:25:39',
        '14:19:52',
        'FC216',
        '#20ffff',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '9|0',
        9,
        0,
        'nicht gewählt',
        0,
        '2014-01-21',
        '2014-07-04',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        null,
        '14:19:52',
        'FC217',
        'rgb(111,111,111)',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '10|0',
        10,
        0,
        'ohne Wahlschein',
        0,
        '2014-02-18',
        '2014-02-18',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '12:58:27',
        '14:19:52',
        'FC9998',
        'rgb(111,111,111)',
        '1',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '11|0',
        11,
        0,
        'Korrektur',
        0,
        '2014-02-18',
        '2014-07-04',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '12:58:32',
        '14:19:52',
        'FC9997',
        'rgb(111,111,111)',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '12|0',
        12,
        0,
        'verspätet eingegangen',
        0,
        '2014-02-19',
        '2014-07-04',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '09:39:17',
        '14:19:52',
        'FC991',
        '#000000',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '13|0',
        13,
        0,
        'inaktiv',
        0,
        '2014-07-04',
        '2015-06-17',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '18:11:26',
        '14:19:52',
        'FC230',
        'rgb(111,111,111)',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '14|0',
        14,
        0,
        'eaktiv',
        0,
        '2014-07-28',
        '2015-06-05',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        null,
        '14:19:52',
        'FC231',
        'rgb(111,111,111)',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '16|0',
        16,
        0,
        'neue Wahlunterlagen',
        null,
        '2017-04-03',
        '2017-04-24',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        null,
        null,
        '14:19:52',
        'FC278',
        'rgb(255,182,193)',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '17|0',
        17,
        0,
        'Anlage',
        0,
        '2017-09-20',
        '2017-09-20',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '14:23:49',
        '14:27:03',
        'FC9995',
        'rgb(111,111,111)',
        '0',
        0
    );

INSERT
    IGNORE INTO wahlscheinstatus (
        ridx,
        id,
        kostenstelle,
        name,
        aktiv,
        insert_date,
        update_date,
        login,
        fibukonto,
        steuerschluessel,
        beschreibung,
        insert_time,
        update_time,
        barcode,
        farbe,
        ohne_wahlberechtigten,
        sz_count
    )
VALUES
    (
        '30|0',
        30,
        0,
        'Briefwahlunterlagen',
        0,
        '2019-12-18',
        '2019-12-18',
        'thomas.hoffmann@tualo.de',
        '',
        '',
        '',
        '11:05:27',
        '11:05:27',
        'FC9994',
        'rgb(111,111,111)',
        '0',
        0
    );

CREATE TABLE IF NOT EXISTS wahlbezirk (
    ridx VARCHAR(12),
    id INT DEFAULT 0 NOT NULL,
    kostenstelle INT DEFAULT 0 NOT NULL,
    name VARCHAR(255),
    aktiv INT DEFAULT 1,
    insert_date DATE NOT NULL,
    update_date DATE NOT NULL,
    login VARCHAR(255) NOT NULL,
    zuweisungsschluessel VARCHAR(255) DEFAULT '0',
    insert_time TIME,
    update_time TIME,
    kurzbezeichnung VARCHAR(255),
    PRIMARY KEY (id, kostenstelle),
    CONSTRAINT idx_wahlbezirk UNIQUE (ridx),
    CONSTRAINT idx_wahlbezirk_ridx UNIQUE (ridx)
);

CREATE TABLE IF NOT EXISTS wahlgruppe (
    ridx VARCHAR(12),
    id INT DEFAULT 0 NOT NULL,
    kostenstelle INT DEFAULT 0 NOT NULL,
    name VARCHAR(255),
    aktiv INT DEFAULT 1,
    insert_date DATE NOT NULL,
    update_date DATE NOT NULL,
    login VARCHAR(255) NOT NULL,
    zuweisungsschluessel VARCHAR(255) DEFAULT '0',
    insert_time TIME,
    update_time TIME,
    kurzbezeichnung VARCHAR(255),
    PRIMARY KEY (id, kostenstelle),
    CONSTRAINT idx_wahlgruppe UNIQUE (ridx),
    CONSTRAINT idx_wahlgruppe_ridx UNIQUE (ridx)
);

CREATE TABLE IF NOT EXISTS stimmzettel (
    ridx VARCHAR(12),
    id INT DEFAULT 0 NOT NULL,
    name VARCHAR(255),
    aktiv INT DEFAULT 1,
    insert_date DATE NOT NULL,
    insert_time TIME,
    update_date DATE NOT NULL,
    update_time TIME,
    login VARCHAR(255) NOT NULL,
    wahlgruppe VARCHAR(255) DEFAULT '0',
    wahlbezirk VARCHAR(255) DEFAULT '0',
    wahltyp VARCHAR(255) DEFAULT '0',
    sitze VARCHAR(255) DEFAULT '0',
    anzahl_10 INT DEFAULT 0,
    zaehlung_1 INT DEFAULT 0,
    zaehlung_2 INT DEFAULT 0,
    zaehlung_3 INT DEFAULT 0,
    zaehlung_4 INT DEFAULT 0,
    zaehlung_5 INT DEFAULT 0,
    zaehlung_6 INT DEFAULT 0,
    zaehlung_7 INT DEFAULT 0,
    zaehlung_8 INT DEFAULT 0,
    zaehlung_9 INT DEFAULT 0,
    sitzbindung VARCHAR(255),
    laufende_nummer_1_24__nach_zuordnung_wg_wb VARCHAR(255),
    anzahl_notwendige_bewerber_je_kombinummer VARCHAR(255),
    ds_count INT DEFAULT 0,
    ungueltig INT DEFAULT 0,
    farbe VARCHAR(100) DEFAULT 'rgb(159, 80, 152)',
    typtitel VARCHAR(100) DEFAULT 'Vollversammlungswahl',
    kandidat_text_einzel VARCHAR(50),
    kandidat_text_mehr VARCHAR(50),
    bh1 INT DEFAULT 120,
    bh2 INT DEFAULT 120,
    xlink VARCHAR(255),
    PRIMARY KEY (id),
    CONSTRAINT idx_stimmzettel_ridx UNIQUE (ridx),
    CONSTRAINT fk_stimmzettel_wahlgruppe FOREIGN KEY (wahlgruppe) REFERENCES `wahlgruppe` (`ridx`) ON
    DELETE CASCADE ON
    UPDATE CASCADE,
    CONSTRAINT fk_stimmzettel_wahlbezirk FOREIGN KEY (wahlbezirk) REFERENCES `wahlbezirk` (`ridx`) ON
    DELETE CASCADE ON
    UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS stimmzettelgruppen (
    ridx VARCHAR(12),
    id INT DEFAULT 0 NOT NULL,
    kostenstelle INT DEFAULT 0 NOT NULL,
    name VARCHAR(255),
    stimmzettel VARCHAR(12) NOT NULL,
    sitze INT DEFAULT 1,
    mindestsitze INT DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT fk_stimmzettelgruppen_stimmzettel FOREIGN KEY (stimmzettel) REFERENCES `stimmzettel` (`ridx`) ON 
    DELETE CASCADE ON 
    UPDATE CASCADE,
    CONSTRAINT uidx_stimmzettelgruppen_ridx UNIQUE (ridx),
    INDEX idx_stimmzettelgruppen_stimmzettel (stimmzettel)
);

CREATE TABLE IF NOT EXISTS kandidaten (
    ridx VARCHAR(12),
    id INT DEFAULT 0 NOT NULL,
    kostenstelle INT,
    aktiv TINYINT DEFAULT 0,
    titel VARCHAR(255),
    vorname VARCHAR(255),
    nachname VARCHAR(255),
    telefon VARCHAR(255),
    email VARCHAR(255),
    www VARCHAR(255),
    barcode VARCHAR(5) DEFAULT '0',
    firma1 VARCHAR(255),
    firma2 VARCHAR(255),
    firma3 VARCHAR(255),
    firma4 VARCHAR(255),
    firma_strasse VARCHAR(255),
    firma_plz VARCHAR(255),
    firma_ort VARCHAR(255),
    stimmzettelgruppen VARCHAR(12),
    funktion1 VARCHAR(255),
    funktion2 VARCHAR(255),
    funktion3 VARCHAR(255),
    firmen_identnummer VARCHAR(15),
    personen_identnummer VARCHAR(15),
    geburtsdatum DATE,
    geschlecht VARCHAR(5),
    andrede VARCHAR(100),
    geburtsjahr VARCHAR(5),
    branche VARCHAR(255),
    losung_verloren TINYINT DEFAULT 0,
    nachruecker TINYINT DEFAULT 0,
    kooptiert TINYINT DEFAULT 0,
    losnummer_stimmzettelgruppe INT DEFAULT 0,
    losnummer INT DEFAULT 0,
    ist_gewaehlt TINYINT DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT fk_kandidaten_stimmzettelgruppen FOREIGN KEY (stimmzettelgruppen) REFERENCES `stimmzettelgruppen` (`ridx`) ON 
    DELETE CASCADE ON 
    UPDATE CASCADE,
    INDEX fk_kandidaten_stimmzettelgruppen (stimmzettelgruppen),
    CONSTRAINT uidx_kandidaten_ridx UNIQUE (ridx)
);

create table IF NOT EXISTS kandidaten_bilder_typen (
    id varchar(12) primary key,
    name varchar(255) not null
);

insert
    ignore into kandidaten_bilder_typen (id, name)
values
    ('0', 'Barcode');

insert
    ignore into kandidaten_bilder_typen (id, name)
values
    ('1', 'Portrait');

create table IF NOT EXISTS kandidaten_bilder (
    id varchar(12) not null,
    kandidat varchar(12) not null,
    typ varchar(12) not null,
    file_id varchar(36) not null,
    foreign key (kandidat) references kandidaten(ridx) on delete cascade on update cascade,
    foreign key (typ) references kandidaten_bilder_typen(id) on delete cascade on update cascade,
    primary key (kandidat, typ)
);

CREATE VIEW  if not exists `view_readtable_kandidaten_bilder` AS
select
    `kandidaten_bilder`.`id` AS `id`,
    `kandidaten_bilder`.`kandidat` AS `kandidat`,
    `kandidaten_bilder`.`typ` AS `typ`,
    `ds_files`.`name` AS `__file_name`,
    `ds_files`.`path` AS `path`,
    `ds_files`.`size` AS `__file_size`,
    `ds_files`.`mtime` AS `mtime`,
    `ds_files`.`ctime` AS `ctime`,
    `ds_files`.`type` AS `__file_type`,
    `ds_files`.`file_id` AS `__file_id`,
    `ds_files`.`hash` AS `hash`,
    '' AS `__file_data`
from
    (
        `kandidaten_bilder`
        left join `ds_files` on(
            `kandidaten_bilder`.`file_id` = `ds_files`.`file_id`
        )
    );

CREATE TABLE IF NOT EXISTS wahlruecklauf_felder (
    id INT NOT NULL,
    kostenstelle INT DEFAULT 0 NOT NULL,
    ridx VARCHAR(255),
    insert_date DATE,
    update_date DATE,
    login VARCHAR(255),
    insert_time TIME,
    update_time TIME,
    aktiv VARCHAR(255),
    name VARCHAR(255),
    pos INT DEFAULT 1,
    PRIMARY KEY (id, kostenstelle)
);

CREATE TABLE IF NOT EXISTS wahlberechtigte (
    id bigint NOT NULL,
    kostenstelle INT DEFAULT 0 NOT NULL,
    ridx VARCHAR(12),
    insert_date DATE,
    update_date DATE,
    login VARCHAR(255),
    insert_time TIME,
    update_time TIME,
    aktiv VARCHAR(255),
    identnummer VARCHAR(255),
    identkurz INT DEFAULT 0,
    PRIMARY KEY (id, kostenstelle),
    CONSTRAINT uidx_wahlberechtigte_ridx UNIQUE (ridx),
    INDEX idx_wahlberechtigte_identnummer (identnummer)
);

CREATE TABLE IF NOT EXISTS wahlzeichnungsberechtigter (
    id INT NOT NULL,
    kostenstelle INT DEFAULT 0 NOT NULL,
    ridx VARCHAR(255),
    insert_date DATE,
    update_date DATE,
    login VARCHAR(255),
    insert_time TIME,
    update_time TIME,
    aktiv VARCHAR(255),
    name VARCHAR(255),
    funktion VARCHAR(255),
    personenident VARCHAR(255),
    wahlberechtigte VARCHAR(255),
    geburtsdatum DATE,
    vorname VARCHAR(255),
    nachname VARCHAR(255),
    namenstitel VARCHAR(255),
    nachtitel VARCHAR(255),
    PRIMARY KEY (id, kostenstelle),
    INDEX idx_wahlzeichnungsberechtigter_wahlberechtigte (wahlberechtigte),
    CONSTRAINT fk_wahlzeichnungsberechtigter_wahlberechtigte FOREIGN KEY (wahlberechtigte) REFERENCES `wahlberechtigte` (`ridx`) ON
    DELETE CASCADE ON
    UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS wahlschein (
    ridx VARCHAR(12),
    id bigint NOT NULL,
    name VARCHAR(255),
    aktiv INT DEFAULT 1,
    insert_date DATE NOT NULL,
    insert_time TIME,
    update_date DATE NOT NULL,
    update_time TIME,
    login VARCHAR(255) NOT NULL,
    stimmzettel VARCHAR(12) NOT NULL,
    wahlscheinnummer VARCHAR(255),
    wahlberechtigte VARCHAR(12),
    wahlscheinstatus VARCHAR(12),
    wahlscheinstatus_grund VARCHAR(255),
    abgabetyp VARCHAR(255),
    pwhash VARCHAR(255),
    username VARCHAR(255),
    abgabehash VARCHAR(255),
    sendtotmg TINYINT DEFAULT 0,
    antrag TINYINT DEFAULT 0,
    blocknumber VARCHAR(30) DEFAULT '0',
    kostenstelle INT DEFAULT 0 NOT NULL,
    defered TINYINT DEFAULT 0,
    secret VARCHAR(500),
    onlinecheck TINYINT DEFAULT 0,
    testdaten TINYINT DEFAULT 0,
    usedate DATE,
    PRIMARY KEY (id, stimmzettel),
    CONSTRAINT fk_wahlschein_stimmzettel FOREIGN KEY (stimmzettel) REFERENCES `stimmzettel` (`ridx`) ON 
    DELETE CASCADE ON 
    UPDATE CASCADE,
    CONSTRAINT fk_wahlschein_wahlscheinstatus FOREIGN KEY (wahlscheinstatus) REFERENCES `wahlscheinstatus` (`ridx`) ON 
    DELETE CASCADE ON 
    UPDATE CASCADE,
    CONSTRAINT idx_wahlschein UNIQUE (ridx),
    CONSTRAINT idx_wahlschein_ridx UNIQUE (ridx),
    INDEX idx_wahlschein_wahlscheinstatus (wahlscheinstatus),
    INDEX idx_wahlschein_wahlscheinstatus_grund (wahlscheinstatus_grund),
    INDEX idx_wahlschein_wahlberechtigte (wahlberechtigte),
    INDEX idx_wahlschein_wahlscheinnummer (wahlscheinnummer),
    INDEX idx_wahlschein_name (name),
    INDEX idx_wahlschein_abgabetyp (abgabetyp),
    INDEX idx_wahlschein_sendtotmg (sendtotmg),
    INDEX fk_wahlschein_stimmzettel (stimmzettel),
    INDEX uidx_wahlschein_username (username),
    INDEX idx_wahlschein_blocknumber (blocknumber),
    CONSTRAINT `fk_wahlschein_wahlberechtigte` FOREIGN KEY (`wahlberechtigte`) REFERENCES `wahlberechtigte` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS wahlberechtigte_anlage (
    identnummer VARCHAR(20) NOT NULL,
    stimmzettel VARCHAR(12) NOT NULL,
    wahlscheinnummer VARCHAR(12),
    kombiniert bigint,
    testdaten TINYINT DEFAULT 0,
    username VARCHAR(10),
    pwhash VARCHAR(100),
    PRIMARY KEY (identnummer, stimmzettel),
    INDEX idx_wahlberechtigte_anlage_wahlscheinnummer (wahlscheinnummer),
    INDEX idx_wahlberechtigte_anlage_identnummer (identnummer)
);

CREATE TABLE IF NOT EXISTS nachzaehlung(
    id varchar(20) primary key,
    login varchar(50),
    ctime datetime
);

create table if not exists wahlschein_blocknumbers (
    blocknumber varchar(30) primary key,
    login varchar(94),
    lastlogin varchar(94),
    createtime datetime,
    lastinsert datetime
);

create table if not exists wm_tualo_api_logfile (
    id varchar(36) primary key,
    type varchar(10),
    createtime timestamp,
    uri varchar(255),
    data longtext
);

create   view if not exists stimmzettel_default as
select
    stimmzettel.*,
    stimmzettel.ridx group_ridx
from
stimmzettel;