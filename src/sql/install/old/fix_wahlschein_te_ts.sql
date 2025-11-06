/*

Wird nicht installiert, nur zum manuelle update gedacht.

*/

drop table wahlschein;
drop table wahlzeichnungsberechtigter;
drop table wahlberechtigte;


CREATE TABLE IF NOT EXISTS `wahlberechtigte` (
  `id` bigint(20) NOT NULL,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `ridx` varchar(14) DEFAULT NULL,
  `insert_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `aktiv` tinyint DEFAULT 0,
  `identnummer` varchar(255) DEFAULT NULL,
  `identkurz` int(11) DEFAULT 0,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `uidx_wahlberechtigte_ridx` (`ridx`),
  KEY `idx_wahlberechtigte_identnummer` (`identnummer`)
) ;


CREATE TABLE IF NOT EXISTS `wahlzeichnungsberechtigter` (
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
    wahlberechtigte VARCHAR(14),
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

CREATE TABLE IF NOT EXISTS `wahlschein` (
  `ridx` varchar(14) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` tinyint DEFAULT 1,
  `insert_date` date NOT NULL,
  `insert_time` time DEFAULT NULL,
  `update_date` date NOT NULL,
  `update_time` time DEFAULT NULL,

  `login` varchar(255) NOT NULL,
  `stimmzettel` varchar(12) NOT NULL,
  `wahlscheinnummer` varchar(255) DEFAULT NULL,
  `wahlberechtigte` varchar(14) DEFAULT NULL,
  `wahlscheinstatus` varchar(12) DEFAULT NULL,
  `wahlscheinstatus_grund` varchar(255) DEFAULT NULL,
  `abgabetyp` varchar(255) DEFAULT NULL,
  `pwhash` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `abgabehash` varchar(255) DEFAULT NULL,
  `sendtotmg` tinyint(4) DEFAULT 0,
  `antrag` tinyint(4) DEFAULT 0,
  `blocknumber` varchar(30) DEFAULT '0',
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `defered` tinyint(4) DEFAULT 0,
  `secret` varchar(500) DEFAULT NULL,
  `onlinecheck` tinyint(4) DEFAULT 0,
  `testdaten` tinyint(4) DEFAULT 0,
  `kombiniert`bigint(20) DEFAULT NULL,
  `usedate` date DEFAULT NULL,
  PRIMARY KEY (`id`,`stimmzettel`),

  KEY `idx_wahlschein_wahlscheinstatus` (`wahlscheinstatus`),
  KEY `idx_wahlschein_wahlscheinstatus_grund` (`wahlscheinstatus_grund`),
  KEY `idx_wahlschein_wahlberechtigte` (`wahlberechtigte`),
  KEY `idx_wahlschein_wahlscheinnummer` (`wahlscheinnummer`),
  KEY `idx_wahlschein_name` (`name`),
  KEY `idx_wahlschein_abgabetyp` (`abgabetyp`),
  KEY `idx_wahlschein_sendtotmg` (`sendtotmg`),
  KEY `fk_wahlschein_stimmzettel` (`stimmzettel`),
  KEY `uidx_wahlschein_username` (`username`),
  KEY `idx_wahlschein_blocknumber` (`blocknumber`),
  CONSTRAINT `fk_wahlschein_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlschein_wahlberechtigte` FOREIGN KEY (`wahlberechtigte`) REFERENCES `wahlberechtigte` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlschein_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);




call setupWahlscheinVersioning();


