DELIMITER ;
CREATE TABLE IF NOT EXISTS `kandidaten` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) DEFAULT NULL,
  `aktiv` tinyint(4) DEFAULT 0,
  `titel` varchar(255) DEFAULT NULL,
  `vorname` varchar(255) DEFAULT NULL,
  `nachname` varchar(255) DEFAULT NULL,
  `telefon` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `www` varchar(255) DEFAULT NULL,
  `barcode` varchar(5) DEFAULT '0',
  `firma1` varchar(255) DEFAULT NULL,
  `firma2` varchar(255) DEFAULT NULL,
  `firma3` varchar(255) DEFAULT NULL,
  `firma4` varchar(255) DEFAULT NULL,
  `firma_strasse` varchar(255) DEFAULT NULL,
  `firma_plz` varchar(255) DEFAULT NULL,
  `firma_ort` varchar(255) DEFAULT NULL,
  `stimmzettelgruppen` varchar(12) DEFAULT NULL,
  `funktion1` varchar(255) DEFAULT NULL,
  `funktion2` varchar(255) DEFAULT NULL,
  `funktion3` varchar(255) DEFAULT NULL,
  `firmen_identnummer` varchar(15) DEFAULT NULL,
  `personen_identnummer` varchar(15) DEFAULT NULL,
  `geburtsdatum` date DEFAULT NULL,
  `geschlecht` varchar(5) DEFAULT NULL,
  `andrede` varchar(100) DEFAULT NULL,
  `geburtsjahr` varchar(5) DEFAULT NULL,
  `branche` varchar(255) DEFAULT NULL,
  `losung_verloren` tinyint(4) DEFAULT 0,
  `nachruecker` tinyint(4) DEFAULT 0,
  `kooptiert` tinyint(4) DEFAULT 0,
  `losnummer_stimmzettelgruppe` int(11) DEFAULT 0,
  `losnummer` int(11) DEFAULT 0,
  `ist_gewaehlt` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_kandidaten_ridx` (`ridx`),
  KEY `fk_kandidaten_stimmzettelgruppen` (`stimmzettelgruppen`),
  CONSTRAINT `fk_kandidaten_stimmzettelgruppen` FOREIGN KEY (`stimmzettelgruppen`) REFERENCES `stimmzettelgruppen` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);
