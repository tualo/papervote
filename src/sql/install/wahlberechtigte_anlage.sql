DELIMITER;

CREATE TABLE IF NOT EXISTS `wahlberechtigte_anlage` (
  `identnummer` varchar(20) NOT NULL,
  `stimmzettel` varchar(12) NOT NULL,
  `wahlscheinnummer` varchar(12) DEFAULT NULL,
  `kombiniert` bigint(20) DEFAULT NULL,
  `testdaten` tinyint(4) DEFAULT 0,
  `username` varchar(10) DEFAULT NULL,
  `pwhash` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`identnummer`,`stimmzettel`),
  KEY `idx_wahlberechtigte_anlage_wahlscheinnummer` (`wahlscheinnummer`),
  KEY `idx_wahlberechtigte_anlage_identnummer` (`identnummer`)
);