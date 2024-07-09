DELIMITER ;
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